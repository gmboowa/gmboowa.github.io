#!/usr/bin/env python3
"""Collect candidate journal-brand images from official publisher pages.

Run in the root of the Jekyll website. Requires beautifulsoup4 (already used by
recover_journals.py). Uses only Python standard library for HTTPS downloads.

Safety: never overwrites existing logos; never alters journals.json without
--apply. --apply accepts ONLY manifest rows manually marked approved=true.
"""
import argparse
import csv
import hashlib
import json
import re
import time
from pathlib import Path
from urllib.error import HTTPError, URLError
from urllib.parse import urljoin, urlparse
from urllib.request import Request, urlopen
from bs4 import BeautifulSoup

ROOT = Path.cwd()
DATA = ROOT / '_data' / 'journals.json'
OUT = ROOT / 'assets' / 'img' / 'journal_logos'
REVIEW = ROOT / 'journal_logo_review.csv'

# Verified or publisher-specific journal landing pages; only publisher-owned sites.
OFFICIAL = {
    'Scientific Reports': 'https://www.nature.com/srep/',
    'Bioinformatics Advances': 'https://academic.oup.com/bioinformaticsadvances',
    'Malaria Journal': 'https://malariajournal.biomedcentral.com/',
    'PLOS Global Public Health': 'https://journals.plos.org/globalpublichealth/',
    'Frontiers in Public Health': 'https://www.frontiersin.org/journals/public-health',
    'Frontiers in Microbiology': 'https://www.frontiersin.org/journals/microbiology',
    'Frontiers in Bioinformatics': 'https://www.frontiersin.org/journals/bioinformatics',
    'Frontiers in Artificial Intelligence': 'https://www.frontiersin.org/journals/artificial-intelligence',
    'Journal of Clinical Microbiology': 'https://journals.asm.org/journal/jcm',
    'Antimicrobial Agents and Chemotherapy': 'https://journals.asm.org/journal/aac',
    'Antimicrobial Resistance & Infection Control': 'https://aricjournal.biomedcentral.com/',
    'BMC Microbiology': 'https://bmcmicrobiol.biomedcentral.com/',
    'Briefings in Bioinformatics': 'https://academic.oup.com/bib',
    'The Journal of Infectious Diseases': 'https://academic.oup.com/jid',
    'Open Forum Infectious Diseases': 'https://academic.oup.com/ofid',
    'The American Journal of Human Genetics': 'https://www.cell.com/ajhg/home',
    'Genetics in Medicine': 'https://www.nature.com/gim/',
    'npj Genomic Medicine': 'https://www.nature.com/npjgenmed/',
    'Genes': 'https://www.mdpi.com/journal/genes',
    'Tropical Medicine and Infectious Disease': 'https://www.mdpi.com/journal/tropicalmed',
    'Microbial Pathogenesis': 'https://www.sciencedirect.com/journal/microbial-pathogenesis',
    'Journal of Hospital Infection': 'https://www.journalofhospitalinfection.com/',
    'Microbiology Resource Announcements': 'https://journals.asm.org/journal/mra',
    'Molecular Genetics & Genomic Medicine': 'https://onlinelibrary.wiley.com/journal/23249269',
    'Journal of Clinical Microbiology': 'https://journals.asm.org/journal/jcm',
    'Immunogenetics': 'https://link.springer.com/journal/251',
    'Annals of Human Genetics': 'https://onlinelibrary.wiley.com/journal/14691809',
    'Genome': 'https://cdnsciencepub.com/journal/gen',
    'BioMed Research International': 'https://onlinelibrary.wiley.com/journal/23146141',
    'New Microbes and New Infections': 'https://www.sciencedirect.com/journal/new-microbes-and-new-infections',
    'The American Journal of Tropical Medicine and Hygiene': 'https://www.ajtmh.org/',
    'Livers': 'https://www.mdpi.com/journal/livers',
    'Scientific African': 'https://www.sciencedirect.com/journal/scientific-african',
    'Tropical Animal Health and Production': 'https://link.springer.com/journal/11250',
    'Microbiology Resource Announcements': 'https://journals.asm.org/journal/mra',
}

ALLOWED = ('nature.com', 'springer.com', 'biomedcentral.com', 'plos.org',
           'oup.com', 'frontiersin.org', 'asm.org', 'mdpi.com', 'cell.com',
           'sciencedirect.com', 'elsevier.com', 'wiley.com', 'journalofhospitalinfection.com',
           'cdnsciencepub.com', 'ajtmh.org', 'microbiologyresearch.org',
           'cloudfront.net', 'springernature.com', 'wileycdn.com', 'oup.com',
           'static-content.springer.com')

HEADERS = {'User-Agent': 'Mozilla/5.0 (compatible; AcademicSiteJournalLogoCheck/1.0; personal noncommercial website)',
           'Accept': 'text/html,image/avif,image/webp,image/png,image/svg+xml,image/jpeg,*/*'}

def official_domain(url):
    host = (urlparse(url).hostname or '').lower()
    return any(host == x or host.endswith('.' + x) for x in ALLOWED)

def fetch(url, limit=5_000_000):
    req = Request(url, headers=HEADERS)
    with urlopen(req, timeout=18) as res:
        actual = res.geturl()
        data = res.read(limit + 1)
        if len(data) > limit:
            raise ValueError('response too large')
        return data, actual, res.headers.get('Content-Type', '')

def norm(text):
    return re.sub(r'[^a-z0-9]+', ' ', text.lower()).strip()

