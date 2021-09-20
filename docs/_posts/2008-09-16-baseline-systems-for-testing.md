---
title: Baseline Systems for Testing
date: '2008-09-16'
author: Adam

layout: post

permalink: /2008/09/16/baseline-systems-for-testing/

categories:
  - Software Engineering
---
I haven't researched this, so I don't know if it's already an established
practice or not.

Imagine a software system that has a large number of options that change the way
the software works to better fit your workflow. There could be thousands of
combinations of these settings, and the system is composed of 98% legacy code so
debugging anything is a nightmare. Now imagine a user of this software
experiences a problem and reports it.

In order to verify whether the user's issue is related to the software or to an
external factor (such as hardware failure or network problems), someone
reproduces the issue on his or her test system in-house. If the issue can be
reproduced, then a bug report is filed and a programmer digs into the code to
fix it. There's only one problem: the programmer can't produce the issue on his
or her own test system.  
This can cause a ton of problems. It's even possible that the first point of
contact is unable to produce the issue, leading to the potentially incorrect
conclusion that the problem is not caused by the software. In these cases, the
last resort is to obtain a backup of the user's system and attempt to reproduce
the issue that way. That's a scenario that nobody wants to hit.

In order to streamline this process, I think it would be effective to create a
number of controlled system backups, each with a specific configuration of
options to cover the most common and most major variations in configuration
across the user base. Each backup should be populated with a standard set of
data that covers the basic scenarios of system use, and stored somewhere
read-only. In order to use one of these backups you'd need to make a copy of it
onto your own machine. This would keep the initial backup intact at all times so
that you could always start over again from a fresh system with known integrity.

Using a system like this, when attempting to produce an issue reported by a
user, the person attempting to produce the issue would select the system backup
whose configuration most closely resembles the user's system configuration, make
a copy of that system, and test the issue. If the issue is confirmed, when a
programmer looks to fix the issue, he or she can get a copy of the same
controlled system and follow the same set of steps to again produce the issue in
order to find the problematic code. That would also reduce the number of times
that it becomes necessary to ask the user for a backup of his or her actual
system which, again, is something to be avoided at all costs.
