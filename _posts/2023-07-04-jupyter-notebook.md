---
layout: post
title: a post with jupyter notebook
date: 2023-07-04 08:57:00-0400
description: an example of a blog post with jupyter notebook
tags: formatting jupyter
categories: sample-posts
giscus_comments: true
related_posts: false
---

To include a jupyter notebook in a post, you can use the following code:

{% raw %}{::nomarkdown}{% assign jupyter_path = "assets/jupyter/blog.ipynb" | relative_url %}{% capture notebook_exists %} {% file_exists assets/jupyter/blog.ipynb %} {% endcapture %}{% if notebook_exists == "true" %}{% jupyter_notebook jupyter_path %}{% else %}<p>Sorry, the notebook you are looking for does not exist.</p>{% endif %}{:/nomarkdown}{% endraw %}

---

### Explanation

This post demonstrates embedding a Jupyter notebook using the [Jekyll Jupyter Notebook plugin](https://github.com/red-data-tools/jekyll-jupyter-notebook). The plugin converts the notebook to an HTML page and includes it in the post.

{% raw %}{::nomarkdown}{% assign jupyter_path = "assets/jupyter/blog.ipynb" | relative_url %}{% capture notebook_exists %} {% file_exists assets/jupyter/blog.ipynb %} {% endcapture %}{% if notebook_exists == "true" %}{% jupyter_notebook jupyter_path %}{% else %}<p>Sorry, the notebook you are looking for does not exist.</p>{% endif %}{:/nomarkdown}{% endraw %}
