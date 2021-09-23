---
title: Internationalization with Import-LocalizedData
date: '2015-08-24'
author: Adam

layout: post

permalink: /2015/08/24/internationalization-with-import-localizeddata/

categories:
  - Programming
---
Recently I was working on a PowerShell project that involved
internationalization. When researching the best approach, I learned about the
`Import-LocalizedData` Cmdlet and it made it incredibly easy to support
internationalization in my scripts.

Before I really get into things, let me clarify a couple similar but distinct
definitions (this is mostly for my own benefit, because I always get them mixed
up):

- **Localization** is the process of translating and adapting a product's
  strings and UI for a new language.
- **Globalization** is the process of preparing a product for localization.
  This is especially relevant for existing products there were initially built
  without internationalization in mind.
- **Internationalization** is the parent term for both globalization and
  localization.

There are actually quite a few definitions for these terms, but this is how
Microsoft defines them. Since we're talking about PowerShell, a Microsoft
product, these are the definitions I'm going to stick with. So you could say
that when you are working with **internationalization** you **globalize** your
application so that it can be **localized** into multiple languages.

To demonstrate this process, let's use a simple example. I've got a script
called `PSUICultureExample.ps1` that looks like this:

```powershell
[System.Windows.Forms.MessageBox]::Show(
    "This is a small example showing how to localize strings in a PowerShell script.",
    "Hello, World!") | Out-Null
```

...and it produces this message box:

{:.text-center}
![The hello world message box in English]({{
'/assets/img/2015/hello_world_english.png' | relative_url }})

Pretty straightforward, but it needs to be globalized.

## Globalizing the Script

To globalize the script, we need to extract the strings that are shown to the
user into an external file. We'll create a subfolder called
`Localized` (you can call it whatever you want) and add a file called
`PSUICultureExample.psd1` that looks like this:

```powershell
ConvertFrom-StringData @"

MessageTitle = Hello, World!
MessageBody = This is a small example showing how to localize strings in a PowerShell script.

"@
```

This file uses the `ConvertFrom-StringData` cmdlet and a
[here-string](https://technet.microsoft.com/en-us/library/ee692792.aspx) to
create a hashtable containing the strings we need as key/value pairs. You can
write any code you'd like that returns a hashtable, I just happen to think this
method is very clean to work with.

The next thing we have to do is load this data into our actual script and use
the hashtable data instead of the hard-coded strings. To import the data, we'll
use this command:

```powershell
$s = Import-LocalizedData -BaseDirectory (Join-Path -Path $PSScriptRoot -ChildPath Localized)
```

The `Import-Localizeddata` Cmdlet, by default, will look in the same folder as
the script for a `psd1` file with the same name. We already named our file
`PSUICultureExample.psd1`, so we're alright there, but the file isn't in the
same folder as our script so we need to specify that path using the
`-BaseDirectory` parameter. You can use relative paths in this parameter, but
they are relative to your PowerShell session's current working directory, not
relative to the script file's directory. We really should use the full path to
be sure we will always point to the right place. A quick `Join-Path` with the
automatic variable `$PSScriptRoot` gives us the full path to the `Localized`
folder we created.

_(If for some reason you're still in PowerShell 2.0, you won't have
`$PSScriptRoot`. [Try this
instead](http://stackoverflow.com/questions/5466329/whats-the-best-way-to-determine-the-location-of-the-current-powershell-script).)_

Now that we have our string data loaded, we just have to swap out the hard-coded
strings and our `PSUICultureExample.ps1` file looks like this:

```powershell
$s = Import-LocalizedData -BaseDirectory (Join-Path -Path $PSScriptRoot -ChildPath Localized)
[System.Windows.Forms.MessageBox]::Show($s.MessageBody, $s.MessageTitle) | Out-Null
```

That's all there is to globalizing our script!

## Localizing the Script

The next step, localizing the script, is very easy because of the way we
implemented our globalization using `Import-LocalizedData`. This Cmdlet uses an
automatic variable called `$PSUICulture` (Now you see why I named the script
that, right?) to determine what language it should try to display to the user
and it will attempt to locate the correct version of our psd1 file by looking in
subfolders named for the appropriate locale. For example, let's say I install
the Spanish Language Pack and change all of my settings to __Spanish
(Spain)__. the `$PSUICulture` automatic variable will contain `es-ES` instead
of `en-US` like it had previously. So what happens when I run my script now?

Yep, everything is still in English. Why? Because I haven't properly localized
the script for Spanish yet. To localize for Spanish, we need to create a
subfolder in the `Localized` folder called `es-ES`, and make a copy of the
`PSUICulture.psd1` file there that contains the same hashtable keys but Spanish
values instead of English ones. I took Spanish in high school, but I'm going to
let Google Translate handle this one:

```powershell
ConvertFrom-StringData @"

MessageTitle = ¡Hola mundo!
MessageBody = Este es un pequeño ejemplo que muestra cómo localizar cadenas en un script de PowerShell.

"@
```

...and now when I run it, it looks like this:

{:.text-center}
![The hello world message box in
Spanish]({{'/assets/img/2015/hello_world_spanish.png' | relative_url }})

¡Bueno! Now everything works for our users in Spain. Our two-line script will
automatically display Spanish text for users that have Windows configured to
display the UI in Spanish.

## Summary

{:.text-center}
![Example Folder Structure]({{ '/assets/img/2015/hello_world_project.png' |
relative_url }})

This is what the folder structure of the full example looks like.

Globalization and Localization are both easy in PowerShell thanks to
`Import-LocalizedData`. It's a powerful Cmdlet that takes a lot of the logic of
picking a language and loading the correct string data out of your hands. If
you're building a script, even if you're not planning to localize it, I would
recommend globalizing your string data. It's a good practice to get into, and
you never know if you might need to localize down the line if the script becomes
popular in the community.

There are two last points I want to bring up. The first is the reason why the
English strings file isn't in an `en-US` folder. This would have worked just
fine, but by leaving a file in the base folder, we are giving
`Import-LocalizedData` a fallback to use if it can't find a matching `psd1` file
for the UI culture specified in `$PSUICulture`.

The second thing I want to add is that `Import-LocalizedData` will not merge a
language-specific file with the fallback file. If you define five values in the
`psd1` file in your base directory but only four of those in the `es-ES` version
of the file, your Spanish users will not see the English value for that fifth
value, it will simply be null.

I've posted the full example on a [GitHub
repository](https://github.com/platta/plattsoft_PSUICultureExample) so you can
easily try it yourself. This is also a great opportunity to become more familiar
with using Git and GitHub. My repository only has the English and Spanish
translations, I would love to receive some pull requests to add more languages!

**Update:** I originally started writing about `Import-LocalizedData` so I could
share an issue I ran into while working with it. I've written that story in a
[follow-up post]({{site.baseurl}}{% post_url
2015-08-27-internationalization-with-import-localizeddata-part-2 %}).
