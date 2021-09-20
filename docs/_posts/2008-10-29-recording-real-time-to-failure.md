---
title: Recording Real Time to Failure
date: '2008-10-29'
author: Adam

layout: post

permalink: /2008/10/29/recording-real-time-to-failure/

categories:
  - Software Engineering
---
If the mean time to failure is an important statistic, why only measure it
during development and testing? Building a small, anonymous crash reporting tool
into your application can provide you with a wealth of information and can help
you to improve your overall quality. Of course it would be wise to make sure the
users are aware of this tool, wiser to give them the ability to enable and
disable it as they see fit, and wisest to leave it disabled by default.

The crucial piece of information here is the time to failure of the application.
For this it might not be a bad idea to capture the time at which the application
was started and the time at which the application failed. From those you can
calculate how long the software ran but at the same time you have a little more
detail at your disposal. It would be interesting to see a system in which
crashes always occurred at the same time of day.

It would also be very useful to capture information about the hardware and
operating systems being used to run the application to perform an analysis of
the failure rate across different platforms. It's always possible that there is
a fault which is only triggered on a certain hardware configuration, and this
would enable us to pinpoint these types of issues.

Information reported by this tool could be kept in a database and used for even
more analysis over time. For example, calculating the mean time to failure
grouped by month will give an idea of whether the stability of the product
increases or decreases as we work to repair problems and improve quality.
