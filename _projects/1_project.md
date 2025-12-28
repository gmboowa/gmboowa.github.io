---
layout: page
title: rMAP (Rapid Microbial Analysis Pipeline)
description:
img: assets/img/Project1.jpg
importance: 1
category: work
related_publications: false
---

<style>
  /* Color definitions for both modes */
  :root {
    --rmap-color: #B509AC; /* Deep purple for light mode */
    --link-color: #B509AC; /* Link color in light mode */
  }

  [data-theme="dark"] {
    --rmap-color: #4682b4; /* Steel blue for dark mode */
    --link-color: #4682b4; /* Link color in dark mode */
  }

  /* Accent text */
  .rmap-color {
    color: var(--rmap-color);
    font-weight: bold;
  }

  /* Caption block spacing and width */
  .rmap-caption {
    max-width: 900px;
    margin: 1.5rem auto 0 auto;
    text-align: justify;
  }

  .rmap-caption p {
    margin-top: 0;
    margin-bottom: 0.75rem;  /* matches screenshot paragraph spacing */
  }

  .rmap-caption ul {
    margin-top: 0;
    margin-bottom: 0.75rem;
    padding-left: 1.25rem;   /* standard bullet indent */
  }

  .rmap-caption li {
    margin-bottom: 0.75rem;  /* gap between bullet items */
  }

  .rmap-caption li:last-child {
    margin-bottom: 0.75rem;
  }

  /* Make links in the caption bold + colored */
  .rmap-caption a {
    font-weight: bold;
    color: var(--link-color);
  }

  /* Main project links (if needed later) */
  .project-link {
    font-weight: bold;
    color: var(--link-color);
    text-decoration: none;
  }
  .project-link:hover {
    text-decoration: underline;
  }
</style>

<div class="row">
  <div class="col-sm mt-3 mt-md-0 text-center">
    {% include figure.html
      path="assets/img/Project1.jpg"
      title="rMAP overview schematic"
      class="img-fluid rounded z-depth-1"
    %}
  </div>
</div>

<div class="caption rmap-caption">

  <p>
    <span class="rmap-color">rMAP (Rapid Microbial Analysis Pipeline)</span> is a modular, reproducible bioinformatics workflow suite for microbial whole-genome sequencing analysis, supporting routine genomic epidemiology and public-health workflows. rMAP streamlines common steps including read QC, trimming, <em>de&nbsp;novo</em> assembly, species/lineage typing (e.g., MLST), resistance gene detection, plasmid replicon screening, virulence profiling, and reporting.
  </p>

  <p>
    rMAP is available in three deployable implementations to support different users and computing environments:
  </p>

  <ul>
    <li>
      <strong>rMAP-1.0 (Bash-based CLI)</strong> &mdash; a lightweight command-line implementation for rapid local analyses and quick turnaround in low-resource settings. Designed to run on a standard Linux workstation or server, it supports straightforward execution with minimal dependencies and is well-suited for routine QC, assembly, and downstream screening steps in small-to-medium WGS datasets.
      <br>
      <a href="https://github.com/GunzIvan28/rMAP" target="_blank" rel="noopener">
        https://github.com/GunzIvan28/rMAP
      </a>
    </li>

    <li>
      <strong>rMAP Web</strong> &mdash; a browser-accessible interface for guided analysis with no local setup required. The rMAP Genome Analysis Platform supports uploading <code>.fastq</code> files and running end-to-end microbial genomics workflows for researchers, organizations, and data scientists. Users can upload data, launch analyses on large datasets, and receive notifications when jobs complete.
      <br>
      <a href="https://genomeclarity.com/" target="_blank" rel="noopener">
        https://genomeclarity.com/
      </a>
    </li>

    <li>
      <strong>rMAP-2.0 (Docker + Cromwell/WDL)</strong> &mdash; containerized, workflow-orchestrated implementation designed for reproducible and scalable execution. Its implementation emphasizes portability and reproducibility by running version-controlled workflows in containerized environments, enabling consistent results across laptops, servers, and cloud platforms. The pipeline produces standardized QC summaries and analysis outputs suitable for surveillance reporting, research projects, and training.
      <br>
      <a href="https://github.com/gmboowa/rMAP-2.0" target="_blank" rel="noopener">
        https://github.com/gmboowa/rMAP-2.0
      </a>

      <div class="mt-2 text-center">
        {% include figure.html
          path="assets/img/final_rMAP-2.0.jpg"
          title="rMAP-2.0 (Docker + Cromwell/WDL) — terminal execution overview"
          class="img-fluid rounded z-depth-1"
        %}
      </div>
    </li>
  </ul>

  <p style="margin-top: 0.75rem;">
    <strong>rMAP-1.0 Publication:</strong>
    <a href="https://www.microbiologyresearch.org/content/journal/mgen/10.1099/mgen.0.000583"
       target="_blank" rel="noopener">
      Here
    </a>
  </p>

</div>
