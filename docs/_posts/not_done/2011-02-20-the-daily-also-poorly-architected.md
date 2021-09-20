---
title: 'The Daily - Also Poorly Architected'
date: '2011-02-20'
author: Adam

layout: post

permalink: /2011/02/20/the-daily-also-poorly-architected/

categories:
  - Soft Skills
---
A few weeks ago I [took a peek]({{ site.baseurl }}{% post_url
2011-02-05-the-daily-ill-pass%}) at The Daily (a "digital newspaper" app from
News Corp.) and quickly decided that my time and money were better spent
elsewhere when it comes to getting the news.  Bear in mind that I am more strict
in my evaluation of The Daily because it requires a paid subscription.  In my
mind, that raises my expectations significantly.  The initial version of the App
performed poorly in a number of areas, including:

* There was a wait time of over 30 seconds before I could even read headlines.
* The "coverflow" style headline browsing was very choppy.
* I could only see three headlines at a time.
* Although a subscription is required to access the content, it is _still full
  of ads_.

It wasn't long before the first update for the app was available on the iTunes
store, and the second, but I never actually installed either of them.  Here's
why:
<!-- TODO -->
<div class="fusion-fullwidth fullwidth-box hundred-percent-fullwidth non-hundred-percent-height-scrolling"  style='background-color: rgba(255,255,255,0);background-position: center center;background-repeat: no-repeat;padding-top:0px;padding-right:0px;padding-bottom:0px;padding-left:0px;'>
  <div class="fusion-builder-row fusion-row ">
    <div  class="fusion-layout-column fusion_builder_column fusion_builder_column_1_1 fusion-builder-column-32 fusion-one-full fusion-column-first fusion-column-last fusion-column-no-min-height 1_1"  style='margin-top:0px;margin-bottom:0px;'>
      <div class="fusion-column-wrapper" style="background-position:left top;background-repeat:no-repeat;-webkit-background-size:cover;-moz-background-size:cover;-o-background-size:cover;background-size:cover;"   data-bg-url="">
        <div id="attachment_699" style="width: 463px" class="wp-caption aligncenter">
          <a href="http://45.55.182.154/wp-content/uploads/2011/02/thedaily.tiff"><img aria-describedby="caption-attachment-699" class="size-full wp-image-699  " title="The Daily Update Description" src="http://45.55.182.154/wp-content/uploads/2011/02/thedaily.tiff" alt="&quot;Description&quot; of the contents of the latest update to The Daily App." width="453" height="66" /></a>

          <p id="caption-attachment-699" class="wp-caption-text">
            Why are you yelling?
          </p>
        </div>


This is bad architecture if I've ever seen it.  The way that iOS deals with data
and files during installs, updates, backups, and restores,
[is](http://developer.apple.com/library/ios/#documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/RuntimeEnvironment/RuntimeEnvironment.html%23//apple_ref/doc/uid/TP40007072-CH2-SW44)
[well](http://developer.apple.com/library/ios/#documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/RuntimeEnvironment/RuntimeEnvironment.html%23//apple_ref/doc/uid/TP40007072-CH2-SW12)
[documented](http://developer.apple.com/library/ios/#documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/RuntimeEnvironment/RuntimeEnvironment.html%23//apple_ref/doc/uid/TP40007072-CH2-SW7).
 iOS was designed the way it is so that the developer can engineer his or her
App to take care of any necessary file swapping or clean up during App
installation or update.  The user should never be required to delete and
reinstall an App instead of using the built-in process Apple provides for
updating to the latest version.

This is the kind of mistake that wouldn't phase me coming from a free App or one
developed by a "one-man" shop. The Daily was produced by a multi-million dollar
corporation. It is supposed to represent the future of the newspaper, a
revolution in news media consumption. And, again, we are supposed to pay for
access to it.

I'm still not impressed, News Corp.
