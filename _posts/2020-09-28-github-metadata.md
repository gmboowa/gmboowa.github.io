---
layout: post
title: A Post with GitHub Metadata
date: 2020-09-28 21:01:00
description: A quick rundown on accessing GitHub metadata.
tags: metadata
categories: sample-posts external-services
---

A sample blog page that demonstrates accessing GitHub metadata.

## What Does GitHub Metadata Do?
- Propagates the `site.github` namespace with repository metadata.
- Sets site variables:
  - `site.title`
  - `site.description`
  - `site.url`
  - `site.baseurl`
- Allows access to metadata.
- Generates editable links.

## Example Metadata

### Repository Metadata
{% if site.github %}
- **Host Name:** {{ site.github.hostname | default: "Unavailable" }}
- **URL:** {{ site.github.url | default: "Unavailable" }}
- **BaseURL:** {{ site.github.baseurl | default: "Unavailable" }}
- **Archived:** {{ site.github.archived | default: "Unavailable" }}
{% else %}
- **GitHub Metadata Unavailable**. Ensure your `_config.yml` includes the `repository` field set to `gmboowa/gmboowa.github.io`, or set the `PAGES_REPO_NWO` environment variable.
{% endif %}

## Contributors
{% if site.github and site.github.contributors %}
- **List of Contributors:**
{% for contributor in site.github.contributors %}
  - {{ contributor.login }}
{% endfor %}
{% else %}
- **No contributors found.** Ensure the repository has contributors listed.
{% endif %}

## Additional Reading
- If you're receiving incorrect or missing data, you may need to perform GitHub API [authentication](https://github.com/jekyll/github-metadata/blob/master/docs/authentication.md).
- Go through this [README](https://jekyll.github.io/github-metadata/) for more details.
- [This page](https://github.com/jekyll/github-metadata/blob/master/docs/site.github.md) highlights all the fields accessible with GitHub Metadata.
