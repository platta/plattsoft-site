---
title: Caching Object Data with Time Stamps
date: '2008-09-18'
author: Adam

layout: post

permalink: /2008/09/18/caching-object-data-with-time-stamps/

categories:
  - Programming
---
When you build an application backed by a database, one of the things you want
to minimize is the amount of data transfer between the application and the
database. There are, of course, two types of data transfer: the application
retrieving data from the database, and the application sending data to the
database. In this post, I want to focus on the former type.

A typical database driven application will gather information from a database
and use that data to populate objects that are in turn used by the application.
If we want to reduce the amount of data we retrieve from the application, there
is one surefire way to do it: keep the data in memory for as long as possible
once you've retrieved it. This sounds easy at first, a good design can enable
you to pass important objects as parameters to many of the functions that need
them to avoid having to fetch the data again. This helps to reduce the load on
the database during a single action that includes multiple function calls, but
what happens when the user repeats that action? If the data is fetched fresh
every time the action is initiated, it's possible that the same data you already
had is being fetched again.

A good way to avoid this scenario is to use static factory methods for your
objects. For example, whenever I need a Widget in my code, I call the function
Widget.GetWidget(x) where x is the primary key of the Widget I want. With this
type of factory function in place, you can implement a cache that sits in
between the caller of the function and the database. Before retrieving the data
from the database, the factory function checks the cache to see if it already
has that Widget. If the cache does not contain the requested Widget, it is
retrieved from the database. If that Widget is in the cache, the factory method
does not need to fetch data from the database, and just returns the Widget's
data.

There is one major problem with this approach in a multi-user system. Imagine
this scenario with two users, A and B, both using the system at the same time.

  1. User A retrieves Widget x from the database.
  2. User B retrieves Widget x from the database.
  3. User B modifies Widget x.
  4. User A requests Widget x again.

In this scenario, when user A makes his second request for Widget x, the cached
copy of Widget x will be returned, but that data is stale and should technically
be retrieved from the database again. Unfortunately, user A's copy of the system
has no way of knowing that.

One possible solution to this problem is the use of a time stamp column. A time
stamp column is a column that is updated with a unique value (usually some
representation of the database server's date and time) any time any of the other
columns are changed in a record. If the table in the database that stores
Widgets has a time stamp column, we can take advantage of that column as an
indicator of stale data. Let's continue the scenario from before from user A's
request for Widget x.

  1. User A requests Widget x again.
  2. The factory method checks to see if Widget x is in its cache.
  3. Widget x is found in the cache.
  4. The factory method retrieves the current time stamp for Widget x.
  5. The factory method compares the retrieved time stamp with the time stamp on
     the cached copy of Widget x.
  6. The time stamps do not match, so the factory method retrieves fresh data
     for Widget x and replaces its copy of Widget x in the cache with the new
     copy.

As you can see, the use of a time stamp column eliminates the possibility of
getting stale data from the cache, unfortunately it also reintroduces some
contact with the database. The amount of overhead required to retrieve a single
column for a single row based on a primary key, however, should still be less
than the overhead required to retrieve every field in that row.
