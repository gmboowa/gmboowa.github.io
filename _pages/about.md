---
layout: about
title: About
permalink: /
subtitle:
profile: false
news: false
latest_posts: false
selected_papers: true
social: true
---

<link rel="stylesheet" href="{{ '/assets/css/pipeline-portfolio.css' | relative_url }}">

<div class="gm-unified-about">
  <header class="gm-unified-hero">
    <img class="gm-unified-photo"
         src="{{ '/assets/img/gerald-mboowa-1.png' | relative_url }}"
         alt="Portrait of Gerald Mboowa"
         width="228" height="228"
         loading="eager" decoding="async">
    <h1 class="gm-unified-name"><strong>Gerald</strong> Mboowa</h1>
    <p class="gm-unified-tagline">Genomics <span aria-hidden="true">•</span> Bioinformatics <span aria-hidden="true">•</span> Global Health</p>
    <p class="gm-unified-intro">Hi, I’m Gerald Mboowa, a scientist dedicated to advancing global health through innovative research and data-driven solutions, particularly in low- and middle-income countries (LMICs). My work integrates genome sequencing technologies, bioinformatics, and data science into public health strategies to address critical health challenges. As an implementation scientist, I develop reproducible bioinformatics pipelines that support bacterial, viral, and fungal pathogen characterization, antimicrobial and antifungal resistance surveillance, genomic epidemiology, outbreak investigations, and evidence-based public health decision-making.</p>
  </header>

<section class="gm-pipeline-portfolio" aria-labelledby="gm-pipeline-heading">
  <div class="gm-pipeline-heading">
    <span class="gm-pipeline-eyebrow">Research software portfolio</span>
    <h2 id="gm-pipeline-heading">Bioinformatics Pipelines</h2>
    <p>Open-source bioinformatics frameworks supporting bacterial, viral, and fungal pathogen genomics, antimicrobial resistance research, and public health surveillance.</p>
  </div>

  <div class="gm-pipeline-group">
    <h3><span class="gm-pipeline-dot" aria-hidden="true"></span>Bacterial Genomics <span class="gm-pipeline-count">4 tools</span></h3>
    <div class="gm-pipeline-links">
      <a href="https://www.microbiologyresearch.org/content/journal/mgen/10.1099/mgen.0.000583" title="Rapid Microbial Analysis Pipeline">rMAP <span class="gm-pipeline-arrow" aria-hidden="true">↗</span></a>
      <a href="https://academic.oup.com/bioinformaticsadvances/article/6/1/vbag046/8483022" title="Modular, Docker-based microbial analysis pipeline">rMAP-2.0 <span class="gm-pipeline-arrow" aria-hidden="true">↗</span></a>
      <a href="https://github.com/gmboowa/rMAP-TB" title="Tuberculosis and mycobacterial genomic surveillance; GitHub repository">rMAP-TB <span class="gm-pipeline-arrow" aria-hidden="true">↗</span></a>
      <a href="https://github.com/gmboowa/rMAP-GWAS" title="Microbial genome-wide association studies; GitHub repository">rMAP-GWAS <span class="gm-pipeline-arrow" aria-hidden="true">↗</span></a>
    </div>
  </div>

  <div class="gm-pipeline-group">
    <h3><span class="gm-pipeline-dot" aria-hidden="true"></span>Viral Genomics <span class="gm-pipeline-count">1 tool</span></h3>
    <div class="gm-pipeline-links">
      <a href="https://www.microbiologyresearch.org/content/journal/acmi/10.1099/acmi.0.000815.v3" title="HIV Drug Resistance Identification, Variant Evaluation, and Surveillance Pipeline">HIV-DRIVES <span class="gm-pipeline-arrow" aria-hidden="true">↗</span></a>
    </div>
  </div>

  <div class="gm-pipeline-group">
    <h3><span class="gm-pipeline-dot" aria-hidden="true"></span>Fungal Genomics <span class="gm-pipeline-count">1 tool</span></h3>
    <div class="gm-pipeline-links">
      <a href="https://www.frontiersin.org/journals/bioinformatics/articles/10.3389/fbinf.2026.1896572/full" title="Modular, Dockerized Candida genomics workflow">rMAP-Candida <span class="gm-pipeline-arrow" aria-hidden="true">↗</span></a>
    </div>
  </div>
</section>

<h2 class="gm-research-title">Research and Software Development</h2>

<div class="gm-research-copy" markdown="1">

<p>The <a href="https://www.microbiologyresearch.org/content/journal/mgen/10.1099/mgen.0.000583"><span style="font-weight: 700; color: inherit;">rMAP</span></a> pipeline facilitates the rapid identification of clinically important bacterial pathogens and genomic determinants of resistance and virulence, offering actionable insights to develop targeted interventions and inform AMR policies. The <a href="https://academic.oup.com/bioinformaticsadvances/article/6/1/vbag046/8483022"><span style="font-weight: 700; color: inherit;">rMAP-2.0</span></a> pipeline extends this work through a modular, Docker-based framework that supports scalable, reproducible, and flexible genomic analyses. </p>

