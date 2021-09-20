---
title: 'Amazon SQS Overview - A Simple but Powerful Queue Service'
date: '2017-05-15'
author: Adam

layout: post

permalink: /2017/05/15/amazon-sqs-overview-pt1/

excerpt: |
  If you're thinking of engineering a solution that incorporates Amazon SQS,
  this overview will help you understand how to get started.

categories:
  - Cloud
---
Amazon Web Services (AWS) offers dozens of cloud services. I'm a huge fan of
their Simple Queue Service (SQS). It's invaluable for asynchronous processing
workflows and helps you decouple the components of your infrastructure. You can
read a lot of the high level information about Amazon SQS on
[their product page](https://aws.amazon.com/sqs). In this post, however, I'd
like to look at the service from an engineer's point of view. If you're going to
use SQS in your next project, what do you need to know? What can it do, and how
does it work? Read on to find out.

## Amazon SQS basics

For basic Amazon SQS use, there are two entities you need to consider: queues
and messages. Queues are the main entity, and they act as containers for
messages. Your code will interact with the queue and its messages using these
operations:

- Write a message to the queue
- Read messages from the queue
- Delete a message from the queue

### The life of a message

The first step in the life of a message is its creation when it is written to
the queue. Messages remain in the queue until they are explicitly deleted or
they expire.

Next, some process will request the newest messages from the queue. A copy of
the message is returned to the requestor. At this point, the message remains in
the queue, but is hidden for a period of time. This prevents other processes
from getting a copy of the message and performing duplicate processing.

From here, there are two things that could happen.

<!-- Card deck to show success and failure -->
<div class="card-deck mb-3">

<div class="card border-success"> <!-- Success card -->

<div class="card-header">
<h5 class="card-title">
<i class="fas fa-check-circle text-success"></i> Success!
</h5>
</div>

<div class="card-body" markdown="1">
The process that received a copy of the message should be doing some kind of
processing using the contents of the message. If the process is successful, the
process will delete the message from the queue upon completion. That is the end
of the line for the message.
</div>

</div> <!-- End card -->

<!-- Failure card -->
<div class="card border-danger">

<div class="card-header">
<h5 class="card-title">
<i class="fas fa-check-circle text-danger"></i> Failure!
</h5>
</div>

<div class="card-body" markdown="1">
If there is an error in processing or it takes too long, the message will become
visible again in the queue. It will then be picked up by another process as it
requests messages from the queue. This loop will continue until the message is
processed successfully (and deleted) or until the message expires.
</div>

</div> <!-- End card -->

</div> <!-- End card deck -->

### Visibility timeout

The time that the message is still in the queue, but hidden, is called the
visibility timeout. There are two critical things to consider regarding the
visibility timeout.

- It protects the queue from processing errors, allowing one message to be
  processed multiple times (but not at the same time) if necessary.
- It can also cause problems in cases where processing a message is successful,
  but takes too long. In these cases you may experience duplicate processing and
  other errors such as attempting to delete a message that has already been
  deleted.

## Common API functions

I'm not going to cover every function available in the Amazon SQS API, or every
parameter in the functions we cover. Also, to save space, my examples will also
not include setup or teardown code. We're just going to look at basic usage of
the three functions you'll need to get started. For information on the other
available functions and their parameters, refer to the [API reference
page](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/APIReference/Welcome.html)
for Amazon SQS.

### SendMessage

This is the function you use to add messages to the queue. It's probably the
most straightforward of the three.

#### SendMessage - Parameters

- __QueueUrl (string)__ _required_ - The URL of the queue the message will be
  sent to. This is pretty easy to find in the queue's info.
- __MessageBody (string)__ _required_ - The actual message to send. Only XML,
  JSON, or unformatted text is supported, and cannot exceed 256 KB. Using XML or
  JSON allows you to serialize complex data so it can be reconstructed by
  whoever receives the message.

#### SendMessage - Return value

This function returns an object with a handful of properties. The most important
of these is the newly created message's `MessageId`.

#### SendMessage - Example

<!-- Tabs -->
<ul class="nav nav-tabs mb-3" id="sendMessageExample" role="tablist">

<li class="nav-item">
<a class="nav-link active" id="sendMessageNode-tab" data-toggle="tab" href="#sendMessageNode"
  role="tab" aria-controls="sendMessageNode" aria-selected="true">Node.js</a>
</li>

<li class="nav-item">
<a class="nav-link" id="sendMessageJava-tab" data-toggle="tab" href="#sendMessageJava"
  role="tab" aria-controls="sendMessageJava" aria-selected="false">Java</a>
</li>

<li class="nav-item">
<a class="nav-link" id="sendMessagePhp-tab" data-toggle="tab" href="#sendMessagePhp"
  role="tab" aria-controls="sendMessagePhp" aria-selected="false">PHP</a>
</li>

</ul>

<!-- Tab content -->
<div class="tab-content" id="sendMessageExampleContent">

<!-- Node.js content -->
<div class="tab-pane fade show active" id="sendMessageNode" role="tabpanel"
  aria-labelledby="sendMessageNode-tab" markdown="1">

``` javascript
var params = {
    QueueUrl: SQS_QUEUE_URL,
    MessageBody: 'This is the body of the message.'
};

sqs.sendMessage(params, function(err, data) {
    if (err) {
        console.log('Error', err);
    } else {
        console.log('Success', data.MessageId);
    }
});
```

</div>

<!-- Java content -->
<div class="tab-pane fade" id="sendMessageJava" role="tabpanel"
  aria-labelledby="sendMessageJava-tab" markdown="1">

``` java
try {
    SendMessageRequest sendRequest;
    sendRequest = new SendMessageRequest(
        SQS_QUEUE_URL,
        "This is the body of the message."
    );

    sqs.sendMessage(sendRequest);

} catch (AmazonServiceException ase) {
    System.out.println("Caught an AmazonServiceException, which means your " +
        "request made it to Amazon SQS, but was rejected with an error " +
        "response for some reason.");
} catch (AmazonClientException ace) {
    System.out.println("Caught an AmazonClientException, which means the " +
        "client encountered a serious internal problem while trying to " +
        "communicate with SQS, such as not being able to access the network.");
}
```

</div>

<!-- PHP content -->
<div class="tab-pane fade" id="sendMessagePhp" role="tabpanel"
  aria-labelledby="sendMessagePhp-tab" markdown="1">

``` php
<?php
$params = [
    'QueueUrl' => $SQS_QUEUE_URL,
    'MessageBody' => "This is the body of the message."
];

try {
    $result = $sqs->sendMessage($params);
    var_dump($result);
} catch (AwsException $e) {
    error_log($e->getMessage());
}
?>
```

</div>

</div> <!-- End tab content -->

### ReceiveMessage

This function is used to receive messages from the queue. You can receive up to
ten messages from a single call to this function. It is also capable of long
polling, waiting up to twenty seconds for a message to hit the queue before
returning.

Another important note here is that the order of message delivery is not
guaranteed on standard Amazon SQS queues. There are FIFO queues that do
guarantee that messages will be delivered in the same order as they were sent,
but they are a bit more complicated than what we are covering here. Because you
can't guarantee the exact order of your messages, always remember to use
timestamps or some other sort key as part of your message body.

#### ReceiveMessage - Parameters

- __QueueUrl (string)__ _required_ - The URL of the queue to retrieve messages
  from.
- __MaxNumberOfMessages (number)__ - Can be used to specify the maximum number
  of messages you want to get back. If this optional parameter is omitted, the
  default value is 1. Maximum possible value is 10. Note that even if you
  specify a value of 10, you might still only get back one or two messages.
- __VisibilityTimeout (number)__ - The number of seconds that received messages
  should remain invisible before becoming available again. There is a default
  value for this specified on the queue itself, but you can override it in this
  function call.
- __WaitTimeSeconds (number)__ - Specifies the number of seconds to wait for
  data before returning. The function will wait up to this many seconds if there
  is no data. But, as soon as there is data the function will return
  immediately. There is a setting for this on the queue itself, but you can
  override it here.

#### ReceiveMessage - Return value

This function returns an object containing a `Messages` property. The `Messages`
property contains an array of message objects. Each one contains a handful of
properties, the most significant of which are the `MessageId`, `ReceiptHandle`,
and `Body` properties.

#### ReceiveMessage - Example

<!-- Tabs -->
<ul class="nav nav-tabs mb-3" id="receiveMessageExample" role="tablist">

<li class="nav-item">
<a class="nav-link active" id="receiveMessageNode-tab" data-toggle="tab" href="#receiveMessageNode"
  role="tab" aria-controls="receiveMessageNode" aria-selected="true">Node.js</a>
</li>

<li class="nav-item">
<a class="nav-link" id="receiveMessageJava-tab" data-toggle="tab" href="#receiveMessageJava"
  role="tab" aria-controls="receiveMessageJava" aria-selected="false">Java</a>
</li>

<li class="nav-item">
<a class="nav-link" id="receiveMessagePhp-tab" data-toggle="tab" href="#receiveMessagePhp"
  role="tab" aria-controls="receiveMessagePhp" aria-selected="false">PHP</a>
</li>

</ul>

<!-- Tab content -->
<div class="tab-content" id="receiveMessageExampleContent">

<!-- Node.js content -->
<div class="tab-pane fade show active" id="receiveMessageNode" role="tabpanel"
  aria-labelledby="receiveMessageNode-tab" markdown="1">

``` javascript
var params = {
    QueueUrl: SQS_QUEUE_URL,
    MaxNumberOfMessages: 10,
    VisibilityTimeout: 90,
    WaitTimeSeconds: 20
};

sqs.receiveMessage(params, function(err, data) {
    if (err) {
        console.log('Error', err);
    } else {
        console.log('Received ' + data.Messages.length + ' messages');

        data.Messages.forEach(function(message) {
            console.log(message.MessageId);
            console.log(message.ReceiptHandle);
            console.log(message.Body);

            console.log('');

            // Here, you should delete the message so it doesn't become visible
            // again.
        });
    }
});
```

</div>

<!-- Java content -->
<div class="tab-pane fade" id="receiveMessageJava" role="tabpanel"
  aria-labelledby="receiveMessageJava-tab" markdown="1">

``` java
try {
    ReceiveMessageRequest receiveMessageRequest;
    receiveMessageRequest = new ReceiveMessageRequest(SQS_QUEUE_URL);
    receiveMessageRequest.setMaxNumberOfMessages(10);
    receiveMessageRequest.setVisibilityTimeout(90);
    receiveMessageRequest.setWaitTimeSeconds(20);

    List<Message> messages;
    messages = sqs.receiveMessage(receiveMessageRequest).getMessages();

    System.out.println("Received " + messages.size() + " messages");

    for (Message message : messages) {
        System.out.println("MessageId: " + message.getMessageId());
        System.out.println("ReceiptHandle: " + message.getReceiptHandle());
        System.out.println("Body: " + message.getBody());

        System.out.println();

        // Here, you should delete the message so it doesn't become visible
        // again.
    }
} catch (AmazonServiceException ase) {
    System.out.println("Caught an AmazonServiceException, which means your " +
        "request made it to Amazon SQS, but was rejected with an error " +
        "response for some reason.");
} catch (AmazonClientException ace) {
    System.out.println("Caught an AmazonClientException, which means the " +
        "client encountered a serious internal problem while trying to " +
        "communicate with SQS, such as not being able to access the network.");
}
```

</div>

<!-- PHP content -->
<div class="tab-pane fade" id="receiveMessagePhp" role="tabpanel"
  aria-labelledby="receiveMessagePhp-tab" markdown="1">

``` php
<?php
$params = [
    'QueueUrl' => $SQS_QUEUE_URL,
    'MaxNumberOfMessages' => 10,
    'VisibilityTimeout' => 90,
    'WaitTimeSeconds' => 20
];

try {
    $result = $client->receiveMessage($params);

    $messages = $result->get('Messages');

    var_dump(count($messages));

    foreach ($messages as $message) {
        var_dump($message);

        // Here, you should delete the message so it doesn't become visible
        // again.
    }
} catch (AwsException $e) {
    error_log($e->getMessage());
}
?>
```

</div>

</div> <!-- End tab content -->

### DeleteMessage

This function is used to delete messages from the queue. It's important to
delete messages from the queue once they've been processed. Otherwise, they will
continue to become available for processing again and again. It's also
interesting to note that the `DeleteMessage` function requires a `ReceiptHandle`
as a parameter. This guarantees that a message cannot be deleted unless it has
been received at least once. This satisfies Amazon SQS's [At-Least-Once
Delivery](http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/standard-queues.html#standard-queues-at-least-once-delivery)
requirement.

#### DeleteMessage - Parameters

- __QueueUrl (string)__ _required_ - The URL of the queue to delete from.
- __ReceiptHandle (string)__ _required_ - The `ReceiptHandle` property of the
  message object that was received from a call to `ReceiveMessage`.

#### DeleteMessage - Return value

There is no return value from this function.

#### DeleteMessage - Example

In this example, I’ve repeated the loop over the received messages from the
`ReceiveMessage` example. This time, I’ve added the call to `DeleteMessage`.

<!-- Tabs -->
<ul class="nav nav-tabs mb-3" id="deleteMessageExample" role="tablist">

<li class="nav-item">
<a class="nav-link active" id="deleteMessageNode-tab" data-toggle="tab" href="#deleteMessageNode"
  role="tab" aria-controls="deleteMessageNode" aria-selected="true">Node.js</a>
</li>

<li class="nav-item">
<a class="nav-link" id="deleteMessageJava-tab" data-toggle="tab" href="#deleteMessageJava"
  role="tab" aria-controls="deleteMessageJava" aria-selected="false">Java</a>
</li>

<li class="nav-item">
<a class="nav-link" id="deleteMessagePhp-tab" data-toggle="tab" href="#deleteMessagePhp"
  role="tab" aria-controls="deleteMessagePhp" aria-selected="false">PHP</a>
</li>

</ul>

<!-- Tab content -->
<div class="tab-content" id="deleteMessageExampleContent">

<!-- Node.js content -->
<div class="tab-pane fade show active" id="deleteMessageNode" role="tabpanel"
  aria-labelledby="deleteMessageNode-tab" markdown="1">

``` javascript
data.Messages.forEach(function(message) {
    console.log(message.MessageId);
    console.log(message.ReceiptHandle);
    console.log(message.Body);

    console.log('');

    // Here, you should delete the message so it doesn't become visible
    // again.
    var deleteParams = {
        QueueUrl: SQS_QUEUE_URL,
        ReceiptHandle: message.ReceiptHandle
    };

    sqs.deleteMessage(deleteParams, function(err, data) {
        if (err) {
            console.log('Delete Error');
        } else {
            console.log('Delete Success');
        }
    });
});
```

</div>

<!-- Java content -->
<div class="tab-pane fade" id="deleteMessageJava" role="tabpanel"
  aria-labelledby="deleteMessageJava-tab" markdown="1">

``` java
for (Message message : messages) {
    System.out.println("MessageId: " + message.getMessageId());
    System.out.println("ReceiptHandle: " + message.getReceiptHandle());
    System.out.println("Body: " + message.getBody());

    System.out.println();

    // Here, you should delete the message so it doesn't become visible
    // again.
    DeleteMessageRequest deleteRequest;
    deleteRequest = new DeleteMessageRequest(
        SQS_QUEUE_URL,
        message.getReceiptHandle()
    );

    sqs.deleteMessage(deleteRequest);
}
```

</div>

<!-- PHP content -->
<div class="tab-pane fade" id="deleteMessagePhp" role="tabpanel"
  aria-labelledby="deleteMessagePhp-tab" markdown="1">

``` php
<?php
foreach ($messages as $message) {
    var_dump($message);

    // Here, you should delete the message so it doesn't become visible
    // again.
    $deleteParams = [
        'QueueUrl' => $SQS_QUEUE_URL,
        'ReceiptHandle' => $message['ReceiptHandle']
    ];

    $deleteResult = $client->deleteMessage($deleteParams);
}
?>
```

</div>

</div> <!-- End tab content -->

---

What other things do you want to know about Amazon SQS? What things did you wish
you know when you first started using it? Start a conversation in the comments!

Even staying as light as I could, this post grew longer than I would've liked.
I'm going to split the last two Amazon SQS topics, security and dead letter
queues, into a separate post. Keep an eye out for it!
