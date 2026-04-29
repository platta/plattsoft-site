---
layout: home

recent_limit: 5
---
{:.text-center}
# Welcome

Hi, my name is Adam. I created this site so I'd have a place to share things
with others. I’m passionate about technology, programming, and community. My
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
<div class="card mb-4 border-secondary">
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

<div class="row">

<div class="col-md-6">
<div class="text-center" markdown="1">
## Recent Blog Posts
</div>

{% for post in site.posts limit: page.recent_limit %}
    {% include excerpt.html content=post %}
{% endfor %}
</div>

<div class="col-md-6" markdown="1">

{:.text-center}
## What do I write about?

<!-- Soft skills card -->
<div class="card mb-3">
<div class="card-header d-flex justify-content-between align-items-center">
<span><i class="fas fa-users text-secondary"></i> Soft Skills</span>
<span class="badge bg-secondary">{{ site.categories['Soft Skills'] | size }}</span>
</div>
<div class="card-body">
<p class="card-text" markdown="1">
You might be surprised to read that software engineering can involve
interpersonal interactions. The complete software development cycle includes
requirements gathering, and that involves in-depth Q&A with stakeholders. In my
career, I’ve also spent a lot of time as a client-facing resource. Through these
experiences I’ve learned a bit about the soft skills that we need to apply in
business. Sometimes I’ll write about an interesting observation I’ve had in this
field.
</p>
<a href="{{ '/categories/soft-skills' | relative_url }}">See posts</a>
</div>
</div>

<!-- Cloud card -->
<div class="card mb-3">
<div class="card-header d-flex justify-content-between align-items-center">
<span><i class="fas fa-cloud text-secondary"></i> Cloud</span>
<span class="badge bg-secondary">{{ site.categories['Cloud'] | size }}</span>
</div>
<div class="card-body">
<p class="card-text" markdown="1">
The Cloud is a natural extension of virtualization so, not surprisingly, I do a
lot of that, too. Cloud concepts are still pretty new, and very powerful. There
is so much to explore there as we use it to revolutionize our industry.
</p>
<a href="{{ '/categories/cloud' | relative_url }}">See posts</a>
</div>
</div>

<!-- Software engineering card -->
<div class="card mb-3">
<div class="card-header d-flex justify-content-between align-items-center">
<span><i class="fas fa-wrench text-secondary"></i> Software Engineering</span>
<span class="badge bg-secondary">{{ site.categories['Software Engineering'] | size }}</span>
</div>
<div class="card-body">
<p class="card-text" markdown="1">
Programming is just one piece of the larger puzzle that is software engineering.
The Software Development Life Cycle (SDLC) also includes activities such as
requirements, design, and testing. But, it’s not just the activities themselves
that are important. Understanding the way the various stages of the SDLC
interact with and feed into one another is also crucial to running a successful
project. Here on my blog, you’ll find many posts discussing these intricacies.
</p>
<a href="{{ '/categories/software-engineering' | relative_url }}">See posts</a>
</div>
</div>

<!-- Technology card -->
<div class="card mb-3">
<div class="card-header d-flex justify-content-between align-items-center">
<span><i class="fas fa-sitemap text-secondary"></i> Technology</span>
<span class="badge bg-secondary">{{ site.categories['Technology'] | size }}</span>
</div>
<div class="card-body">
<p class="card-text" markdown="1">
Outside of programming and software engineering, I have a great passion for
technology in general. I work with virtualization architects, so I also wind up
writing quite a lot about Windows administration and the tools we use to manage
virtual environments. From the Raspberry Pi to the Internet of Things, you’ll
read about it here on my blog.
</p>
<a href="{{ '/categories/technology' | relative_url }}">See posts</a>
</div>
</div>

<!-- Programming card -->
<div class="card mb-3">
<div class="card-header d-flex justify-content-between align-items-center">
<span><i class="fas fa-terminal text-secondary"></i> Programming</span>
<span class="badge bg-secondary">{{ site.categories['Programming'] | size }}</span>
</div>
<div class="card-body">
<p class="card-text" markdown="1">
Programming may seem extremely daunting to a beginner. With so many different
languages, it’s hard to know which to choose and where to start. I’ve worked
with many different languages: C#, PowerShell, JavaScript, Objective C, Ruby,
and Python. Through the process of learning them, the most important takeaway
I’d like to share with you is this: **as long as you understand the fundamental
concepts of programming, it ultimately doesn’t matter which language you choose
to be proficient in.** There are notable differences but, with a solid grasp of
the basics, they all become easy to pick up..
</p>
<a href="{{ '/categories/programming' | relative_url }}">See posts</a>
</div>
</div>

<!-- End column -->
</div>

<!-- End row -->
</div>
