---
title: Searching Your Code with Windows PowerShell
date: '2010-08-12'
author: Adam

layout: post

permalink: /2010/08/12/searching-your-code-with-windows-powershell/

categories:
  - Programming
---
I frequently need to search through source code to find references to variable
and object names. When I got a new workstation running Windows 7 x64, I wanted
to find a search utility that would take full advantage of all the horsepower I
had at my fingertips. Previously, I had used [Windows
Grep](http://www.wingrep.com/), but There didn't seem to be an x64 version
available. After some searching I found a lot of people pointing towards Windows
PowerShell.

There are a lot of powerful commands at your disposal in Windows PowerShell, but
here is the snippet that I have found to suit my needs so far:

``` powershell
$search_path = "C:\source\"

$search_pattern = "SearchTerm"

# -caseSensitive
clear
Get-ChildItem -recurse -include *.sca, *.prg, *.vca, *.fra $search_path | `
    Select-String -pattern $search_pattern | `
    Format-List -GroupBy Filename -Property LineNumber, Line
```

If you recognize those file extensions, you can tell I work in Visual FoxPro,
which is why I'm not just using Visual Studio to search the source code.

The two statements at the top just declare variables to make it easy for me to
change the location and search terms. The actual work occurs in the bottom
block, and combines three cmdlets: `Get-ChildItem`, `Select-String`, and
`Format-List` .

`Get-ChildItem` outputs all of the files of the specified extensions (the
`-Include` flag) recursively (the `-Recurse` flag) through the path provided
(the `$search_path` variable). These files get piped into `Select-String` ,
which performs pattern matching (the `-Pattern` flag) on the contents of each
file and outputs any matches. The final piece, `Format-List`, takes the matches
that `Select-String` found and formats them for display, grouping the results by
file (the `-GroupBy` flag) and displaying the line number and line contents of
each match (the `-Property` flag).

The default output of `Format-List` is much more verbose, and you can tailor it
to show whatever information you find useful, but I've found this to be the
cleanest display for checking code references. I also have `-CaseSensitive`
stuck in a comment in there in case I want to modify `Select-String` to do a
case sensitive search.

The only other pitfall I ran into was after saving this script and trying to
open and run it in the PowerShell ISE, I got an error that that basically said I
didn't have execute permissions. To remedy this, I had to use the
`Set-ExecutionPolicy` cmdlet, which you can read about
[here](http://technet.microsoft.com/en-us/library/ee176961.aspx). I would
definitely recommend reading about this cmdlet before using it, since you
basically have to reduce security to get your script working - well, unless you
want to sign your own script, but I'm not sure what that involves.
