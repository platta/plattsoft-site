---
title: Archive
layout: default
---
<div class="container-fluid bg-white pt-3">
  <div class="row">
    <div class="col-lg-9 px-lg-4 pb-lg-4">
      <h1>Archive</h1>

      {% assign current_year = "" %}
      {% for post in site.posts %}
        {% assign post_year = post.date | date: "%Y" %}
        {% if post_year != current_year %}
          {% if current_year != "" %}</ul>{% endif %}
          <h2 class="mt-4">{{ post_year }}</h2>
          <ul class="list-unstyled">
          {% assign current_year = post_year %}
        {% endif %}
        <li class="mb-1">
          <span class="text-muted small">{{ post.date | date: "%b %-d" }}</span>
          &mdash;
          <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
        </li>
      {% endfor %}
      </ul>

    </div>
    <div class="col-lg-3">
      {% include sidebar.html %}
    </div>
  </div>
</div>
