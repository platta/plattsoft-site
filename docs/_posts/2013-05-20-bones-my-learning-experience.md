---
title: 'Bones - My Learning Experience'
date: '2013-05-20'
author: Adam

layout: post

permalink: /2013/05/20/bones-my-learning-experience/

categories:
  - General Blog
---
[Bones](http://themble.com/bones/) is a WordPress theme built by
[Themble]("http://themble.com) that was recommended to me not long ago by a
friend.  I had been debating building a custom theme for the site, and I wasn't
sure where to start.  Now, only a few weeks after I started looking at Bones in
my (extremely rare) spare time, plattsoft.net is live on my new theme.  There
are a lot of great features in Bones, and I really like it now that I've gotten
used to it.  I definitely hit some bumps along the way, though.  I want to
document the solutions to the frustrating problems I faced, but first I want to
talk about the things about Bones that made it possible to put up with all of
that frustration.

## What I Loved about Bones

### Free

Let's get that out of the way first. Bones is completely free. Everyone likes that.

### Built to be Modified

This was one of the coolest aspects of Bones at the outset.  It's a working
WordPress theme, but there are many places such as in style sheets or images
that say "replace this," either with your logo, or your theme name, or some
other form of your own content.  At its core, Bones is designed to be used as a
template for making your own theme.  All of the basic php files are in place.
All of the default scaffolding is there.  Do you know where to put the image
that WordPress uses as your theme's screen shot in the theme browser?  You don't
have to worry about it - it's already there with a reminder to replace it with
your own image.

One of the differentiations that Themble makes on their web site is that Bones
is not a framework, and this is also an important point.  Frameworks add a layer
on top of the base, and the developer adds their own code on top of the
framework in order to create a complete product.  You're not supposed to modify
a framework's code, only add your own code on top of it.  When building with
Bones, you're supposed to mess with the base code.  You're supposed to add your
own code around, in between, and next to the base, and remove the pieces you
don't feel you need.  The end result is much cleaner that way.  When you're
building for the web, clean means speed, which is hugely important.

### Responsive Web Design

I'd been meaning to learn more about responsive web design for a while.  Because
Bones had the basic structure already laid out, I was really able to get a jump
on it.  Responsive web design is the answer to the "mobile version" web sites
that have annoyed mobile users for years.  It works by taking advantage of a
newer feature of CSS called media queries.  Here's a quick example:

```css
body {color: gray;}

@media only screen and (min-width: 481px) {
  body {color: blue;}
}

@media only screen and (min-width: 768px) {
  body {color: red;}
}
```

Based on this example, the default text color is gray. That will change
depending on the width of your browser window. Once the browser window hits 481
pixels, the first media query kicks in and overrides the default, making the
text blue. If you keep stretching the browser window, the color of the text will
turn red once the size reaches 768 pixels. When the window is larger than 768
pixels, both media queries are matched, so all three rules are being considered.
Like in other situations with CSS, however, certain rules take precedence over
others.

What's really cool about this is that you can define a hierarchy of rules which
overlap and flow on top of one another. For example, if I changed my rules to
this:

```css
body {color: gray;}

@media only screen and (min-width: 481px) {
  body {color: blue;}
}

@media only screen and (min-width: 768px) {
  body {background-color: red;}
}
```

I would see a red window with blue text once my browser window size hit 768 pixels.

## What I Hated about Bones

Before I get into these, let me just point out that "hated" is in the past
tense.  Bones and I are on very good terms now.  I would use it again in a
heartbeat, and have already recommended it to friends.

### The Documentation

Documentation in Bones is a bit of a paradox.  Across both the php files and the
style sheets there are a huge number of comments.  There are a ton of links to
external sources discussing quirks and problems that Bones handles.  Those links
are great because they're usually right next to some weird code designed to work
around a quirk that would make no sense without an explanation.  In many ways,
Bones has excellent documentation.  At the same time, there were many times that
I had no idea where to go when I wanted to change one particular thing.

A lot of my frustration here stemmed from trying to figure out the style sheets.
I don't know that there is a better way to document them, but at first I really
didn't know where to go to change the styles I was looking at once the pages
were rendered. Since Bones is built to be responsive, there are a number of
separate style files for different resolutions. It took some time to adjust to
the fact that the "base" style sheet was for the smallest screens (mobile), and
sometimes rules I would set in place in the base file would be overridden by the
default styling in the larger resolution files. Even within the style sheets,
Bones has a lot of empty style declarations to help you see how it is
architected. That is great now that I've gotten the hang of it, but in the
beginning it only contributed to my confusion

### LESS

Let me start with this - I _love_ [LESS](http://lesscss.org).

When I first started building my theme, though, I hated it.

The first problem I had was that Bones includes both LESS and Sass (I still
don't really know what Sass is). In the main style.css file, there was a nice
write up about LESS and Sass and how they are source files which get compiled
into the final CSS that the web site will read. "Cool," I thought, and I read
about the tools available to compile LESS files that style.css linked to. After
reading, armed with a LESS compiler, I proceeded to curse and mutter under my
breath for about a day and a half while I figured out these things:

- In the library folder, there were these three folders, CSS, LESS, and SCSS.
- I could delete the SCSS folder, since I was using LESS and not Sass.
- I had to tell my LESS compiler that when it was done compiling a file in the
  LESS folder it had to write the output file to the CSS folder.
- Not all of the LESS files have to be compiled directly by the LESS compiler.
  In fact, some of them _will not compile_ if you try to compile them
  directly.

I didn't see documentation anywhere that would have told me any of those things.
It took me hours of trial and error and tool configuration and more trial and
lots more errors to get comfortable with the whole setup.

Once I got the hang of using LESS with Bones, I could tweak the site's layout
very easily and my theme really started coming together. LESS gives you a lot of
power in designing complex style sheets because you can define reusable
variables and functions to make things easier to read and easier to change. For
example, in my LESS source files, I have variables for all of the main colors of
the site like the gray background and the two main shades of blue. If I ever
want to change one of those colors, I only have to do it in once place and every
spot where I've referenced it will be up to date automatically. The default LESS
files in Bones also include some useful functions as well, such as this one
(which my theme uses):

```css
/*********************
BORDER RADIUS
*********************/

/*
NOTE: For older browser support (and some mobile),
don't use the shorthand to define *different* corners.

USAGE: .border-radius(4px);

*/
.border-radius(@radius: 4px) {
  -webkit-border-radius: @radius;
     -moz-border-radius: @radius;
          border-radius: @radius;
}
```

Since the `border-radius` style was introduced at different times by different
browsers, using it in a way that's universally supported is still a little odd.
With LESS, and this function, I don't have to put three lines of code whenever I
want to define a border radius. I just have to call the function by adding
`.border-radius(5);` to my LESS file (the `@radius` is a
parameter to the function with a default value of `4px`).

## Lessons Learned

At the end of my trip through WordPress theme development with Bones, I'm really
satisfied with the way the site looks. I'm also really excited knowing how clean
it is behind the scenes. Knowing that I'll never get a notification about an
update for my theme only to find that installing the update breaks everything is
also a huge plus. I've got a beautiful, responsive theme in place with the
confidence that I can easily adjust anything else I might decide to change, and
that lets me sit back and focus on just writing more content. Writing more
content, of course, if I can ever find the time.
