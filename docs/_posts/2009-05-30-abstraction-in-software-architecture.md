---
title: Abstraction in Software Architecture
date: '2009-05-30'
author: Adam

layout: post

permalink: /2009/05/30/abstraction-in-software-architecture/

categories:
  - Software Engineering
---
One of the important parts of the essence of software architecture is that it is
an abstraction of the actual code of the software system. What's interesting
about that is that it means software architecture is an abstraction of an
abstraction, since the code we write using modern programming languages is just
an abstraction on top of machine code. Just how many layers of abstraction have
we accrued over the years that Software Engineering has been growing up?

Off the top of my head, here's a possible trail from top to bottom:

* The "mission statement" of the software
* The general system architecture
* Individual packages that comprise the system
* Individual modules that comprise a package
* Individual classes that comprise a module
* Individual properties and methods that comprise a class
* Individual lines of code that comprise methods and properties
* Individual keywords, literals, and variables that comprise lines of code
* Individual commands (from the compiler's perspective) that comprise
  keywords, literals, and variables
* Individual lines of machine code that comprise commands
* The portions of a line of machine code that combine to form a complete line
  of machine code
* Individual bits that comprise the pieces of a line of machine code.

It reminds me of this video I saw in High School:

<iframe width="560" height="315" src="https://www.youtube.com/embed/0fKBhvDjuy0"
  title="YouTube video player" frameborder="0"
  allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope;
  picture-in-picture" allowfullscreen></iframe>

We can consider each power of 10 in this video to be the same as a level of
abstraction in software engineering. This produces an interesting view because,
in the video, human beings do not live at either end of the spectrum. This holds
true to a degree as well in software engineering. The difference is that people
in different roles live at different levels of abstraction. For example, someone
designing processor chips lives at one of the lowest levels of abstraction. A
system designer, on the other hand, lives farther up the line. Finally, the
average user is probably about as far removed in terms of abstraction as you can
get.

The interesting question raised by this analogy is what level of abstraction is
most appropriate for each task involved in software engineering. As the
discipline becomes more mature, I'm sure we will hone in on the answer.
