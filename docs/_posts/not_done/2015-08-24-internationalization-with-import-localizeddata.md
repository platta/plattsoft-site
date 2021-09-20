---
id: 1531
title: Internationalization with Import-LocalizedData
date: '2015-08-24'
author: Adam
layout: post
guid: http://45.55.182.154/?p=1531
permalink: /2015/08/24/internationalization-with-import-localizeddata/
dsq_thread_id:
  - "4061994877"
avada_post_views_count:
  - "2780"
pyre_show_first_featured_image:
  - 'no'
pyre_portfolio_width_100:
  - default
pyre_video:
  - ""
pyre_fimg_width:
  - ""
pyre_fimg_height:
  - ""
pyre_image_rollover_icons:
  - default
pyre_link_icon_url:
  - ""
pyre_post_links_target:
  - 'no'
pyre_related_posts:
  - default
pyre_share_box:
  - default
pyre_post_pagination:
  - default
pyre_author_info:
  - default
pyre_post_meta:
  - default
pyre_post_comments:
  - default
pyre_main_top_padding:
  - ""
pyre_main_bottom_padding:
  - ""
pyre_hundredp_padding:
  - ""
pyre_slider_position:
  - default
pyre_slider_type:
  - 'no'
pyre_slider:
  - "0"
pyre_wooslider:
  - "0"
pyre_revslider:
  - "0"
pyre_elasticslider:
  - "0"
pyre_fallback:
  - ""
pyre_avada_rev_styles:
  - default
pyre_display_header:
  - 'yes'
pyre_header_100_width:
  - default
pyre_header_bg:
  - ""
pyre_header_bg_color:
  - ""
pyre_header_bg_opacity:
  - ""
pyre_header_bg_full:
  - 'no'
pyre_header_bg_repeat:
  - repeat
pyre_displayed_menu:
  - default
pyre_display_footer:
  - default
pyre_display_copyright:
  - default
pyre_footer_100_width:
  - default
pyre_sidebar_position:
  - default
pyre_sidebar_bg_color:
  - ""
pyre_page_bg_layout:
  - default
pyre_page_bg:
  - ""
pyre_page_bg_color:
  - ""
pyre_page_bg_full:
  - 'no'
pyre_page_bg_repeat:
  - repeat
pyre_wide_page_bg:
  - ""
pyre_wide_page_bg_color:
  - ""
pyre_wide_page_bg_full:
  - 'no'
pyre_wide_page_bg_repeat:
  - repeat
pyre_page_title:
  - default
pyre_page_title_text:
  - default
pyre_page_title_text_alignment:
  - default
pyre_page_title_100_width:
  - default
pyre_page_title_custom_text:
  - ""
pyre_page_title_text_size:
  - ""
pyre_page_title_custom_subheader:
  - ""
pyre_page_title_custom_subheader_text_size:
  - ""
pyre_page_title_font_color:
  - ""
pyre_page_title_height:
  - ""
pyre_page_title_mobile_height:
  - ""
pyre_page_title_bar_bg:
  - ""
pyre_page_title_bar_bg_retina:
  - ""
pyre_page_title_bar_bg_color:
  - ""
pyre_page_title_bar_borders_color:
  - ""
pyre_page_title_bar_bg_full:
  - default
pyre_page_title_bg_parallax:
  - default
pyre_page_title_breadcrumbs_search_bar:
  - default
fusion_builder_status:
  - inactive
sbg_selected_sidebar:
  - 'a:1:{i:0;s:1:"0";}'
sbg_selected_sidebar_replacement:
  - 'a:1:{i:0;s:0:"";}'
sbg_selected_sidebar_2:
  - 'a:1:{i:0;s:1:"0";}'
sbg_selected_sidebar_2_replacement:
  - 'a:1:{i:0;s:0:"";}'
