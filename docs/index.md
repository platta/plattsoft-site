---
layout: home

recent_limit: 5
---
{: .text-center}
# Welcome

Hi, my name is Adam. I created this site so I'd have a place to share things
with others. I’m passionate about technology, programming, and community. My
blog is a way to combine the three. Through sharing relevant programming and
tech articles, ideas, and demos, everyone is challenged to think differently and
grow stronger in their careers and interests.

I don't update as often as I'd like, but I try hard to make every post
worthwhile. I hope you find something valuable from reading.

<div class="row">

<div class="col-md-6">
<div class="text-center" markdown="1">
## Recent Blog Posts
</div>

{% for post in site.posts limit: page.recent_limit %}
    {% include excerpt.html content=post %}
{% endfor %}
</div>

<div class="col-md-6 pl-md-0" markdown="1">

{: .text-center}
## What do I write about?

<div class="card mb-3">
<div class="card-header">
<i class="fas fa-terminal text-secondary"></i> Programming
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
</div>
</div>

<div class="card mb-3">
<div class="card-header">
<i class="fas fa-wrench text-secondary"></i> Software Engineering
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
</div>
</div>

<div class="card mb-3">
<div class="card-header">
<i class="fas fa-sitemap text-secondary"></i> Technology
</div>
<div class="card-body">
<p class="card-text" markdown="1">
Outside of programming and software engineering, I have a great passion for
technology in general. I work with virtualization architects, so I also wind up
writing quite a lot about Windows administration and the tools we use to manage
virtual environments. From the Raspberry Pi to the Internet of Things, you’ll
read about it here on my blog.
</p>
</div>
</div>

<div class="card mb-3">
<div class="card-header">
<i class="fas fa-cloud text-secondary"></i> Cloud
</div>
<div class="card-body">
<p class="card-text" markdown="1">
The Cloud is a natural extension of virtualization so, not surprisingly, I do a
lot of that, too. Cloud concepts are still pretty new, and very powerful. There
is so much to explore there as we use it to revolutionize our industry.
</p>
</div>
</div>

<div class="card mb-3">
<div class="card-header">
<i class="fas fa-users text-secondary"></i> Soft Skills
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
</div>
</div>
</div>

</div>