<p>Meanwhile, <a href="https://www.microbiologyresearch.org/content/journal/acmi/10.1099/acmi.0.000815.v3"><span style="font-weight: 700; color: inherit;">HIV-DRIVES</span></a> focuses on identifying HIV drug resistance, evaluating variants, and enabling robust surveillance. The <a href="https://www.frontiersin.org/journals/bioinformatics/articles/10.3389/fbinf.2026.1896572/full"><span style="font-weight: 700; color: inherit;">rMAP-Candida</span></a> pipeline extends these capabilities to fungal pathogens by integrating <em>Candida</em> species identification, genome assembly quality assessment, antifungal resistance marker screening, species-aware phylogenomic analysis, and reproducible reporting within a modular, Dockerized WDL/Cromwell workflow. </p>

<p>The <a href="https://github.com/gmboowa/rMAP-TB" target="_blank" rel="noopener noreferrer"><span style="font-weight: 700; color: inherit;">rMAP-TB</span></a> workflow supports genomic surveillance of the <em>Mycobacterium tuberculosis</em> complex and non-tuberculous mycobacteria, incorporating species identification, drug resistance prediction, lineage classification, SNP-based analysis, and phylogenomic reconstruction. Complementing these pipelines, <a href="https://github.com/gmboowa/rMAP-GWAS" target="_blank" rel="noopener noreferrer"><span style="font-weight: 700; color: inherit;">rMAP-GWAS</span></a> provides a reproducible framework for microbial genome-wide association studies, integrating genome annotation, pangenome analysis, population structure correction, gene presence/absence association testing, and SNP-based association analysis to investigate genetic determinants of clinically relevant phenotypes. </p>

<p>Together, these pipelines strengthen the capacity of research institutions and public health systems, particularly in LMICs, to translate genomic data into actionable insights for infectious disease surveillance, antimicrobial resistance research, pathogen characterization, and evidence-based public health responses.</p>

With expertise spanning next-generation sequencing (NGS) and genomic data analysis, I focus on bridging data science, bioinformatics, and genomics to develop innovative solutions for improving diagnostics, treatment strategies, and public health outcomes. My contributions underscore the transformative potential of bioinformatics in addressing complex biological systems and translating genomic insights into strategies that enhance global health.



Currently, I contribute to global health initiatives at the <a href="https://www.broadinstitute.org/"><span style="font-weight: 700; color: inherit;">Broad Institute of MIT and Harvard</span></a>, building on my extensive experience in developing bioinformatics frameworks for infectious disease surveillance. My work encompasses AMR, genomics, and infectious disease surveillance, with a strong focus on fostering equitable solutions for LMICs. Previously, I worked with public health institutions such as the <a href="https://idi.mak.ac.ug/"><span style="font-weight: 700; color: inherit;">Infectious Diseases Institute at Makerere University</span></a> and the <a href="https://africacdc.org/"><span style="font-weight: 700; color: inherit;">Africa Centres for Disease Control and Prevention (Africa CDC)</span></a> to implement genomic surveillance programs aimed at enhancing disease detection and response systems across Africa. I contributed to these efforts as a bioinformatics implementation expert.



Passionate about translating research into actionable public health outcomes, I actively support Genomics, Bioinformatics, and Data Science training programs at the <a href="https://ace.ac.ug/"><span style="font-weight: 700; color: inherit;">African Center of Excellence in Bioinformatics & Data-intensive Sciences (ACE)</span></a> and <a href="https://www.mak.ac.ug/" target="_blank" rel="noopener noreferrer"><span style="font-weight: 700; color: inherit;">Makerere University</span></a>.

For more details about my research contributions, visit my <a href="https://orcid.org/0000-0001-8445-9414" target="_blank"><span style="font-weight: 700; color: inherit;">ORCID</span></a>, <a href="https://scholar.google.com/citations?user=P9dSDhoAAAAJ" target="_blank"><span style="font-weight: 700; color: inherit;">Google Scholar</span></a>, and <a href="https://www.researchgate.net/profile/Gerald-Mboowa" target="_blank"><span style="font-weight: 700; color: inherit;">ResearchGate</span></a> pages. You can also connect with me via <a href="https://twitter.com/GeraldGMboowa" target="_blank"><span style="font-weight: 700; color: inherit;">Twitter</span></a> and <a href="https://www.linkedin.com/in/gerald-mboowa-99020537/" target="_blank"><span style="font-weight: 700; color: inherit;">LinkedIn</span></a>.

Let’s connect and explore collaborative opportunities to advance global health, genomics, bioinformatics, data science, and public health innovations!

</div>
</div>
