---
title: 'Why "Bug Free" is Impossible'
date: '2011-08-23'
author: Adam

layout: post

permalink: /2011/08/23/why-bug-free-is-impossible/

categories:
  - Software Engineering
---
One of the most common misconceptions about software testing is that, once a
program or software system has gone through testing, it is free of bugs. If you
accept this assumption, it logically follows that, if any bugs are found by the
end user, the software was not properly tested. Both of these statements are
absolutely false.

The truth about software testing is that there is no way to prove that a program
or system of any reasonable size is "bug free." In order to prove that there are
no faults (this is the technical term for "bug") in a program, it is necessary
to show that the program functions correctly under all possible conditions and
in all states.

As an example, consider a very simple program that accepts a single value as
input, and doesn't read any external data during its execution. If the input
value is boolean (true or false), there are two conditions that need to be
tested: what happens when a value of true is passed in, and what happens when a
value of false is passed in.

What if we expand our simple program so that it accepts two boolean values? Now
there are four cases to test.

<table class="table">
  <thead>
    <tr>
      <th>Input A</th>
      <th>Input B</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>false</td>
      <td>false</td>
    </tr>
    <tr>
      <td>false</td>
      <td>true</td>
    </tr>
    <tr>
      <td>true</td>
      <td>false</td>
    </tr>
    <tr>
      <td>true</td>
      <td>true</td>
    </tr>
  </tbody>
</table>

To illustrate just how quickly the number of cases required to prove a program
fault free grows, let's consider one last example. Let's say we have a simple
program that accepts a single character (letter, number, etc.) as input. How
many test cases are required to prove that this program is free of defects?
Twenty-six? What about numbers? What about punctuation marks?

To get to the actual answer, we have to consider the way that a single character
is represented in the computer's memory. Computers understand only ones and
zeroes (binary), which means that every piece of data flowing through memory has
to be stored as some kind of number. Character data is generally stored using
the American Standard Code for Information Interchange (ASCII). This code
provides a one-to-one mapping between each character and a number, allowing for
the translation of characters and strings to and from a numeric format.

The range of numbers used by ASCII requires a single byte (a string of eight
ones or zeroes) to represent each character. That means that our single
character of input can be viewed as eight individual boolean values. As
illustrated above, in order to fully test the program we need to cover all
possible combinations of input values. **The total number of possible
combinations for eight boolean values is 256!**

If a simple program that accepts only a single character of data requires 256
test cases to be proven "bug free," imagine how many test cases would be
required for even a rudimentary application like Notepad. The truth is that the
problem of proving the validity of all possible input scenarios rapidly
approaches a level that is impossible to measure in any realistic time frame.

This is precisely why no software system can ever be proven free of faults, and
why determining which combinations of input values to test is a crucial part of
software testing. Effective testing involves finding those input combinations
that are most likely to be encountered in real world use, and also those
combinations which are most likely to reveal faults. There are many techniques
for selectively choosing an effective and efficient set of test cases that have
all been developed because of this fundamental problem in the nature of software
testing.

In the world of software engineering, testing is really about reducing the
probability of a system failure, not eliminating it as a possibility.
