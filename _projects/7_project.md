---
layout: page
title: rMAP-TB
description:
img: assets/img/Project7.jpg
importance: 7
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
    margin-bottom: 0.75rem;
  }

  .rmap-caption ul {
    margin-top: 0;
    margin-bottom: 0.75rem;
    padding-left: 1.25rem;
  }

  .rmap-caption li {
    margin-bottom: 0.75rem;
  }

  .rmap-caption li:last-child {
    margin-bottom: 0.75rem;
  }

  /* Make links in the caption bold + colored */
  .rmap-caption a {
    font-weight: bold;
    color: var(--link-color);
  }

  /* Main project links */
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
      path="assets/img/Project7.jpg"
      title="rMAP-TB overview schematic"
      class="img-fluid rounded z-depth-1"
    %}
  </div>
</div>

<div class="caption rmap-caption">

  <p>
    <span class="rmap-color">rMAP-TB</span> is a reproducible, Dockerized WDL/Cromwell workflow for public-health-oriented analysis of <em>Mycobacterium tuberculosis</em> complex (MTBC) and non-MTBC <em>Mycobacterium</em> genomic data. The workflow supports paired-end Illumina FASTQ inputs and integrates read preprocessing, sequence quality control, Mycobacteria species typing, MTBC/non-MTBC routing, TB drug-resistance profiling, lineage interpretation, core-SNP phylogenomics, SNP clustering, and interactive surveillance reporting.
  </p>

  <p>
    rMAP-TB was developed to support genomic surveillance of tuberculosis and clinically relevant Mycobacteria by combining species identification, drug-resistance interpretation, and phylogenomic analysis within a portable and reproducible workflow framework. It is designed for local workstation, server, and cloud-compatible execution using Docker containers and Cromwell/WDL workflow orchestration.
  </p>

  <p>
    The workflow begins with read trimming, FastQC-based sequence quality assessment, MultiQC aggregation, and Kraken2/Bracken-based Mycobacteria species typing. Species typing is used to route samples before MTBC-specific analyses: MTBC-supported samples proceed to TB-Profiler resistance, species, and lineage profiling, while non-MTBC Mycobacteria are summarized separately through an NTM speciation branch.
  </p>

  <p>
    For MTBC-supported samples, rMAP-TB performs TB-Profiler-based drug-resistance and lineage interpretation, Snippy-based variant calling, Snippy-core core-genome alignment, drug-resistance-associated non-synonymous mutation summarization, pairwise SNP distance estimation, SNP cluster interpretation, lineage distribution analysis, optional Gubbins recombination filtering, IQ-TREE2 maximum-likelihood phylogeny, and ETE3-based tree visualization.
  </p>

  <p>
    rMAP-TB generates integrated HTML reports and downloadable public-health surveillance outputs, including QC filtering rationale, Mycobacteria species typing summaries, NTM speciation summaries, TB-Profiler mutation-level resistance evidence, resistance-profile summaries, lineage distribution summaries, pairwise SNP distance tables, SNP cluster summaries, SNP distance heatmaps, phylogenetic tree visualizations, and surveillance metadata TSV files.
  </p>

  <p>
    Key workflow capabilities include:
  </p>

  <ul>
    <li>
      <strong>Mycobacteria species typing and routing</strong> &mdash; uses Kraken2 and Bracken to identify the most probable Mycobacteria species and route samples into MTBC-supported or non-MTBC/NTM reporting branches.
    </li>

    <li>
      <strong>TB drug-resistance and lineage interpretation</strong> &mdash; applies TB-Profiler to MTBC-supported samples to summarize species, lineage, sub-lineage, predicted resistance profile, resistant drugs, and mutation-level resistance evidence.
    </li>

    <li>
      <strong>MTBC core-SNP phylogenomics</strong> &mdash; performs reference-guided variant calling, core-genome SNP alignment, optional recombination filtering, maximum-likelihood phylogenetic inference, and metadata-enhanced tree visualization.
    </li>

    <li>
      <strong>SNP distance and cluster interpretation</strong> &mdash; estimates pairwise SNP distances, generates SNP distance matrices and heatmaps, and summarizes genomically close sample pairs using configurable SNP-distance thresholds.
    </li>

    <li>
      <strong>Integrated surveillance reporting</strong> &mdash; produces GitHub Pages-compatible HTML reports with downloadable TSV outputs for QC, species typing, resistance interpretation, lineage distribution, SNP clustering, and surveillance metadata.
    </li>

    <li>
      <strong>Reproducible workflow execution</strong> &mdash; uses Dockerized tools and WDL/Cromwell orchestration to support consistent execution across laptops, servers, and cloud-based environments.
    </li>
  </ul>

  <p>
    The rMAP-TB GitHub repository, documentation, workflow files, example inputs, and GitHub Pages-compatible reports are available here:
    <br>
    <a href="https://github.com/gmboowa/rMAP-TB" target="_blank" rel="noopener">
      https://github.com/gmboowa/rMAP-TB
    </a>
  </p>

  <p>
    The GitHub Pages report site is available here:
    <br>
    <a href="https://gmboowa.github.io/rMAP-TB/" target="_blank" rel="noopener">
      https://gmboowa.github.io/rMAP-TB/
    </a>
  </p>

  </div>

  <div style="margin-top: 2rem;">


    <!-- Thick Divider -->
    <hr style="
      border: none;
      height: 4px;
      background-color: #ffffff;
      margin-bottom: 1rem;
    ">

    <!-- Publication -->
    <p style="margin-top: 0.75rem;">
      <strong>rMAP-TB manuscript:</strong>
      rMAP-TB: a reproducible WDL/Cromwell workflow for <em>Mycobacterium tuberculosis</em> complex genomic surveillance and drug-resistance interpretation.
    </p>

  </div>