fusion_builder_content_backup:
  - |
    Recently I was working on a PowerShell project that involved internationalization. When researching the best approach, I learned about the <code>Import-LocalizedData</code> Cmdlet and it made it incredibly easy to support internationalization in my scripts.
    
    Before I really get into things, let me clarify a couple similar but distinct definitions (this is mostly for my own benefit, because I always get them mixed up):
    <ul>
    <li><strong>Localization</strong> is the process of translating and adapting a product's strings and UI for a new language.</li>
    <li><strong>Globalization</strong> is the process of preparing a product for localization. This is especially relevant for existing products there were initially built without internationalization in mind.</li>
    <li><strong>Internationalization</strong> is the parent term for both globalization and localization.</li>
    </ul>
    There are actually quite a few definitions for these terms, but this is how Microsoft defines them. Since we're talking about PowerShell, a Microsoft product, these are the definitions I'm going to stick with. So you could say that when you are working with <strong>internationalization</strong> you <strong>globalize</strong> your application so that it can be <strong>localized</strong> into multiple languages.
    
    To demonstrate this process, let's use a simple example. I've got a script called <code>PSUICultureExample.ps1</code> that looks like this:
    
    [powershell]
    [System.Windows.Forms.MessageBox]::Show(
    &quot;This is a small example showing how to localize strings in a PowerShell script.&quot;,
    &quot;Hello, World!&quot;) | Out-Null
    [/powershell]
    
    ...and it produces this message box:
    
    <img class="aligncenter size-full wp-image-1540" src="http://45.55.182.154/wp-content/uploads/2015/08/HelloWorld_English.png" alt="The hello world message box in English." width="459" height="143" />
    
    Pretty straightforward, but it needs to be globalized.
    <h2>Globalizing the Script</h2>
    To globalize the script, we need to extract the strings that are shown to the user into an external file. We'll create a subfolder called <code>Localized</code> (you can call it whatever you want) and add a file called <code>PSUICultureExample.psd1</code> that looks like this:
    
    [powershell]
    ConvertFrom-StringData @&quot;
    
    MessageTitle = Hello, World!
    MessageBody = This is a small example showing how to localize strings in a PowerShell script.
    
    &quot;@
    [/powershell]
    
    This file uses the <code>ConvertFrom-StringData</code> cmdlet and a <a href="https://technet.microsoft.com/en-us/library/ee692792.aspx" target="_blank">here-string</a> to create a hashtable containing the strings we need as key/value pairs. You can write any code you'd like that returns a hashtable, I just happen to think this method is very clean to work with.
    
    The next thing we have to do is load this data into our actual script and use the hashtable data instead of the hard-coded strings. To import the data, we'll use this command:
    
    [powershell]
    $s = Import-LocalizedData -BaseDirectory (Join-Path -Path $PSScriptRoot -ChildPath Localized)
    [/powershell]
    
    The <code>Import-Localizeddata</code> Cmdlet, by default, will look in the same folder as the script for a <code>psd1</code> file with the same name. We already named our file <code>PSUICultureExample.psd1</code>, so we're alright there, but the file isn't in the same folder as our script so we need to specify that path using the <code>-BaseDirectory</code> parameter. You can use relative paths in this parameter, but they are relative to your PowerShell session's current working directory, not relative to the script file's directory. We really should use the full path to be sure we will always point to the right place. A quick <code>Join-Path</code> with the automatic variable <code>$PSScriptRoot</code> gives us the full path to the <code>Localized</code> folder we created.
    
    <em>(If for some reason you're still in PowerShell 2.0, you won't have <code>$PSScriptRoot</code>. <a href="http://stackoverflow.com/questions/5466329/whats-the-best-way-to-determine-the-location-of-the-current-powershell-script" target="_blank">Try this instead</a>.)</em>
    
    Now that we have our string data loaded, we just have to swap out the hard-coded strings and our <code>PSUICultureExample.ps1</code> file looks like this:
    
    [powershell]
    $s = Import-LocalizedData -BaseDirectory (Join-Path -Path $PSScriptRoot -ChildPath Localized)
    [System.Windows.Forms.MessageBox]::Show($s.MessageBody, $s.MessageTitle) | Out-Null
    [/powershell]
    
    That's all there is to globalizing our script!
    <h2>Localizing the Script</h2>
    The next step, localizing the script, is very easy because of the way we implemented our globalization using <code>Import-LocalizedData</code>. This Cmdlet uses an automatic variable called <code>$PSUICulture</code> (Now you see why I named the script that, right?) to determine what language it should try to display to the user and it will attempt to locate the correct version of our psd1 file by looking in subfolders named for the appropriate locale. For example, let's say I install the Spanish Language Pack and change all of my settings to <em>Spanish (Spain)</em>. the <code>$PSUICulture</code> automatic variable will contain <code>es-ES</code> instead of <code>en-US</code> like it had previously. So what happens when I run my script now?
    
    Yep, everything is still in English. Why? Because I haven't properly localized the script for Spanish yet. To localize for Spanish, we need to create a subfolder in the <code>Localized</code> folder called <code>es-ES</code>, and make a copy of the <code>PSUICulture.psd1</code> file there that contains the same hashtable keys but Spanish values instead of English ones. I took Spanish in high school, but I'm going to let Google Translate handle this one:
    
    [powershell]
    ConvertFrom-StringData @&quot;
    
    MessageTitle = ¡Hola mundo!
    MessageBody = Este es un pequeño ejemplo que muestra cómo localizar cadenas en un script de PowerShell.
    
    &quot;@
    [/powershell]
    
    ...and now when I run it, it looks like this:
    
    <img class="aligncenter size-full wp-image-1542" src="http://45.55.182.154/wp-content/uploads/2015/08/HelloWorld_Spanish.png" alt="The hello world message box in Spanish" width="480" height="158" />
    
    ¡Bueno! Now everything works for our users in Spain. Our two-line script will automatically display Spanish text for users that have Windows configured to display the UI in Spanish.
    <h2>Summary</h2>
    [caption id="attachment_1548" align="alignleft" width="228"]<img class="size-full wp-image-1548" src="http://45.55.182.154/wp-content/uploads/2015/08/ProjectStructure.png" alt="Example Folder Structure" width="228" height="156" /> This is what the folder structure of the full example looks like.[/caption]
    
    Globalization and Localization are both easy in PowerShell thanks to <code>Import-LocalizedData</code>. It's a powerful Cmdlet that takes a lot of the logic of picking a language and loading the correct string data out of your hands. If you're building a script, even if you're not planning to localize it, I would recommend globalizing your string data. It's a good practice to get into, and you never know if you might need to localize down the line if the script becomes popular in the community.
    
    There are two last points I want to bring up. The first is the reason why the English strings file isn't in an <code>en-US</code> folder. This would have worked just fine, but by leaving a file in the base folder, we are giving <code>Import-LocalizedData</code> a fallback to use if it can't find a matching <code>psd1</code> file for the UI culture specified in <code>$PSUICulture</code>.
    
    The second thing I want to add is that <code>Import-LocalizedData</code> will not merge a language-specific file with the fallback file. If you define five values in the <code>psd1</code> file in your base directory but only four of those in the <code>es-ES</code> version of the file, your Spanish users will not see the English value for that fifth value, it will simply be null.
    
    I've posted the full example on a <a href="https://github.com/platta/plattsoft_PSUICultureExample" target="_blank">GitHub repository</a> so you can easily try it yourself. This is also a great opportunity to become more familiar with using Git and GitHub. My repository only has the English and Spanish translations, I would love to receive some pull requests to add more languages!
    
    <strong>Update:</strong> I originally started writing about <code>Import-LocalizedData</code> so I could share an issue I ran into while working with it. I've written that story in a <a href="http://45.55.182.154/2015/08/27/internationalization-with-import-localizeddata-part-2/">follow-up post</a>.
