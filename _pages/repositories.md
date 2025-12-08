---
layout: page
permalink: /repositories/
title: Repositories
description:
nav: true
nav_order: 2
toc: false  # prevents the theme from adding an extra TOC line
---

## GitHub users

{% assign users = site.data.repositories.github_users %}
{% if users %}
  {% for user in users %}
  {% assign username = user | strip %}

  <!-- Username heading (clickable) -->
  <h3 id="{{ username | downcase }}">
    <a href="https://github.com/{{ username }}" target="_blank" rel="noopener">
      {{ username }}
    </a>
  </h3>

  <div style="text-align:left;">

    <!-- Row: avatar on the left, stats + trophies stacked on the right -->
    <div
      class="github-user-row"
      style="
        display:flex;
        flex-wrap:wrap;
        align-items:flex-start;
        justify-content:flex-start;
        gap:1.5rem;
      ">

      <!-- Profile avatar card -->
      {% include repository/repo_user.html username=username %}

      <!-- Right column: stats card + trophies card (same width & style) -->
      <div
        class="github-user-main"
        style="
          display:flex;
          flex-direction:column;
          align-items:stretch;
          gap:0.75rem;
          max-width:520px;
          width:100%;
        ">

        <!-- Stats card -->
        <div
          class="github-stats-card"
          style="
            width:100%;
            padding:0.75rem 0.75rem;
            border-radius:0.75rem;
            background-color:rgba(15,15,30,0.85);
            border:1px solid rgba(106,13,173,0.6);
            box-shadow:0 4px 12px rgba(0,0,0,0.45);
            box-sizing:border-box;
          ">
          <a href="https://github.com/{{ username }}" target="_blank" rel="noopener">
            <img
              src="https://gmboowa-github-readme-stats.vercel.app/api?username={{ username | url_encode }}&show_icons=true&hide_border=true&theme={{ site.repo_theme_dark }}"
              alt="{{ username }} GitHub stats"
              loading="lazy"
              style="display:block;width:100%;height:auto;">
          </a>
        </div>

        <!-- Trophies card (same width & style) -->
        {% include repository/repo_trophies.html username=username %}

      </div>
    </div>

    {% unless forloop.last %}
    <!-- Deep purple separator -->
    <div
      style="
        border-top:3px solid #6a0dad;
        margin:2.5rem 0 2rem 0;
      ">
    </div>
    {% endunless %}
  </div>

  {% endfor %}
{% endif %}

---

## GitHub Repositories

{% assign repos = site.data.repositories.github_repos %}
{% if repos %}
<div class="repositories"
     style="display:grid;grid-template-columns:repeat(auto-fit,minmax(320px,1fr));
            gap:1.5rem;align-items:stretch;">

  {% for full in repos %}
    {% assign full_trimmed = full | strip %}
    {% assign parts = full_trimmed | split:'/' %}
    {% assign owner = parts[0] | strip %}
    {% assign name  = parts[1] | strip %}

    <div class="repo-card"
         style="padding:1rem;border-radius:0.75rem;
                border:1px solid rgba(255,255,255,0.15);
                background-color:rgba(255,255,255,0.03);
                text-align:center;">

      <!-- Repo name (clickable) -->
      <h4 style="margin-top:0;margin-bottom:0.5rem;font-size:1rem;">
        <a href="https://github.com/{{ owner }}/{{ name }}"
           target="_blank"
           rel="noopener"
           style="text-decoration:none;">
          {{ name }}
        </a>
      </h4>

      <!-- Repo stats pin from your Vercel github-readme-stats instance -->
      <div style="margin-bottom:0.5rem;">
        <img
          src="https://gmboowa-github-readme-stats.vercel.app/api/pin/?username={{ owner | url_encode }}&repo={{ name | url_encode }}&show_owner=true&hide_border=true&theme={{ site.repo_theme_dark }}"
          alt="{{ owner }}/{{ name }} GitHub repository stats card"
          loading="lazy"
          style="max-width:100%;height:auto;">
      </div>

      <!-- Small caption -->
      <p style="margin:0;font-size:0.8rem;
                color:var(--global-muted-color,#888);">
        {{ owner }}/{{ name }} on GitHub
      </p>

    </div>
  {% endfor %}
</div>
{% endif %}