def matches_journal(journal, description):
    # Require the full distinctive journal name, not merely publisher identity.
    j = norm(journal)
    d = norm(description)
    return bool(j) and (j in d or j.replace('the ', '', 1) in d)

def image_candidates(soup, base, journal):
    seen = set()
    for tag in soup.select('img[src], img[data-src], img[data-original]'):
        raw = tag.get('src') or tag.get('data-src') or tag.get('data-original')
        if not raw or raw.startswith('data:'):
            continue
        desc = ' '.join([tag.get('alt', ''), tag.get('title', ''), raw])
        url = urljoin(base, raw)
        if url not in seen and official_domain(url) and matches_journal(journal, desc):
            seen.add(url)
            yield url, desc
    # Page-level journal branding sometimes uses background images or svg.
    for tag in soup.select('[style*="background-image"]'):
        desc = ' '.join([tag.get('aria-label', ''), tag.get('title', ''), tag.get('style', '')])
        if matches_journal(journal, desc):
            m = re.search(r'url\([\'\"]?([^\)\'\"]+)', tag.get('style', ''))
            if m:
                url = urljoin(base, m.group(1))
                if url not in seen and official_domain(url):
                    yield url, desc

def picture_ext(raw, ct):
    sig = raw[:64].lstrip()
    ct = ct.lower()
    if raw.startswith(b'\x89PNG\r\n\x1a\n'): return '.png'
    if raw.startswith(b'\xff\xd8\xff'): return '.jpg'
    if raw[:4] == b'RIFF' and raw[8:12] == b'WEBP': return '.webp'
    if b'<svg' in raw[:1500].lower() and ('svg' in ct or sig.startswith(b'<') or sig.startswith(b'<?xml')): return '.svg'
    return None

def slug(name):
    return re.sub(r'[^a-z0-9]+', '-', name.lower()).strip('-')

def collect():
    if not DATA.exists():
        raise SystemExit(f'Missing {DATA}; run recover_journals.py first')
    journals = json.loads(DATA.read_text(encoding='utf8'))
    OUT.mkdir(parents=True, exist_ok=True)
    rows = []
    for name, details in sorted(journals.items()):
        current = details.get('logo', '')
        if current and (OUT / current).is_file():
            continue
        page = OFFICIAL.get(name, '')
        row = {'journal':name, 'official_page':page, 'candidate_file':'',
               'image_url':'', 'image_description':'', 'status':'', 'approved':'false'}
        if not page:
            row['status'] = 'NEEDS_OFFICIAL_PAGE'
            rows.append(row); continue
        try:
            html, final_page, ct = fetch(page)
            if not official_domain(final_page) or 'html' not in ct.lower():
                raise ValueError('page redirected outside approved publisher domains or not HTML')
            soup = BeautifulSoup(html, 'html.parser')
            found = False
            for url, description in image_candidates(soup, final_page, name):
                try:
                    data, real_url, content_type = fetch(url)
                    if not official_domain(real_url): continue
                    ext = picture_ext(data, content_type)
                    if not ext or len(data) < 300: continue
                    filename = slug(name) + '-official-candidate-' + hashlib.sha256(data).hexdigest()[:8] + ext
                    dest = OUT / filename
                    if not dest.exists(): dest.write_bytes(data)
                    row.update({'candidate_file':filename, 'image_url':real_url,
                                'image_description':description[:220],
                                'status':'REVIEW_CANDIDATE'})
                    found=True; break
                except (OSError, HTTPError, URLError, ValueError) as e:
                    continue
            if not found:
                row['status']='NO_CONFIDENT_IMAGE_FOUND'
        except Exception as e:
            row['status']='FETCH_FAILED: ' + str(e)[:100]
        rows.append(row)
        print(f'{name}: {row["status"]}', flush=True)
        time.sleep(0.6)
    with REVIEW.open('w', newline='', encoding='utf-8') as f:
        w=csv.DictWriter(f, fieldnames=['journal','official_page','candidate_file','image_url','image_description','status','approved']);w.writeheader();w.writerows(rows)
    print(f'\nChecked {len(rows)} missing-logo journals. Review: {REVIEW}')
    print('Only set approved=true after looking at each image and confirming it is the JOURNAL logo.')
    print('Then: python3 recover_official_journal_logos.py --apply')

def apply():
    journals=json.loads(DATA.read_text(encoding='utf-8'))
    if not REVIEW.exists(): raise SystemExit('First run this script without --apply')
    applied=0
    with REVIEW.open(newline='', encoding='utf8') as f:
        for row in csv.DictReader(f):
            if row['approved'].strip().lower() not in ('true','yes','1'): continue
            name=row['journal']; filename=row['candidate_file']
            if name not in journals or not filename or Path(filename).name != filename or not (OUT/filename).is_file():
                print('Skipped invalid row:', name);continue
            if journals[name].get('logo') and (OUT/journals[name]['logo']).is_file():
                print('Skipped existing logo:', name);continue
            journals[name]['logo']=filename
            applied+=1
    backup=DATA.with_name(DATA.stem+'.before-logo-update.json')
    if applied:
        if not backup.exists(): backup.write_bytes(DATA.read_bytes())
        DATA.write_text(json.dumps(journals, ensure_ascii=False, indent=2)+'\n', encoding='utf8')
    print('Approved official-logo candidates applied:', applied)

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--apply',action='store_true',help='Apply only manually approved candidate logos')
    args=p.parse_args()
    apply() if args.apply else collect()