fusion_builder_converted:
  - 'yes'
image: /wp-content/uploads/2015/08/IMG_2508-125x125.png
categories:
  - Programming
---
Recently I was working on a PowerShell project that involved internationalization. When researching the best approach, I learned about the `Import-LocalizedData` Cmdlet and it made it incredibly easy to support internationalization in my scripts.

Before I really get into things, let me clarify a couple similar but distinct definitions (this is mostly for my own benefit, because I always get them mixed up):

  * **Localization** is the process of translating and adapting a product's strings and UI for a new language.
  * **Globalization** is the process of preparing a product for localization. This is especially relevant for existing products there were initially built without internationalization in mind.
  * **Internationalization** is the parent term for both globalization and localization.

There are actually quite a few definitions for these terms, but this is how Microsoft defines them. Since we're talking about PowerShell, a Microsoft product, these are the definitions I'm going to stick with. So you could say that when you are working with **internationalization** you **globalize** your application so that it can be **localized** into multiple languages.

To demonstrate this process, let's use a simple example. I've got a script called `PSUICultureExample.ps1` that looks like this:

<div class="fusion-fullwidth fullwidth-box hundred-percent-fullwidth non-hundred-percent-height-scrolling"  style='background-color: rgba(255,255,255,0);background-position: center center;background-repeat: no-repeat;padding-top:0px;padding-right:0px;padding-bottom:0px;padding-left:0px;'>
  <div class="fusion-builder-row fusion-row ">
    <div  class="fusion-layout-column fusion_builder_column fusion_builder_column_1_1 fusion-builder-column-52 fusion-one-full fusion-column-first fusion-column-last fusion-column-no-min-height 1_1"  style='margin-top:0px;margin-bottom:0px;'>
      <div class="fusion-column-wrapper" style="background-position:left top;background-repeat:no-repeat;-webkit-background-size:cover;-moz-background-size:cover;-o-background-size:cover;background-size:cover;"   data-bg-url="">
        <pre class="brush: powershell; title: ; notranslate" title="">
