---
title: Design, Art, and Science In the Context of Software
date: '2013-09-08'
author: Adam

layout: post

permalink: /2013/09/08/design-art-science-context-software/

categories:
  - Software Engineering
---
I was listening to a recent Hanselminutes podcast where [Scott
Hanselman](https://twitter.com/shanselman) speaks with [Natasha
Irizarry](https://twitter.com/natashairizarry) about User Experience (UX) (you
can find the podcast episode
[here](http://www.hanselminutes.com/387/demystifying-ux-with-natasha-irizarry)),
and a very interesting debate got started in my head.

Natasha states that what UX designers do is not art and that design, in general,
is not art. I found myself disagreeing immediately, but as she and Scott
discussed the details of what she meant I realized that there was more to it.

## The Discussion

The entire episode is a great listen, but the "Designers are not artists"
discussion starts around the eleven minute mark when Natasha says (wait for
it...), "Designers are not artists." She further explains her point by adding
(and I am doing my best not to butcher her meaning since these specific quotes
were peppered here and there during the discussion), "I look at everything like
it's math...Every design decision that I make _is_ a decision that I
make...Every choice is intentional."

As far as art goes, Natasha says, "[It's when] you want to give your user a
feeling...art is purely emotion...it's not really problem solving."

Scott and Natasha move on to some other great topics, but this three or four
minute segment really got me thinking.

## How I Use the Word "Art"

When I use the word art in the context of software, I am usually talking about
what I call the difference between art and science. One of my favorite sayings
is: writing code is a science; writing great code is an art.

I consider writing code a science because you are applying facts and formulas to
reach a desired goal. Some common principles applied towards this end are:

- [Separation of Concerns](http://en.wikipedia.org/wiki/Separation_of_concerns)
- [Law of Demeter](http://en.wikipedia.org/wiki/Law_of_Demeter)
- Loose [Coupling](http://en.wikipedia.org/wiki/Coupling_(computer_programming))
- High [Cohesion](http://en.wikipedia.org/wiki/Cohesion_(computer_science))

Making your code extensible and maintainable (great code) relies heavily on the
principles above, but properly applying even one of those principles takes
someone with the ability to think beyond raw facts and logic. On top of that,
great code also requires a deep understanding of your problem domain so that you
can identify:

- The best way to structure your business objects so that they correctly model
  your problem domain,
- Which pieces of data should be a property on a business object as opposed to
  their own business object,
- Which functions should live on which business objects to make the most sense
  in the context of the problem domain, and
- Which constraints in your code are likely to require changes over time (so
  that you know which parts of your code to make more configurable).

In the same way, I feel that designing a User Interface (UI) is a science
(anyone can put a button on a form), but designing a UI that is logically laid
out to make the user's experience intuitive and straightforward is an art.

## The Conflict

So here I am apparently saying the exact opposite of what Natasha talks about in
the podcast.

- I would say that good UX design takes knowledge of design principles, the
  problem domain, and even psychology combined with a certain finesse that is a
  very subjective thing. Good UX design is an art.
- Natasha would say that UX design is not an art. Its purpose is functional, to
  provide utility to the user and not to give them a feeling.

But is this really a conflict? The conclusion I came to very quickly was that we
are both correct, we just happened to choose the same word to describe slightly
different concepts. Still, it was an interesting exercise in seeing things from
someone else's perspective, and I learned a lot about UX in the process.
