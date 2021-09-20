---
title: 'Amazon SQS Overview (Part 2) - Security and Dead Letter Queues'
date: '2017-06-05'
author: Adam

layout: post

permalink: /2017/06/05/amazon-sqs-overview-pt2/

excerpt: |
  This is part 2 of my engineer's overview of Amazon SQS. This time we'll cover
  queue security and the concept of dead letter queues.

categories:
  - Cloud
---
I previously began my overview of Amazon SQS by covering the basic concepts and
API functions. In this post, I want to cover two additional topics of interest
to anyone using SQS: queue security and the concept of dead letter queues.

<!-- Card linking to part 1 -->
<div class="card border-info mb-3">

<div class="card-header bg-info text-white">
<i class="fas fa-link"></i> Missed Part 1?
</div>

<div class="card-body" markdown="1">
Go back and read the
[first post]({{ site.baseurl }}{% post_url 2017-05-15-amazon-sqs-overview-pt1 %})
before continuing.
</div>

</div>

## Amazon SQS security

Like practically all AWS resources, SQS queues are secured using policies. A
policy can be attached to a user, group, or role. Which you choose will depend
on exactly what you're building. AWS security policies are expressed in JSON
syntax. They are pretty flexible, but the examples here are basic. Also, note
that the resource ARNs are made up. You will need to substitute the ARN of your
actual queue when using these policies.

In most basic cases, you're going to need two policies: one for whatever writes
to the queue, and one for whatever reads from the queue. You could create one
policy that allows all SQS operations and assign that to both parts of the
process, but please don't. The principle of least privilege is an important
security practice. Each piece of your system should have exactly the rights it
needs to do its job - no more, no less.

### Queue writer policy

The process putting messages in the queue only needs a single permission. Notice
how the action name corresponds exactly with the API call we use? Most AWS
security items follow this pattern.

``` json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "sqs:SendMessage"
      ],
      "Resource": [
        "arn:aws:sqs:region:account-id:queue-name"
      ]
    }
  ]
}
```

### Queue reader policy

The process reading from the queue actually needs two permissions. Remember,
receiving a message from the queue does not delete it. It only makes the message
invisible for a period of time. Once processing is completed, we need to
explicitly issue a delete command, which requires its own separate permission.

``` json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sqs:ReceiveMessage",
                "sqs:DeleteMessage"
            ],
            "Resource": [
                "arn:aws:sqs:region:account-id:queue-name"
            ]
        }
    ]
}
```

## Dead letter queues

In Amazon SQS, messages either get processed and deleted or eventually expire.
Those aren't the only two ways a message gets removed from the queue, though.
SQS also supports dead letter queues, where you can send messages that refuse to
process properly.

Implementing a dead letter queue requires two things:

1. Create another SQS queue to act as the dead letter queue.
2. Configure the original queue with a Redrive Policy.

What's a Redrive Policy? Basically, when you define a Redrive Policy, you tell
SQS how many times a single message is allowed to be received before being
considered dead. Next, you tell your queue which other queue to send dead
messages to. If you get a message in your queue that your processing application
can't properly parse, using a dead letter queue will prevent and endless cycle
of receiving, crashing, and the message becoming visible in the queue again.

Not only is this great because it prevents excessive compute usage by your
processing application, it also provides an excellent hook for notifications.
You can use a CloudWatch alarm, coupled with an SNS topic, to receive
notifications when there is activity in your dead letter queue. That's a bit
beyond the scope of an SQS overview, but maybe I'll write up a separate post
about it at some point.

---

That's it for the basics of Amazon SQS. Remember, there's a lot I didn't cover.
Use this information to get started, but definitely check out the
[official product page](https://aws.amazon.com/sqs)
when you feel comfortable to get a
deeper understanding of the service.
