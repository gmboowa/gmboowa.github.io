---
layout: post
title: A Post with Jupyter Notebook
date: 2023-07-04 08:57:00-0400
description: An example of a blog post with a Jupyter Notebook
tags: formatting jupyter
categories: sample-posts
giscus_comments: true
related_posts: false
---

To include a Jupyter Notebook in a post, you can use the following code:

```html
<details>
  <summary>Click here to view the Jupyter Notebook</summary>
  {% assign jupyter_path = "assets/jupyter/blog.ipynb" | relative_url %}
  {% assign notebook_exists = site.static_files | where: "path", jupyter_path | first %}
  {% if notebook_exists %}
    <iframe src="{{ jupyter_path }}" width="100%" height="600px" frameborder="0"></iframe>
  {% else %}
    <p>Sorry, the notebook you are looking for does not exist.</p>
  {% endif %}
</details>