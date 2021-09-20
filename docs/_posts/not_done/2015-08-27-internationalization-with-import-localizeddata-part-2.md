---
id: 1555
title: 'Internationalization with Import-LocalizedData: Part 2'
date: '2015-08-27'
author: Adam
layout: post
guid: http://45.55.182.154/?p=1555
permalink: /2015/08/27/internationalization-with-import-localizeddata-part-2/
dsq_thread_id:
  - "4073748736"
avada_post_views_count:
  - "1416"
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
    When I first sat down to write this post, <a href="http://45.55.182.154/2015/08/24/internationalization-with-import-localizeddata/" target="_blank">this one</a> came out instead. If you're not familiar with the <code>Import-LocalizedData</code>  Cmdlet, you might want to start there.
    
    I want to talk some more about <code>Import-LocalizedData</code>, but more specifically the way it works with the automatic variable <code>$PSUICulture</code> and some interesting behavior I observed there. The <a href="https://technet.microsoft.com/en-us/library/Hh847854.aspx" target="_blank">about_Script_Internationalization</a> help topic details how both the Cmdlet and automatic variable were added in PowerShell version 2.0 to strengthen support for internationalization. Basically, <code>$PSUICulture</code> will contain the region code for whatever language Windows has been configured to display itself in, and this is the language that <code>Import-LocalizedData</code> will look for by default. This is very powerful because now my scripts have zero code in them that's trying to figure out which translation of the resource file they should use.
    
    As I mentioned in my previous post, I was working on a PowerShell project that involved internationalization, which is how I found myself using <code>Import-LocalizedData</code> in the first place. Another part of the project was configuring virtual machines as they were provisioned, including updating the Regional Settings based on the users' preferences.
    
    <img src="http://45.55.182.154/wp-content/uploads/2015/08/Capture.jpg" alt="Regional Settings - Keyboards and Languages Tab" width="467" height="537" class="alignright size-full wp-image-1576" />
    
    The client had specified which settings on the Regional Settings applet they would like to set based on the culture, and had wanted to leave some of the system level settings set to the default American English. I had to make sure that wouldn't affect my scripts' ability to present properly localized text, so I did some testing to make sure I knew specifically which setting would get <code>$PSUICulture</code> to reflect the user's language. I found that the Display Language setting on the Keyboards and Languages tab is what did it, which was great because it is not one of the system level settings.
    
    It's important to note that you don't normally see the dropdown to select a display language. It only appears once you've installed one or more additional languages. I was able to access the necessary language files through my MSDN subscription.
    
    Fast forward to a couple of weeks later, and we had run into a problem. A Japanese user had provisioned a virtual machine for himself and selected Japanese as his preferred language, but my scripts were still displaying text in English. I grabbed the Japanese language files from MSDN and installed them on my test machine. Sure enough, when I set the display language to Japanese, PowerShell was still in English. If I changed everything in Regional Settings to Japanese, however, it worked properly.
    
    It took me a number of tries to identify the exact conditions required to get the correct value of <code>ja-JP</code> in <code>$PSUICulture</code>. It turned out to be that both the Display Language and the System Locale had to be set to Japanese in order for it to work.
    
    <img src="http://45.55.182.154/wp-content/uploads/2015/08/Capture2.jpg" alt="Regional Settings - Administrative Tab" width="467" height="537" class="alignleft size-full wp-image-1578" />
    
    I thought I was losing my mind, I had tested this so many times and I was always able to get the correct results just by changing the Display Language. I started installing more languages on my test machine and testing the settings with them. Some of them worked just on Display Language, but some also required the System Locale. Finally I realized what was different about the languages that behaved differently - the glyphs. Languages like Japanese, Russian, and Thai don't use the latin alphabet that languages like American and Spanish use. These were the ones that required the System Locale to be set in addition to the Display Language for PowerShell to correctly detect the language.
    
    The System Locale was one of the system level settings that the client did not want to change. Luckily the region code for the language the user had selected got stored locally on the machine. I was able to pass that into the <code>-UICulture</code> parameter of <code>Import-LocalizedData</code> and explicitly tell the Cmdlet which language to use.
    
    PowerShell is a great and powerful tool for IT Administrators and Software Engineers alike. Its strength, flexibility, and extensibility still regularly impress me. Be that as it may, experiences like this one remind that, just like any language, there are always gotchas and quirks to be worked around. Happy scripting!
