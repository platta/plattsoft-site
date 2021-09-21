---
title: Strong Typing Considerations
date: '2013-07-31'
author: Adam

layout: post

permalink: /2013/07/31/why-strong-typing-is-important/

categories:
  - Programming
---
You could also call this one "Why I Hate JavaScript," but there are many popular
languages today that do not employ strong typing. JavaScript was just the
language I happened to be working in when the following code had me pulling my
hair out for nearly twenty minutes:

```javascript
var value = $("#myTextbox").val();
var calculation = value + (value * 0.05);
alert(calculation);
```

When I typed `1` into `#myTextbox`, I got an alert that said `10.05`. I lost
count of how many times I double checked my math.

Now, programmers who have been routinely working in JavaScript for some time
might already have spotted the issue, but I've only recently spent a significant
amount of time with the language. I've also completely given the answer away in
the post title. The problem with my code was that jQuery's `val()` method
returns a string. My `calculation` variable was being assigned like this:

- Evaluate `(value * 0.05)`, where `value` is implicitly cast as a number.
- Add `value` to the result of the above evaluation, where that result is cast
  as a string.

From what I've been able to gather after a little digging, the `+` operator will
cast one operand as a string if the other operand is a string, regardless of
their order. Similarly, the `*` operator will cast both operands as numbers all
the time (I even tried this with boolean values).

## The Benefits of Strong Typing

Languages like JavaScript, Python, and Ruby let you do whatever you want with
your variables, and that limits the ability for IDEs and compilers to perform
static checking. My example is three lines of code and produces a fairly obvious
logical bug, but it took me close to half an hour to identify the problem. When
you have a system consisting of thousands or hundreds of thousands of lines of
code, the risk of defects increases exponentially; most defects (logical bugs
especially) are not nearly as obvious as my example. In a language with strongly
typed variables, type conflicts can be caught at compile time instead of during
testing or, worse, in production.

## Draw Your Own Conclusions

The lack of strong typing in languages like JavaScript is neither good nor bad,
I really want to stress that. Yes, my preference is to use languages with strong
typing, but there is nothing inherently wrong with loosely typed languages.

The important thing to keep in mind is that you should always choose the tools
that are appropriate for your task. If you're building an application for the
enterprise or a safety critical system, you will definitely want a language with
strong typing so that you can take advantage of the additional static checking
it gives you. If you're building a web site for your kid's baseball team, maybe
that's not so important. At the end of the day, we all have our preferences, but
a strong software engineer must make smart choices based on the needs of the
project.
