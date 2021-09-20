---
title: Tested or Not?
date: '2009-07-22'
author: Adam

layout: post

permalink: /2009/07/22/tested-or-not/

categories:
  - Software Engineering
---
A software system's "tested" status is an interesting thing. Sometimes, in a
schedule crunch, the decision makers may decide to cut back on testing, hitting
only the most commonly used portions of the system. Almost inevitably, when this
is done, a bug in one of the less commonly used parts of the system gets out.

I propose that the true "tested" status of a software system is a discrete,
boolean value and not a continuous value covering a range of partially tested
states. Without such a definition, saying, "The system has been tested," or even
"The system has been partially tested," loses its meaning. One is left to
wonder, "How _much_ of it was tested?"

That's not to say that testing only the most important pieces of the system
doesn't decrease the risk of defects in that section being released. This is
definitely valuable and deserves to be recognized, but it is important to make
the distinction between tested software, untested software, and untested
software where some of the risks have been managed. Otherwise, it is all too
easy to leave your stakeholders with the impression that you are actually able
to test the system in an inadequate time frame, with insufficient resources, or
both.