fusion_builder_converted:
  - 'yes'
image: /wp-content/uploads/2015/08/IMG_2508-125x125.png
categories:
  - Programming
---
When I first sat down to write this post, <a href="http://45.55.182.154/2015/08/24/internationalization-with-import-localizeddata/" target="_blank">this one</a> came out instead. If you're not familiar with the `Import-LocalizedData` Cmdlet, you might want to start there.

I want to talk some more about `Import-LocalizedData`, but more specifically the way it works with the automatic variable `$PSUICulture` and some interesting behavior I observed there. The <a href="https://technet.microsoft.com/en-us/library/Hh847854.aspx" target="_blank">about_Script_Internationalization</a> help topic details how both the Cmdlet and automatic variable were added in PowerShell version 2.0 to strengthen support for internationalization. Basically, `$PSUICulture` will contain the region code for whatever language Windows has been configured to display itself in, and this is the language that `Import-LocalizedData` will look for by default. This is very powerful because now my scripts have zero code in them that's trying to figure out which translation of the resource file they should use.

As I mentioned in my previous post, I was working on a PowerShell project that involved internationalization, which is how I found myself using `Import-LocalizedData` in the first place. Another part of the project was configuring virtual machines as they were provisioned, including updating the Regional Settings based on the users' preferences.

<img src="http://45.55.182.154/wp-content/uploads/2015/08/Capture.jpg" alt="Regional Settings - Keyboards and Languages Tab" width="467" height="537" class="alignright size-full wp-image-1576" srcset="https://plattsoft.net/wp-content/uploads/2015/08/Capture-261x300.jpg 261w, https://plattsoft.net/wp-content/uploads/2015/08/Capture.jpg 467w" sizes="(max-width: 467px) 100vw, 467px" /> 

The client had specified which settings on the Regional Settings applet they would like to set based on the culture, and had wanted to leave some of the system level settings set to the default American English. I had to make sure that wouldn't affect my scripts' ability to present properly localized text, so I did some testing to make sure I knew specifically which setting would get `$PSUICulture` to reflect the user's language. I found that the Display Language setting on the Keyboards and Languages tab is what did it, which was great because it is not one of the system level settings.

It's important to note that you don't normally see the dropdown to select a display language. It only appears once you've installed one or more additional languages. I was able to access the necessary language files through my MSDN subscription.

Fast forward to a couple of weeks later, and we had run into a problem. A Japanese user had provisioned a virtual machine for himself and selected Japanese as his preferred language, but my scripts were still displaying text in English. I grabbed the Japanese language files from MSDN and installed them on my test machine. Sure enough, when I set the display language to Japanese, PowerShell was still in English. If I changed everything in Regional Settings to Japanese, however, it worked properly.

It took me a number of tries to identify the exact conditions required to get the correct value of `ja-JP` in `$PSUICulture`. It turned out to be that both the Display Language and the System Locale had to be set to Japanese in order for it to work.

<img src="http://45.55.182.154/wp-content/uploads/2015/08/Capture2.jpg" alt="Regional Settings - Administrative Tab" width="467" height="537" class="alignleft size-full wp-image-1578" srcset="https://plattsoft.net/wp-content/uploads/2015/08/Capture2-261x300.jpg 261w, https://plattsoft.net/wp-content/uploads/2015/08/Capture2.jpg 467w" sizes="(max-width: 467px) 100vw, 467px" /> 

I thought I was losing my mind, I had tested this so many times and I was always able to get the correct results just by changing the Display Language. I started installing more languages on my test machine and testing the settings with them. Some of them worked just on Display Language, but some also required the System Locale. Finally I realized what was different about the languages that behaved differently - the glyphs. Languages like Japanese, Russian, and Thai don't use the latin alphabet that languages like American and Spanish use. These were the ones that required the System Locale to be set in addition to the Display Language for PowerShell to correctly detect the language.

The System Locale was one of the system level settings that the client did not want to change. Luckily the region code for the language the user had selected got stored locally on the machine. I was able to pass that into the `-UICulture` parameter of `Import-LocalizedData` and explicitly tell the Cmdlet which language to use.

PowerShell is a great and powerful tool for IT Administrators and Software Engineers alike. Its strength, flexibility, and extensibility still regularly impress me. Be that as it may, experiences like this one remind that, just like any language, there are always gotchas and quirks to be worked around. Happy scripting!