---
title: Conditional E-mails from SQL Server Reporting Services
date: '2015-05-17'
author: Adam

layout: post

permalink: /2015/05/17/conditional-e-mails-from-sql-server-reporting-services/

categories:
  - Technology
---
SQL Server Reporting Services (SSRS) is a great reporting tool, especially its
ability to schedule reports to be sent out via e-mail. But one thing nobody
wants is useless e-mails flooding their inbox. Some of the reports I've built
using SSRS list problem data that needs to be cleaned up. I don't want those
reports getting sent out every day, even when they're empty. I'm going to show
you the method I used to get SSRS to only send a report under the correct
circumstances.

**Note:** This method is not officially supported by Microsoft and involves
directly modifying SQL Server Agent jobs that are created by SSRS. Also, if your
version of SSRS supports data-driven subscriptions there's a better way to do
this, which you can read about
[here](http://blogs.msdn.com/b/bimusings/archive/2005/07/29/445080.aspx).

## 1. Schedule the report

First, create and schedule the report. SSRS creates a SQL Server Agent job to
run the scheduled report, and you are going to modify that job.

## 2. Find the job id

SSRS uses a GUID as the name of the SQL Server Agent job it creates for each
scheduled report. You need to identify which job is the one you need.

To do this, connect to the server hosting the SSRS database in SQL Management
Studio. The default database name for SSRS is ReportServer. The following query
will return a list of all scheduled reports by name.

```sql
SELECT c.Name, s.ScheduleID, s.SubscriptionID
    FROM [ReportSchedule] AS s
    INNER JOIN [Catalog] AS c ON c.ItemID = s.ReportID
```

The `ScheduleID` field for each row is the job name used for each scheduled
report.

## 3. Edit the job in SQL Server Agent

Now that you know the name of the SQL Server Agent job you need to modify, find
it in the tree view in Management Studio. Right click and bring up the job's
properties, then go to the steps section. There will be one step there named
with the same GUID and "_step_1" at the end. Edit that step, and the command
text will look something like this:

``` sql
exec [ReportServer].dbo.AddEvent @EventType='TimedSubscription', @EventData='SomeGuid'
```

The GUID listed for `@EventData` should match the `SubscriptionID` listed for
the report in the second step.

Modify the T-SQL in this step like this to add your condition:

``` sql
IF <CONDITION>
BEGIN
    exec [ReportServer].dbo.AddEvent @EventType='TimedSubscription', @EventData='SomeGuid'
END
```

Save the changes and you're almost done. There is only one more thing to check.

## 4. Check Security Settings

The SQL Server Agent runs its jobs as the `NT AUTHORITY\NetworkService` account,
so you will need to make sure that account has rights to query your database.
The easiest way to do this is to modify the security for the account at the
server level and configure a user mapping to your database granting the
`db_datareader` role. Exactly how to do this differs depending on what version
of SQL Server you're using, so it's probably better that I don't try to document
the specifics.

At this point, you are all set. The job will still run according to its original
schedule, but will only send a report if your condition evaluates to true.

**Warning:** One important caveat to this method is that SSRS has no idea that
you've edited the SQL Server Agent job, so if anyone modifies the report
schedule via SSRS the changes you made will be overwritten.

## Example

I had a table that was populated nightly by a script that scanned servers on the
network. Any time a new server showed up on the network I would need to manually
assign it to a category. I created a report that would list all the servers that
did not yet have a category, and set it up so that it would only send when
servers like that existed. Here is what the code looked like:

``` sql
IF EXISTS (SELECT * FROM Servers WHERE Category_Id IS NULL) THEN
BEGIN
    exec [ReportServer].dbo.AddEvent @EventType='TimedSubscription', @EventData='SomeGuid'
END
```

This method for conditionally sending SSRS reports lets you create automated
alerts to monitor system health and stability. It's a great trick for any DevOps
engineer to have in his or her tool belt.
