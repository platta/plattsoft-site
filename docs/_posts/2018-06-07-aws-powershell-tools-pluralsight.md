---

title: Learn the AWS PowerShell Tools on Pluralsight
date: '2018-06-07'
author: Adam

layout: post

permalink: /2018/06/07/aws-powershell-tools-pluralsight/

excerpt: |
  Knowing the AWS PowerShell cmdlets is valuable. You should take my Pluralsight
  course: Automating Cloud Operations with AWS Tools for Windows PowerShell.

categories:
  - Cloud
---
I've authored
[a Pluralsight course](https://www.pluralsight.com/courses/aws-tools-windows-powershell-automating-cloud-operations")
on the AWS Tools for Windows PowerShell. This is the official AWS PowerShell
module for working with AWS resources. If you're familiar with my work, you know
[I'm]({{ site.baseurl }}{% post_url 2017-03-20-tracking-baby-aws-iot %})
[no]({{ site.baseurl }}{% post_url 2017-05-15-amazon-sqs-overview-pt1 %})
[stranger]({{ site.baseurl }}{% post_url 2017-06-05-amazon-sqs-overview-pt2 %})
to AWS, and I have [a]({{ site.baseurl }}{% post_url
2015-04-25-what-powershell-summit-showed-me %})
[lot]({{ site.baseurl }}{%post_url
2015-08-24-internationalization-with-import-localizeddata %})
[of]({{ site.baseurl }}{% post_url
2015-08-27-internationalization-with-import-localizeddata-part-2 %})
[love]({{ site.baseurl }}{% post_url
2015-12-03-reading-the-event-log-with-windows-powershell %}) for PowerShell.
Authoring a course that combines those two things was an absolute joy.

Now, there are lots of courses on Pluralsight that cover a wide array of topics.
Sometimes it can be hard to decide which course best suits your needs. That's
why I decided to write a bit about the course to help you decide whether it's
worth your time.

## THE way to manage AWS in the Windows world

If you operate in an environment consisting mainly of Windows machines, you are
already (or should be!) doing a lot with PowerShell. If you also manage AWS
resources in your organization, you're definitely going to want to know this
module. Integrating AWS resources with other tools in your environment always
requires a little custom coding to get things running smoothly. Some
organizations have that taken care of using third party solutions. Even if
that's the case, I guarantee once you get used to the cmdlets it will be faster
to spot-check AWS resources in an interactive PowerShell session than the web
console.

## Learn to fish

The Chinese proverb goes, "Give a man a fish and you feed him for a day. Teach a
man to fish and you feed him for a lifetime." I worked hard to craft a learning
experience that did more than just show how to do specific tasks. There are over
5,000 cmdlets in the AWS PowerShell module, so examples can only scratch the
surface!

Instead, I focus on teaching methods you can use to discover cmdlets on your own
and figure out how they work. I use concrete examples to illustrate those
techniques. But, the goal is to enable you to any task no matter which AWS
service it uses.

## Reusable script template

The last module of the course focuses on building scripts with the AWS
PowerShell cmdlets. And, I start by building a reusable script template you can
download and use yourself. This template helps you create parameters with
pipeline support and comment-based help for your script. It even recreates a
couple of the parameters commonly used by the AWS PowerShell cmdlets. Your
script will feel a lot like one of the existing AWS cmdlets. That makes
knowledge of the native cmdlets a transferable skill for anyone using your
script.

The remainder of the courses showcases some full examples of using and extending
the script template in various ways. What you need in your own organization will
undoubtedly vary, but that's why I provide all of the code from these examples
for your reference.

---

If any of this sounds like it would benefit you, I encourage you to check out my
Pluralsight course,
[Automating Cloud Operations with AWS Tools for Windows PowerShell](https://www.pluralsight.com/courses/aws-tools-windows-powershell-automating-cloud-operations).
The skills I teach will make you a consummate expert in working with AWS
resources from PowerShell. And, the majority of the design guidelines and
techniques are not specific to the AWS PowerShell cmdlets. These valuable skills
will transfer effortlessly to your other projects and make you a stronger IT
professional.

At the end of the day, anything that helps you grow as a professional is worth
looking into. As I say at the end of the course (spoiler alert?): always keep on
learning.
