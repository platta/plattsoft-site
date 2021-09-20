---
todo: true

title: Tracking a Baby with AWS and IoT
date: '2017-03-20'
author: Adam

layout: post

permalink: /2017/03/20/tracking-baby-aws-iot/

categories:
  - Cloud
---

I don't talk about it much when I'm in a professional mindset, but I do have a
family at home. My daughter, Aubrey, was born on May 24, 2016. For the first few
months of her life, my wife and I tracked her diaper and feeding schedule
meticulously using an app called [Baby Connect](https://www.baby-connect.com).
It allowed us to record data on our individual phones but have it synchronized
through the cloud. Of course, being the technologist I am I couldn't leave it at
that. Using AWS services and their IoT toolkit, I was able to build some
additional integration points for Baby Connect, allowing me to track diapers
with the push of a button on the changing pad, or bottles with the sound of my
voice and my Amazon Echo.

Read on to learn more about how I did it.

<!-- <img src="https://plattsoft.net/wp-content/uploads/2017/03/XJ3A4267-1024x731.jpg" width="1024" height="731" alt="My Family" class="img-responsive wp-image-1934" srcset="https://plattsoft.net/wp-content/uploads/2017/03/XJ3A4267-200x143.jpg 200w, https://plattsoft.net/wp-content/uploads/2017/03/XJ3A4267-400x286.jpg 400w, https://plattsoft.net/wp-content/uploads/2017/03/XJ3A4267-600x429.jpg 600w, https://plattsoft.net/wp-content/uploads/2017/03/XJ3A4267-800x571.jpg 800w, https://plattsoft.net/wp-content/uploads/2017/03/XJ3A4267-1200x857.jpg 1200w" sizes="(max-width: 800px) 100vw, 600px" /> -->

<div class="card border-info mb-3">
  <div class="card-header bg-info text-white">
    <i class="fas fa-link"></i>
    Want to get right to the code?
  </div>
  <div class="card-body" markdown="1">

There are four separate GitHub repositories for this project.

- [baby-connect](https://github.com/platta/baby-connect) - The Node.js module
  that exposes a Baby Connect API.
- [baby-connect-sqs-listener](https://github.com/platta/baby-connect-sqs-listener)
  \- The Node.js listener application that runs on the Raspberry Pi.
- [baby-connet-lambda](https://github.com/platta/baby-connect-lambda) - The
  Lambda function invoked by the AWS IoT button.
- [baby-connect-alexa-skill](https://github.com/platta/baby-connect-alexa-skill)
  \- All the necessary information to create the custom Alexa skill.

[//]: # (Hello)
  </div>
</div>

## Parts List ##

![diagram](https://plattsoft.net/wp-content/uploads/2017/03/baby-connect-workflow.gif)

This diagram (click for detail) shows a high level overview of the automation I
built. Before going through the flow of everything, let's describe each
individual component for anyone who might not be familiar.

### AWS Services ###

#### AWS Lambda ####

Lambda is AWS’ serverless processing service. It allows you to run your code in
the cloud without worrying about provisioning the virtual infrastructure that
will run it.

#### AWS IoT ####

The AWS IoT service lets you build your own connected Internet of Things. It
maintains a “shadow” copy of your smart device states in the cloud. This allows
communication to occur more smoothly with devices that aren’t always connected.
Devices can also launch actions, such as invoking a Lambda function.

#### Amazon SQS ####

The Simple Queue Service is a brilliant way to decouple application components.
One component might write a message to the queue and then move on to other
tasks. Another component might be polling the queue waiting to handle new
messages.

#### Alexa skills ####

The Amazon Echo is an awesome device. And, if you’re willing to write a little
code, you can extend its functionality by creating custom skills for Alexa.

### Hardware ###

#### AWS IoT Button ####

A more generic version of Amazon's [Dash
Button](https://www.amazon.com/Dash-Buttons/b?ie=UTF8&node=10667898011) that
connects to the AWS IoT service. Pressing the button can invoke actions in
various AWS Services including Lambda, DynamoDB, and SNS.

#### Amazon Echo ####

Amazon's voice-controlled, internet-enabled, wonder device. It can play music,
answer questions, even set timers and reminders. It can also be extended by
developers, which is really why I bought one.

#### Raspberry Pi ####

The remarkable inexpensive credit card sized computer. It's low on horsepower
compared to full size computers, but still has plenty of kick to perform lots of
functions. The [Raspberry Pi Foundation](https://www.raspberrypi.org/) has
created a vibrant community around this device and its many uses.

## Workflow ##

So how does this whole setup work? It might be best to start at the end and work backwards.

### Interacting with Baby Connect ###

Baby Connect, at the time of writing, does not have an API that can be used to
insert new events into their service. The only way to automate data entry is to
automate an actual browser session. We need to simulate the keystrokes and mouse
clicks of a user logging into the web site and performing tasks.

I used a Node.js browser automation library called
[Nightmare](http://www.nightmarejs.org). It is was created for testing web
applications. I wrapped all the browser automation in a module that exposed a
simple interface. In effect, I made my own API.

### The Raspberry Pi ###

The module I built is used by a Node.js application which is run on the
Raspberry Pi. This application has one job - it polls an SQS queue for messages,
each containing a JSON payload describing the data to enter into Baby Connect.
Next, each message the application receives is passed to a corresponding
function call in the Baby Connect module I built. Finally, the module invokes
the browser automation that enters the data via the web site.

### The SQS Queue ###

This is one of my favorite parts of this project. The SQS queue and the
previously discussed components can stand on their own as a complete system. I
used an AWS IoT button and my Echo to launch actions that write messages to the
queue. But, technically _any_ process writes properly formatted JSON to the
queue is valid here. If you came up with five other convenient ways to signal
that you wanted to record a wet diaper, you wouldn't have to modify the
configuration of the queue or any of the previously discussed components.

This is what we call decoupling, and SQS is one of the prime methods for
achieving it within AWS. The queue doesn't care (well, beyond permissions) who
adds or removes messages. As far as SQS is concerned, you could have one or
twenty methods of adding messages to the queue, and one or a thousand agents
polling the queue for messages to process. Either side can scale independently
of the other with no configuration changes required. Furthermore, queue
operations are asynchronous. That means a program writing a message to the queue
gets control back immediately and does not have to wait for someone else to
process the message.

### The Alexa Skill ###

Alexa skills consist of a couple pieces. You have to define the voice
commands that are valid for your skill with a list of sample "utterances." You
also have to declare the interface that your skill supports, the available
commands and what variables will be present in what is spoken (i.e. wet diaper
vs. dirty diaper).

All of this determines how Alexa will process spoken commands, but you also have
to provide a backend that will be invoked with the results of this processing.
In this project, for example, I used a Lambda function to perform that role. The
Lambda function gets invoked with a JSON object representing the parsed voice
command. From there, the input is used to build the JSON object that gets insert
into the SQS queue. Finally, a response is provided to the Alexa service,
including a spoken response which in most cases is just "OK."

### The AWS IoT Button ###

This was one of the easiest pieces to set up. AWS has a wizard for connecting
and configuring AWS IoT buttons, which meant all I had to do was write the
Lambda function to be invoked when I pressed the button.

AWS IoT buttons have three types of presses: single press, double press, and
long press. When a press is detected, information on the type of press is
included in a JSON payload that AWS passes to the Lambda function. The function
I wrote reads that information and passes a JSON object with one of three diaper
types (wet, dirty, or both) into the SQS queue.

<hr class="my-3" />

To some, this project might seem like overkill. As a first-time father getting
very little sleep, there's a part of me that would agree. At the same time,
technology is my passion, so I am always driven to see what I can build to make
life easier. I also needed something to distract me from the never-ending cycle
of crying, pooping, and sleeping.

There is one other person (so far) who has found my project on GitHub and
implemented it in his own home. This is also why I continue to push myself to
build things; the sense of satisfaction I feel from helping someone else with a
similar problem is huge. I hope that more people are able to benefit, even if
only in a small way, from my work. If nothing else, it was a great exercise in
getting more familiar with AWS.

<div class="card border-info mb-3">
  <div class="card-header bg-info text-white">
    <i class="fas fa-link"></i>
    Check out the follow-up post
  </div>
  <div class="card-body" markdown="1">

I posted a follow-up discussing some of the hurdles I had to overcome building
this project. [Check it out]({{ site.baseurl }}{% post_url
2017-04-03-baby-connect-project-design-considerations %})!

  </div>
</div>
