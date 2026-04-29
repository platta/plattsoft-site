---
layout: page-with-sidebar
title: Topics
permalink: /topics/
nav: true
nav_order: 1
---

<h1>Topics</h1>

<p class="lead mb-5">
  Posts here aren't just about technology — they're about how to think,
  communicate, build, and operate with intention. The themes below cut
  across the existing categories and group posts by the ideas they explore.
</p>

{% assign topic_pages = site.pages | where: "layout", "topic" | sort: "topic_order" %}

<div class="row row-cols-1 row-cols-md-2 g-4">
  {% for topic_page in topic_pages %}
  {% assign topic_posts = site.posts | where: "topic", topic_page.topic_key %}
  <div class="col">
    {% include topic-card.html topic_page=topic_page topic_posts=topic_posts %}
  </div>
  {% endfor %}
</div>
