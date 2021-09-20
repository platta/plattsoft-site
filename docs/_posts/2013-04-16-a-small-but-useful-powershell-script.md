---
title: A Small but Useful PowerShell Script
date: '2013-04-16'
author: Adam

layout: post

permalink: /2013/04/16/a-small-but-useful-powershell-script/

excerpt: I always keep this little script handy for when I need to search my
         source code for instances of a particular word or phrase.  Most modern
         IDEs have this kind of functionality built in, but you never know when
         you'll have to work with a language or tool that isn't quite as robust.

categories:
  - Programming
---
I always keep this little PowerShell script handy for when I need to search my
source code for instances of a particular word or phrase. Most modern IDEs have
this kind of functionality built in, but you never know when you'll have to work
with a language or tool that isn't quite as robust.

``` powershell
$search_path = "c:\Your\Search\Path\"
$search_pattern = "YourSearchTerm"

clear

Get-ChildItem -recurse -include *.txt, *.cs $search_path | `
    Select-String -pattern $search_pattern | `
    Format-List -GroupBy Filename -Property LineNumber, Line
```