[System.Windows.Forms.MessageBox]::Show(
    "This is a small example showing how to localize strings in a PowerShell script.",
    "Hello, World!") | Out-Null
</pre>
        
        <p>
          &#8230;and it produces this message box:
        </p>
        
        <p>
          <img class="aligncenter size-full wp-image-1540" src="http://45.55.182.154/wp-content/uploads/2015/08/HelloWorld_English.png" alt="The hello world message box in English." width="459" height="143" srcset="https://plattsoft.net/wp-content/uploads/2015/08/HelloWorld_English-300x93.png 300w, https://plattsoft.net/wp-content/uploads/2015/08/HelloWorld_English.png 459w" sizes="(max-width: 459px) 100vw, 459px" />
        </p>
        
        <p>
          Pretty straightforward, but it needs to be globalized.
        </p>
        
        <h2>
          Globalizing the Script
        </h2>
        
        <p>
          To globalize the script, we need to extract the strings that are shown to the user into an external file. We'll create a subfolder called <code>Localized</code> (you can call it whatever you want) and add a file called <code>PSUICultureExample.psd1</code> that looks like this:
        </p>
        
        <div class="fusion-clearfix">
        </div>
      </div>
    </div>
    
    <div  class="fusion-layout-column fusion_builder_column fusion_builder_column_1_1 fusion-builder-column-53 fusion-one-full fusion-column-first fusion-column-last fusion-column-no-min-height 1_1"  style='margin-top:0px;margin-bottom:0px;'>
      <div class="fusion-column-wrapper" style="background-position:left top;background-repeat:no-repeat;-webkit-background-size:cover;-moz-background-size:cover;-o-background-size:cover;background-size:cover;"   data-bg-url="">
        <pre class="brush: powershell; title: ; notranslate" title="">
ConvertFrom-StringData @"

MessageTitle = Hello, World!
MessageBody = This is a small example showing how to localize strings in a PowerShell script.

"@
</pre>
        
        <p>
          This file uses the <code>ConvertFrom-StringData</code> cmdlet and a <a href="https://technet.microsoft.com/en-us/library/ee692792.aspx" target="_blank">here-string</a> to create a hashtable containing the strings we need as key/value pairs. You can write any code you'd like that returns a hashtable, I just happen to think this method is very clean to work with.
        </p>
        
        <p>
          The next thing we have to do is load this data into our actual script and use the hashtable data instead of the hard-coded strings. To import the data, we'll use this command:
        </p>
        
        <div class="fusion-clearfix">
        </div>
      </div>
    </div>
    
    <div  class="fusion-layout-column fusion_builder_column fusion_builder_column_1_1 fusion-builder-column-54 fusion-one-full fusion-column-first fusion-column-last fusion-column-no-min-height 1_1"  style='margin-top:0px;margin-bottom:0px;'>
      <div class="fusion-column-wrapper" style="background-position:left top;background-repeat:no-repeat;-webkit-background-size:cover;-moz-background-size:cover;-o-background-size:cover;background-size:cover;"   data-bg-url="">
        <pre class="brush: powershell; title: ; notranslate" title="">
