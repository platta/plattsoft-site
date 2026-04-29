---
layout: page-with-sidebar
title: Topics
---

<h1>Topics</h1>

<p class="lead mb-5">Posts here aren't just about technology — they're
about how to think, communicate, build, and operate with intention. The
themes below cut across the existing categories and group posts by the
ideas they explore.</p>

{% assign topic_pages = site.pages | where: "layout", "topic" | sort: "title" %}
{% for topic_page in topic_pages %}
<h2 class="mt-5">
  <a href="{{ topic_page.url | relative_url }}" class="text-decoration-none">{{ topic_page.title }}</a>
</h2>
{% if topic_page.description %}
<p class="text-muted mb-3">{{ topic_page.description }}</p>
{% endif %}

{% assign topic_posts = site.posts | where: "topic", topic_page.topic_key %}
<ul class="list-unstyled">
  {% for post in topic_posts %}
  <li class="mb-1">
    <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
    <small class="text-muted ms-1">{{ post.date | date: "%Y" }}</small>
  </li>
  {% endfor %}
</ul>
{% endfor %}
