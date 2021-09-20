---
title: 'Baby Connect Project - Design Considerations'
date: '2017-04-03'
author: Adam

layout: post

permalink: /2017/04/03/baby-connect-project-design-considerations/

categories:
  - Cloud
---
Previously, I wrote about my experience creating some automation to keep track
of my baby daughter's diapers and bottles using a service called
[Baby Connect](https://www.baby-connect.com). This time, I'd like to discuss
some of the hurdles I faced and design choices I made. If you haven't already
read [the original article]({{ site.baseurl }}{% post_url
2017-03-20-tracking-baby-aws-iot %}),
it would be a good idea to check it out first.

## Why not 100% cloud?

Ideally, I would've loved to have the entire solution live in the cloud. Amazon
Lambda is perfect for the small tasks required in this automation.
Unfortunately, a Lambda function would not be able to send data to Baby Connect
for two main reasons.

### Native binaries

My code uses a [Node.js](https://nodejs.org) library called
[nightmare](http://www.nightmarejs.org) to perform browser automation. Now, in
general using external node libraries is possible in a Lambda function. First,
you would set up a project folder locally and run `npm install` to load the
external module. Next, zip the entire thing and upload it as the source of your
Lambda function.

The trick with nightmare is, behind the scenes it uses
[Electron](https://electron.atom.io) to run a headless browser session. Most
node modules just contain more JavaScript code, but Electron requires the
installation of native binaries, which doesn't exactly translate to a serverless
environment like Lambda.

### X Window System dependency

As I mentioned, nightmare uses Electron to create a headless browser session.
Now, although Electron won't actually show a browser window, it still requires
an X Window display. I got around having to run a full X11 server on my
Raspberry Pi by using the X virtual framebuffer (Xvfb) package, and creating a
virtual display before launching my node application.

In addition to requiring additional native binaries, this workaround also
requires some setup steps before the actual node application code can be
executed. Neither of these fit with the way Lambda is designed.

<!-- Card for note -->
<div class="card border-info mb-3">

<div class="card-header bg-info text-white">
<i class="fas fa-info-circle"></i> A note on experience
</div>

<div class="card-body" markdown="1">
I've gained a lot more experience with AWS since I originally tackled this
problem. For example, I learned that Lambda functions are run on Amazon Elastic
Compute Cloud (EC2) instances running an Amazon Linux image.

With that knowledge, I could probably bundle the correct native binaries for
Electron and Xvfb into my Lambda function, and modify my application to have it
create the virtual display itself. That would, however, introduce the additional
risk of future incompatibility as AWS continues to update the Amazon Linux image
Lambda uses.

Also, my daughter has gotten older and we no longer track her diapers and
bottles. There is no value in going back and reworking the solution now.
</div>

</div> <!-- End card -->

## Getting a different slice of Pi

Even after mapping out the flow of events and finding all the tools to use to
implement my solution, I spent a good few days frustrated over another issue.
The nightmare library in my Node.js application simply wouldn't work. I had
followed the documentation and even tried the most basic examples with no luck.

Eventually, I was able to find
[this issue on GitHub](https://github.com/MichMich/MagicMirror/issues/145)
for a different project that also uses Electron. Apparently, the native Electron
binaries did not work properly on a Raspberry Pi B+ (which is the model I was
using). I upgraded to a Raspberry Pi 3 and was finally able to get Electron
running.

---

I'm not surprised I ran into issues on this project. There are always hurdles to
overcome. Solving these issues was a great distraction for me during the early
months of my daughter's life. I'm glad to share the results with everyone.

I have heard that Baby Connect is planning to release an actual API at some
point in the near future. This would make most of my efforts obsolete. Although
that is a little frustrating, if they do release an API maybe I will revisit the
project. It would be fun to see what kind of improvements I could make.