$s = Import-LocalizedData -BaseDirectory (Join-Path -Path $PSScriptRoot -ChildPath Localized)
</pre>
        
        <p>
          The <code>Import-Localizeddata</code> Cmdlet, by default, will look in the same folder as the script for a <code>psd1</code> file with the same name. We already named our file <code>PSUICultureExample.psd1</code>, so we're alright there, but the file isn't in the same folder as our script so we need to specify that path using the <code>-BaseDirectory</code> parameter. You can use relative paths in this parameter, but they are relative to your PowerShell session's current working directory, not relative to the script file's directory. We really should use the full path to be sure we will always point to the right place. A quick <code>Join-Path</code> with the automatic variable <code>$PSScriptRoot</code> gives us the full path to the <code>Localized</code> folder we created.
        </p>
        
        <p>
          <em>(If for some reason you're still in PowerShell 2.0, you won't have <code>$PSScriptRoot</code>. <a href="http://stackoverflow.com/questions/5466329/whats-the-best-way-to-determine-the-location-of-the-current-powershell-script" target="_blank">Try this instead</a>.)</em>
        </p>
        
        <p>
          Now that we have our string data loaded, we just have to swap out the hard-coded strings and our <code>PSUICultureExample.ps1</code> file looks like this:
        </p>
        
        <div class="fusion-clearfix">
        </div>
      </div>
    </div>
    
    <div  class="fusion-layout-column fusion_builder_column fusion_builder_column_1_1 fusion-builder-column-55 fusion-one-full fusion-column-first fusion-column-last fusion-column-no-min-height 1_1"  style='margin-top:0px;margin-bottom:0px;'>
      <div class="fusion-column-wrapper" style="background-position:left top;background-repeat:no-repeat;-webkit-background-size:cover;-moz-background-size:cover;-o-background-size:cover;background-size:cover;"   data-bg-url="">
        <pre class="brush: powershell; title: ; notranslate" title="">
$s = Import-LocalizedData -BaseDirectory (Join-Path -Path $PSScriptRoot -ChildPath Localized)
[System.Windows.Forms.MessageBox]::Show($s.MessageBody, $s.MessageTitle) | Out-Null
</pre>
        
        <p>
          That's all there is to globalizing our script!
        </p>
        
        <h2>
          Localizing the Script
        </h2>
        
        <p>
          The next step, localizing the script, is very easy because of the way we implemented our globalization using <code>Import-LocalizedData</code>. This Cmdlet uses an automatic variable called <code>$PSUICulture</code> (Now you see why I named the script that, right?) to determine what language it should try to display to the user and it will attempt to locate the correct version of our psd1 file by looking in subfolders named for the appropriate locale. For example, let's say I install the Spanish Language Pack and change all of my settings to <em>Spanish (Spain)</em>. the <code>$PSUICulture</code> automatic variable will contain <code>es-ES</code> instead of <code>en-US</code> like it had previously. So what happens when I run my script now?
        </p>
        
        <p>
          Yep, everything is still in English. Why? Because I haven't properly localized the script for Spanish yet. To localize for Spanish, we need to create a subfolder in the <code>Localized</code> folder called <code>es-ES</code>, and make a copy of the <code>PSUICulture.psd1</code> file there that contains the same hashtable keys but Spanish values instead of English ones. I took Spanish in high school, but I'm going to let Google Translate handle this one:
        </p>
        
        <div class="fusion-clearfix">
        </div>
      </div>
    </div>
    
    <div  class="fusion-layout-column fusion_builder_column fusion_builder_column_1_1 fusion-builder-column-56 fusion-one-full fusion-column-first fusion-column-last fusion-column-no-min-height 1_1"  style='margin-top:0px;margin-bottom:0px;'>
      <div class="fusion-column-wrapper" style="background-position:left top;background-repeat:no-repeat;-webkit-background-size:cover;-moz-background-size:cover;-o-background-size:cover;background-size:cover;"   data-bg-url="">
        <pre class="brush: powershell; title: ; notranslate" title="">
