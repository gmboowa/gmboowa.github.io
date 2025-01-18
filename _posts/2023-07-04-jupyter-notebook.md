---
layout: post
title: A Post with Jupyter Notebook
date: 2023-07-04 08:57:00-0400
description: An example of a blog post with Jupyter Notebook
tags: formatting jupyter
categories: sample-posts
giscus_comments: true
related_posts: false
---

To include a Jupyter notebook in a post, you can use the following code:

{% raw %}
```html
{::nomarkdown}
{% assign jupyter_path = "assets/jupyter/blog.ipynb" | relative_url %}
{% if site.static_files contains jupyter_path %}
    {% jupyter_notebook jupyter_path %}
{% else %}
    <p>Sorry, the notebook you are looking for does not exist.</p>
{% endif %}
{:/nomarkdown}
