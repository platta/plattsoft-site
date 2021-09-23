---
title: Reading the Event Log with Windows PowerShell
date: '2015-12-03'
author: Adam

layout: post

permalink: /2015/12/03/reading-the-event-log-with-windows-powershell/

categories:
  - Programming
---

_This post is part of the #PSBlogWeek PowerShell blogging series. #PSBlogWeek is
a regular event where anyone interested in writing great content about
PowerShell is welcome to volunteer for. The purpose is to pool our collective
PowerShell knowledge together over a 5-day period and write about a topic that
anyone using PowerShell may benefit from. #PSBlogWeek is a Twitter hashtag so
feel free to stay up to date on the topic on Twitter at the #PSBlogWeek hashtag.
For more information on #PSBlogWeek or if you'd like to volunteer for future
sessions, contact Adam Bertram ([@adbertram](https://twitter.com/adbertram)) on
Twitter._

_Once you're done getting schooled on everything this post has to offer head on
over to the [powershell.org
announcement](http://powershell.org/wp/2015/11/30/the-popular-week-of-powershell-blogging-is-back-psblogweek)
for links to the other four past and upcoming #PSBlogWeek articles this week!_

---

Whether it's an error report, a warning, or just an informational log, one of
the most common places for Windows to write logging information is to the event
logs. There are tons of reasons to open up Event Viewer and peruse the event
logs. Some of the things I've had to do recently include:

- Checking why a service failed to start at boot time.
- Finding the last time a user logged into the computer and who it was.
- Checking for errors after an unexpected restart.

Although Event Viewer is a handy tool, given today's IT landscape, we should
always be looking for more efficient ways to consume data sources like the event
logs. That's why we're going to take a look at the `Get-WinEvent` cmdlet in
PowerShell. This cmdlet is a powerful and flexible way of pulling data out of
the event logs, both in interactive sessions and in scripts.

## Get-WinEvent: The Basics

_Before we get started, don't forget to launch your PowerShell session as
Administrator, since some of the logs (like Security) won't be accessible
otherwise._

Like any good PowerShell cmdlet, `Get-WinEvent` has excellent help, including
fourteen different examples. We're going to review a lot of the important
points, but you can always use `Get-Help Get-WinEvent -Online` to bring the full
help up in a browser window.

Without any parameters, `Get-WinEvent` returns information about every single
event in the every single event log. To get to the specific events you want, you
need to pass one or more parameters to filter the output. Here are the most
common parameters of `Get-WinEvent` and what they do:

- `-LogName` - Filters events in the specified log (think Application, Security,
  System, etc.).
- `-ProviderName` - Filters events created by the specified provider (this is
  the Source column in Event Viewer).
- `-MaxEvents` - Limits the number of events returned.
- `-Oldest` - Sorts the events returned so that the oldest ones are first. By
  default, the newest, most recent events are first.

So, by using these basic parameters, we can build commands that do things like:

Get the last 10 events from the Application log.

```powershell
Get-WinEvent -LogName Application -MaxEvents 10
```

Get the last 5 events logged by Outlook.

```powershell
Get-WinEvent -ProviderName Outlook -MaxEvents 5
```

Get the oldest 50 events from the Application log.

```powershell
Get-WinEvent -LogName Application -MaxEvents 50 -Oldest
```

### Discovering

The event logs have grown up quite a bit since the days when Application,
Security, and System were the only logs to look through. Now there are folders
full of logs. How are you going to know how to reference those logs when you're
using `Get-WinEvent`? You use the `-ListLog` and `-ListProvider` parameters.

For example, consider the log that PowerShell Desired State Configuration (DSC)
uses. In Event Viewer, that log is located under:

`Applications and Services Logs\Microsoft\Windows\Desired State Configuration\Operational`

If I pass that name to the `LogName` parameter of `Get-WinEvent`, I get an
error. To find the name I need to use, I run the command:

``` powershell
Get-WinEvent -ListLog *PowerShell*
```

![Screenshot]({{ '/assets/img/2015/eventlog_002.jpg' | relative_url }})

and see that there are a couple of options. Although there is one that mentions
Desired State Configuration, it doesn't sound like what I'm looking for. Let's
see if the name uses the abbreviation DSC.

``` powershell
Get-WinEvent -ListLog *DSC*
```

![Screenshot]({{ '/assets/img/2015/eventlog_003.jpg' | relative_url }})

That looks like a much better fit. To be sure, you can always check the
properties of a log in Event Viewer and look at the file name.

![Screenshot]({{ '/assets/img/2015/eventlog_004.jpg' | relative_url }})

Bingo.

You can pass `*` to the `-ListLog` or `-ListProvider` parameters to get all logs
or all providers.

## Filtering

The commonly used parameters are great for doing basic filtering, but if you're
doing anything more complicated than a basic health, check you're going to need
a more powerful search. That's where the `-FilterHashtable` parameter comes in.

First, a quick review of hash table syntax. A hash table can be specified on one
line or on multiple lines. Both statements below produce the same hash table.

```powershell
$Hashtable1 = @{Key = "Value"; Foo = "bar"; Bat = "baz"}

$Hashtable2 = @{
    Key = "Value"
    Foo = "bar"
    Bat = "baz"
}
```

When passing a hash table to the `FilterHashtable` parameter, here are some of
the keys you may find useful.

- `LogName` - Same as the `-LogName` parameter
- `ProviderName` - Same as the `ProviderName` parameter
- `ID` - Allows you to filter on the Event ID
- `Level` - Allows you to filter on the severity of the entry (You have to pass
  a number: 4 = Informational, 3 = Warning, 2 = Error)
- `StartTime` - Allows you to filter out events before a certain Date/Time
- `EndTime` - Allows you to filter out events after a certain Date/Time (You can
  use StartTime and EndTime together)
- `UserID` - Allows you to filter on the user that created the event

If this does not provide the level of granularity that you need, don't forget
that you can always pipe the results through `Where-Object` to further refine
your results:

```powershell
Get-WinEvent -FilterHashTable @{LogName = "Application"} -MaxEntries 50 | Where-Object -Property Message -Like "*success*"
```

## Extracting Meaning

Running one of the commands above might produce output that looks like this:

![Screenshot]({{ '/assets/img/2015/eventlog_001.jpg' | relative_url }})

but what `Get-WinEvent` actually returns are objects of type
`[System.Diagnostics.Eventing.Reader.EventLogRecord]`. PowerShell is being nice
and picking just four common properties to show us, but there are more
properties that we can access by storing the results to a variable or using a
cmdlet like `Select-Object`, `Format-Table`, `Format-List`, or even
`Out-GridView`.

Here are some of the properties you might find useful:

- `Id` - Event ID
- `Level` - Numeric representation of the event level
- `LevelDisplayName` - Event level (Information, Error, Warning, etc.)
- `LogName` - Log name (Application, Security, System, etc.)
- `MachineName` - Name of the computer the event is from
- `Message` - Full message of the event
- `ProviderName` - Name of the provider (source) that wrote the event

You can also dig into the message data attached to the event. Event log messages
are defined by the Event ID, so all events with the same Event ID have the same
basic message. Messages can also have placeholders that get filled in with
specific values for each instance of that Event ID. These fill-in-the-blank
values are called "insertion strings," and they can be very useful.

For example, let's say I grabbed an event out of the Application log and stored
it in a variable `$x`. If I just examine `$x`, I can see the full message of the
event is "The session &#8216;183c457c-733c-445d-b5d6-f04fc9623c8b' was
disconnected".

![Screenshot]({{ '/assets/img/2015/eventlog_005.jpg' | relative_url }})

This is where things get interesting. Since Windows Vista, event logs have been
stored in XML format. If you run `(Get-WinEvent -ListLog
Application).LogFilePath` you'll see the .evtx extension on the file. The
`EventLogRecord` objects that `Get-WinEvent` returns have a `ToXml` method that
I can use to get to the XML underneath the object; this is where the insertion
string data is stored.

By converting the event to XML and looking at the insertion strings, I can get
direct access to the value that was inserted into the message without having to
parse the full message and extract it. Here is the code to do that:

```powershell
([xml]$x.ToXml()).Event.EventData.Data
```

The `ToXml` method returns a string containing the XML, and putting the `[xml]`
accelerator in front of it tells PowerShell to read that string and create an
XML object from it. From there, I navigate the XML hierarchy to the place where
the insertion string data is stored.

![Screenshot]({{ '/assets/img/2015/eventlog_006.jpg' | relative_url }})

The messages for different Event IDs can have different numbers of insertion
strings, and you may need to explore a little to figure out exactly how to pull
the specific piece of data you're looking for, but all events for a given Event
ID will be consistent. The example above uses a simple event on purpose, but one
example of how I've used this in my automation is when pulling logon events from
the Security log. Event 4624, which records a successful logon, contains
insertion strings for which user is logging on, what domain they belong to, what
kind of authentication they used, and more.

## Remote Computers

All the cool stuff we just covered above? You can do all of that on remote
targets as well. There are two parameters you can use to have Get-WinEvent get
values from a remote computer:

- `ComputerName` - Lets you specify which computer to connect to remotely
- `Credential` - Lets you specify a credential to use when connecting, in case
  your current session is not running under an account with the appropriate
  permissions.

`Get-WinEvent` does not use PSRemoting to get remote data; just the Event Log
Service. This requires TCP port 135 and a dynamically chosen port above 1024 to
be open in the firewall.

## Putting It All Together

There is more to discover in using the `Get-WinEvent` cmdlet and the data that
it returns but, hopefully, this introduction serves as a thorough foundation for
accessing the event logs from PowerShell. These techniques for discovering,
filtering, and extracting meaning from the event logs can be applied in an
interactive PowerShell session or an automated script. They can also be used to
read the event logs on your local machine or a remote target. It's hard to know
what data you will be searching for to meet your requirements until you are
faced with them, but one thing is for sure: the event logs probably have at
least some of the data you need, and now you know how to get it!

## References

- [https://technet.microsoft.com/en-us/library/hh849682.aspx](https://technet.microsoft.com/en-us/library/hh849682.aspx)
- [http://www.mcbsys.com/blog/2011/04/powershell-get-winevent-vs-get-eventlog](http://www.mcbsys.com/blog/2011/04/powershell-get-winevent-vs-get-eventlog)
- [https://msdn.microsoft.com/en-
  us/library/system.diagnostics.eventing.reader.eventlogrecord.aspx](https://msdn.microsoft.com/en-
  us/library/system.diagnostics.eventing.reader.eventlogrecord.aspx)
- [http://blogs.technet.com/b/heyscriptingguy/archive/2014/06/03/use-filterhashtable-to-filter-event-log-with-powershell.aspx](http://blogs.technet.com/b/heyscriptingguy/archive/2014/06/03/use-filterhashtable-to-filter-event-log-with-powershell.aspx)