ConvertFrom-StringData @"

MessageTitle = ¡Hola mundo!
MessageBody = Este es un pequeño ejemplo que muestra cómo localizar cadenas en un script de PowerShell.

"@
</pre>
        
        <p>
          &#8230;and now when I run it, it looks like this:
        </p>
        
        <p>
          <img class="aligncenter size-full wp-image-1542" src="http://45.55.182.154/wp-content/uploads/2015/08/HelloWorld_Spanish.png" alt="The hello world message box in Spanish" width="480" height="158" srcset="https://plattsoft.net/wp-content/uploads/2015/08/HelloWorld_Spanish-300x100.png 300w, https://plattsoft.net/wp-content/uploads/2015/08/HelloWorld_Spanish.png 480w" sizes="(max-width: 480px) 100vw, 480px" />
        </p>
        
        <p>
          ¡Bueno! Now everything works for our users in Spain. Our two-line script will automatically display Spanish text for users that have Windows configured to display the UI in Spanish.
        </p>
        
        <h2>
          Summary
        </h2>
        
        <div class="fusion-clearfix">
        </div>
      </div>
    </div>
    
    <div  class="fusion-layout-column fusion_builder_column fusion_builder_column_1_1 fusion-builder-column-57 fusion-one-full fusion-column-first fusion-column-last fusion-column-no-min-height 1_1"  style='margin-top:0px;margin-bottom:0px;'>
      <div class="fusion-column-wrapper" style="background-position:left top;background-repeat:no-repeat;-webkit-background-size:cover;-moz-background-size:cover;-o-background-size:cover;background-size:cover;"   data-bg-url="">
        <div id="attachment_1548" style="width: 238px" class="wp-caption alignleft">
          <img aria-describedby="caption-attachment-1548" class="size-full wp-image-1548" src="http://45.55.182.154/wp-content/uploads/2015/08/ProjectStructure.png" alt="Example Folder Structure" width="228" height="156" />
          
          <p id="caption-attachment-1548" class="wp-caption-text">
            This is what the folder structure of the full example looks like.
          </p>
        </div>
        
        <p>
          Globalization and Localization are both easy in PowerShell thanks to <code>Import-LocalizedData</code>. It's a powerful Cmdlet that takes a lot of the logic of picking a language and loading the correct string data out of your hands. If you're building a script, even if you're not planning to localize it, I would recommend globalizing your string data. It's a good practice to get into, and you never know if you might need to localize down the line if the script becomes popular in the community.
        </p>
        
        <p>
          There are two last points I want to bring up. The first is the reason why the English strings file isn't in an <code>en-US</code> folder. This would have worked just fine, but by leaving a file in the base folder, we are giving <code>Import-LocalizedData</code> a fallback to use if it can't find a matching <code>psd1</code> file for the UI culture specified in <code>$PSUICulture</code>.
        </p>
        
        <p>
          The second thing I want to add is that <code>Import-LocalizedData</code> will not merge a language-specific file with the fallback file. If you define five values in the <code>psd1</code> file in your base directory but only four of those in the <code>es-ES</code> version of the file, your Spanish users will not see the English value for that fifth value, it will simply be null.
        </p>
        
        <p>
          I've posted the full example on a <a href="https://github.com/platta/plattsoft_PSUICultureExample" target="_blank">GitHub repository</a> so you can easily try it yourself. This is also a great opportunity to become more familiar with using Git and GitHub. My repository only has the English and Spanish translations, I would love to receive some pull requests to add more languages!
        </p>
        
        <p>
          <strong>Update:</strong> I originally started writing about <code>Import-LocalizedData</code> so I could share an issue I ran into while working with it. I've written that story in a <a href="http://45.55.182.154/2015/08/27/internationalization-with-import-localizeddata-part-2/">follow-up post</a>.
          
          <div class="fusion-clearfix">
          </div></div> </div></div></div>