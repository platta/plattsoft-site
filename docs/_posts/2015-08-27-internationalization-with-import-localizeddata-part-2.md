---
title: 'Internationalization with Import-LocalizedData: Part 2'
date: '2015-08-27'
author: Adam

layout: post

permalink: /2015/08/27/internationalization-with-import-localizeddata-part-2/

categories:
  - Programming
---
When I first sat down to write this post, [this one]({{ site.baseurl }}{%
post_url 2015-08-24-internationalization-with-import-localizeddata %}) came out
instead. If you're not familiar with the `Import-LocalizedData` Cmdlet, you
might want to start there.

I want to talk some more about `Import-LocalizedData`, but more specifically the
way it works with the automatic variable `$PSUICulture` and some interesting
behavior I observed there. The
[about_Script_Internationalization](https://technet.microsoft.com/en-us/library/Hh847854.aspx)
help topic details how both the Cmdlet and automatic variable were added in
PowerShell version 2.0 to strengthen support for internationalization.
Basically, `$PSUICulture` will contain the region code for whatever language
Windows has been configured to display itself in, and this is the language that
`Import-LocalizedData` will look for by default. This is very powerful because
now my scripts have zero code in them that's trying to figure out which
translation of the resource file they should use.

As I mentioned in my previous post, I was working on a PowerShell project that
involved internationalization, which is how I found myself using
`Import-LocalizedData` in the first place. Another part of the project was
configuring virtual machines as they were provisioned, including updating the
Regional Settings based on the users' preferences.

<figure class="figure text-center d-block">
<img
  src="{{'/assets/img/2015/regional_settings.jpg' | relative_url }}"
  class="img-fluid figure-img"
/>
<figcaption class="figure-caption">Regional Settings - Keyboards and Languages Tab</figcaption>
</figure>

The client had specified which settings on the Regional Settings applet they
would like to set based on the culture, and had wanted to leave some of the
system level settings set to the default American English. I had to make sure
that wouldn't affect my scripts' ability to present properly localized text, so
I did some testing to make sure I knew specifically which setting would get
`$PSUICulture` to reflect the user's language. I found that the Display Language
setting on the Keyboards and Languages tab is what did it, which was great
because it is not one of the system level settings.

It's important to note that you don't normally see the dropdown to select a
display language. It only appears once you've installed one or more additional
languages. I was able to access the necessary language files through my MSDN
subscription.

Fast forward to a couple of weeks later, and we had run into a problem. A
Japanese user had provisioned a virtual machine for himself and selected
Japanese as his preferred language, but my scripts were still displaying text in
English. I grabbed the Japanese language files from MSDN and installed them on
my test machine. Sure enough, when I set the display language to Japanese,
PowerShell was still in English. If I changed everything in Regional Settings to
Japanese, however, it worked properly.

It took me a number of tries to identify the exact conditions required to get
the correct value of `ja-JP` in `$PSUICulture`. It turned out to be that both
the Display Language and the System Locale had to be set to Japanese in order
for it to work.

<figure class="figure text-center d-block">
<img
  src="{{'/assets/img/2015/regional_settings2.jpg' | relative_url }}"
  class="img-fluid figure-img"
/>
<figcaption class="figure-caption">Regional Settings - Administrative Tab</figcaption>
</figure>

I thought I was losing my mind, I had tested this so many times and I was always
able to get the correct results just by changing the Display Language. I started
installing more languages on my test machine and testing the settings with them.
Some of them worked just on Display Language, but some also required the System
Locale. Finally I realized what was different about the languages that behaved
differently - the glyphs. Languages like Japanese, Russian, and Thai don't use
the latin alphabet that languages like American and Spanish use. These were the
ones that required the System Locale to be set in addition to the Display
Language for PowerShell to correctly detect the language.

The System Locale was one of the system level settings that the client did not
want to change. Luckily the region code for the language the user had selected
got stored locally on the machine. I was able to pass that into the `-UICulture`
parameter of `Import-LocalizedData` and explicitly tell the Cmdlet which
language to use.

PowerShell is a great and powerful tool for IT Administrators and Software
Engineers alike. Its strength, flexibility, and extensibility still regularly
impress me. Be that as it may, experiences like this one remind that, just like
any language, there are always gotchas and quirks to be worked around. Happy
scripting!
