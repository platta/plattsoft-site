---
layout: home

recent_limit: 5
---
{:.text-center}

# Welcome

Hi, my name is Adam. I created this site so I'd have a place to share things
with others. I'm passionate about technology, programming, and community. My
blog is a way to combine the three. Through sharing relevant programming and
tech articles, ideas, and demos, everyone is challenged to think differently and
grow stronger in their careers and interests.

I don't update as often as I'd like, but I try hard to make every post
worthwhile. I hope you find something valuable from reading.

<div class="text-center mb-3" markdown="1">
## Start Here
</div>

{% assign start_post = site.posts | where: "title", "Goldilocks and the Three Functions" | first %}
{% if start_post %}
<div class="card mb-5 border-secondary shadow-sm">
  <div class="card-body">
    <span class="badge bg-secondary mb-2">Recommended</span>
    <h4 class="card-title">
      <a href="{{ start_post.url | relative_url }}" class="text-decoration-none stretched-link">{{ start_post.title }}</a>
    </h4>
    <p class="card-subtitle mb-2 text-muted small">A foundational post on engineering balance and tradeoffs.</p>
    <p class="card-text">{{ start_post.excerpt }}</p>
  </div>
</div>
{% endif %}

<div class="row g-3">
  <div class="col-md-6">
    <div class="text-center">
      <h2 class="mb-3">Recent Blog Posts</h2>
    </div>

    <div class="row row-cols-1 g-3 mb-3">
      {% for post in site.posts limit: page.recent_limit %}
        <div class="col">
          {% include excerpt.html content=post %}
        </div>
      {% endfor %}
    </div>
  </div>

  <div class="col-md-6">
    <div class="text-center">
      <h2 class="mb-3">Browse Topics</h2>
    </div>

    {% assign topic_pages = site.pages | where: "layout", "topic" | sort: "topic_order" %}
    <div class="row row-cols-1 g-3 mb-3">
      {% for topic_page in topic_pages %}
        {% assign topic_posts = site.posts | where: "topic", topic_page.topic_key %}
        <div class="col">
          {% include topic-card.html topic_page=topic_page topic_posts=topic_posts %}
        </div>
      {% endfor %}
    </div>
  </div>
</div>
