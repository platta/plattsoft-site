---
id: 1284
title: Password Strength is Relative to Attack Algorithm
date: '2013-04-18'
author: Adam
excerpt: 'Passwords are everywhere in our technology laden world.  The number of accounts a single person has grows constantly (I sign up for a new web site or service at least once a month).  Because of this, it&#39;s of ever-increasing importance to be smart about how you secure your accounts and choose passwords with a high password strength.'
layout: post
guid: http://45.55.182.154/?p=1284
permalink: /2013/04/18/password-strength-is-relative/
dsq_thread_id:
  - "1235045917"
avada_post_views_count:
  - "1135"
fusion_builder_content_backup:
  - |
    <p>Passwords are everywhere in our technology laden world.  The number of accounts a single person has grows constantly (I sign up for a new web site or service at least once a month).  Because of this, it&#39;s of ever-increasing importance to be smart about how you secure your accounts and choose passwords with a high password strength.</p>
    
    <p> The webcomic <a href="http://xkcd.com/">XKCD</a> had an eye-opening issue a while back, which I believe has been hotly debated in various forums:</p>
    
    [caption id="" width="500" align="aligncenter" caption="Credit: XKCD"]<a href="http://xkcd.com/936/" target="_blank" style=" "><img src="http://45.55.182.154/wp-content/uploads/2013/04/wpid-Photo-Apr-18-2013-943-AM.jpg" id="blogsy-1366896105169.3901" class="aligncenter" alt="XKCD Proposes a Better Approach to Password Strength" width="500" height="406"></a>[/caption]
    
    <p> There are two concepts Munroe is focusing on here: the difficulty for an attacking program to guess a password, and the difficulty for a human being to remember the password.  Already we can see how password strength is relative to your perspective, but it gets better.</p>
    
    <p>The comic expresses password strength in terms of entropy, which is essentially a measure of many attempts it would take an attacking program to correctly guess the password.  In the comic, the gray boxes represent "bits" of entropy, which describe the maximum number of attempts required to find the password in terms of $latex 2^n$, where $latex n$ is the number of entropy bits.</p>
    
    <p>I&#39;m willing to accept Munroe&#39;s argument for the difficulty of remembering the passwords in his examples without dispute. When it comes to the difficulty of guessing the passwords, well - I wouldn&#39;t say I dispute what he says - it&#39;s just harder to digest what he&#39;s putting out there. So let&#39;s take a closer look.</p>
    
    <h2>Password Strength of the "Troubador" Method</h2>
    
    <p>First, let&#39;s look at the entropy bits he attributes to the difficult to remember password:</p>
    
    <ul>
    <li>Sixteen bits for the choice of an uncommon (non-gibberish) word.</li>
    <li>One bit because the first character may or may not be capitalized.</li>
    <li>Three bits because certain letters may or may not be swapped with numbers (a la "leet speak").</li>
    <li>Four bits for the special symbol at the end of the password.</li>
    <li>Three bits for the number at the end of the password.</li>
    <li>One bit because the order of the special symbol and the number at the end of the password might be switched.</li>
    </ul>
    
    <p> Let&#39;s get the easy ones out of the way first.  Assigning one bit to the capitalization of the first letter and one to the order of the last two characters makes perfect sense.  $latex 2^1 = 2$, which means figuring out whether the first character is capitalized or not takes a maximum of two guesses.  Remember, at this point we&#39;re not worried about figuring out <em>what</em> that first letter is; the probabilities for guessing that are satisfied by some of the other entropy bits.</p>
    
    <p>The next easy ones are the bits assigned to the number and special character at the end of the password.  If we&#39;re talking about a single digit, then we&#39;re looking at $latex 10 approx 2^3$ choices. It&#39;s not exact, but we can see that Munroe is erring on the conservative side.</p>
    
    <p>Next, the common substitutions.  Here, we are given three entropy bits, but why?  That gives us about eight choices, or three choices between two things (notice how he&#39;s adding one entropy bit per possible replacement even though one character is still a letter and not a digit).  I&#39;m not sure how you&#39;d represent the average entropy of this practice.  You&#39;d need to calculate the average number of digit-replaceable letters in any given word.  For every letter like this, you have a two-way choice - is it the letter, or was it replaced with a digit?  Three possible letter swaps in a word seems reasonable enough to me.</p>
    
    <p>Finally, the entropy bits assigned to the word itself.  Munroe is saying that a dictionary of uncommon words has about $latex 2^{16} = 65,536$ words in it.  A quick search reveals that there are well over a hundred thousand words in the English language, so it seems reasonable that a word list expansive enough to contain uncommon words would probably be something over fifty thousand.</p>
    
    <p>Upon closer examination, I&#39;m satisfied with the entropy bits assigned to this method of password generation.  How about Munroe&#39;s second method?</p>
    
    <h2>Password Strength of the "Battery Staple" Method</h2>
    
    <p>Here, there is only one rule:</p>
    
    <ul>
    <li>Eleven bits assigned to each common word used in the password.</li>
    </ul>
    
    <p>Already, we can see that there is a difference between common and uncommon words.  The difference is about five bits of entropy, to be more precise.  So a dictionary of common words might contain $latex 2^{11} = 2,048$?  I can believe that.  It is interesting to note, though, what a huge difference those five bits make.  Still, when four of these common words are used together, the entropy adds up pretty quickly.</p>
    
    <h2>What's the Catch?</h2>
    
    <p>So Munroe&#39;s approach appears to hold water, however I still have one big misgiving.  Assigning the entropy bits in this fashion makes the assumption that an attacker approaches the problem armed with the knowledge of the algorithm that was used to generate the password.  What if an attacker used a simple brute force method that just tried every combination of letters, numbers, and special characters?  There are twenty six letters, but really fifty two because lowercase and capital letters are different.  There are ten digits, and let&#39;s stick with Munroe&#39;s four entropy bits (sixteen) possible choices for special characters.</p>
    
    <p> Using this simple brute force method, every character of the password has $latex 78 approx 2^6$ possibilities.  That means the method one password (11 characters long) now has sixty six bits of entropy.  That&#39;s higher than the forty four bits Munroe assigned to the password generated by the second method.  At the same time, what if we used the same simple brute force attack on the second password.  It&#39;s got twenty five characters, and so would have one hundred and fifty bits of entropy.</p>
    
    <p>I doubt anyone actually uses such a basic brute force algorithm anymore (who knows!), but it&#39;s an easy way to illustrate the fact that a given password&#39;s entropy is relative to the method used to attack it.  In my example, Munroe&#39;s second password was still the stronger of the two, but, there could be other algorithms that might render that password relatively weak.</p>
    
    <p>In the end, what can we do to increase the password strength on our accounts?  The two key points brought up by the comic very clearly describe where we want to be: passwords that are easy for humans to remember, but hard for computers to guess.  The question remains - how exactly do we do that when the actual strength of the password against an attack is relative to the attack algorithm?  For me, I&#39;ll stick with the battery staple, at least I can remember it.</p>
    
    <p>&nbsp;</p>
fusion_builder_converted:
  - 'yes'
fusion_builder_status:
  - ""
sbg_selected_sidebar:
  - 'a:1:{i:0;s:1:"0";}'
sbg_selected_sidebar_replacement:
  - 'a:1:{i:0;s:0:"";}'
sbg_selected_sidebar_2:
  - 'a:1:{i:0;s:1:"0";}'
sbg_selected_sidebar_2_replacement:
  - 'a:1:{i:0;s:0:"";}'
pyre_show_first_featured_image:
  - 'no'
pyre_fimg_width:
  - ""
pyre_fimg_height:
  - ""
pyre_portfolio_width_100:
  - default
pyre_video:
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
pyre_slider_position:
  - default
pyre_avada_rev_styles:
  - default
pyre_fallback:
  - ""
pyre_demo_slider:
  - ""
pyre_display_header:
  - 'yes'
pyre_header_100_width:
  - default
pyre_header_bg_color:
  - ""
pyre_header_bg_opacity:
  - ""
pyre_header_bg:
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
pyre_page_bg_color:
  - ""
pyre_page_bg:
  - ""
pyre_page_bg_full:
  - 'no'
pyre_page_bg_repeat:
  - repeat
pyre_wide_page_bg_color:
  - ""
pyre_wide_page_bg:
  - ""
pyre_wide_page_bg_full:
  - 'no'
pyre_wide_page_bg_repeat:
  - repeat
pyre_page_title:
  - default
pyre_page_title_breadcrumbs_search_bar:
  - default
pyre_page_title_text:
  - default
pyre_page_title_text_alignment:
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
pyre_page_title_100_width:
  - default
pyre_page_title_height:
  - ""
pyre_page_title_mobile_height:
  - ""
pyre_page_title_bar_bg_color:
  - ""
pyre_page_title_bar_borders_color:
  - ""
pyre_page_title_bar_bg:
  - ""
pyre_page_title_bar_bg_retina:
  - ""
pyre_page_title_bar_bg_full:
  - default
pyre_page_title_bg_parallax:
  - default
image: /wp-content/uploads/2013/04/Old_Key-150x99.jpg
categories:
  - Technology
---
Passwords are everywhere in our technology laden world. The number of accounts a single person has grows constantly (I sign up for a new web site or service at least once a month). Because of this, it's of ever-increasing importance to be smart about how you secure your accounts and choose passwords with a high password strength.

The webcomic [XKCD](http://xkcd.com/) had an eye-opening issue a while back, which I believe has been hotly debated in various forums:

<div class="fusion-fullwidth fullwidth-box hundred-percent-fullwidth non-hundred-percent-height-scrolling"  style='background-color: rgba(255,255,255,0);background-position: center center;background-repeat: no-repeat;padding-top:0px;padding-right:0px;padding-bottom:0px;padding-left:0px;'>
  <div class="fusion-builder-row fusion-row ">
    <div  class="fusion-layout-column fusion_builder_column fusion_builder_column_1_1 fusion-builder-column-40 fusion-one-full fusion-column-first fusion-column-last fusion-column-no-min-height 1_1"  style='margin-top:0px;margin-bottom:0px;'>
      <div class="fusion-column-wrapper" style="background-position:left top;background-repeat:no-repeat;-webkit-background-size:cover;-moz-background-size:cover;-o-background-size:cover;background-size:cover;"   data-bg-url="">
        <div style="width: 510px" class="wp-caption aligncenter">
          <a href="http://xkcd.com/936/" target="_blank"><img id="blogsy-1366896105169.3901" class="aligncenter" src="http://45.55.182.154/wp-content/uploads/2013/04/wpid-Photo-Apr-18-2013-943-AM.jpg" alt="XKCD Proposes a Better Approach to Password Strength" width="500" height="406" /></a>
          
          <p class="wp-caption-text">
            Credit: XKCD
          </p>
        </div>
        
        <p>
          There are two concepts Munroe is focusing on here: the difficulty for an attacking program to guess a password, and the difficulty for a human being to remember the password. Already we can see how password strength is relative to your perspective, but it gets better.
        </p>
        
        <p>
          The comic expresses password strength in terms of entropy, which is essentially a measure of many attempts it would take an attacking program to correctly guess the password. In the comic, the gray boxes represent "bits" of entropy, which describe the maximum number of attempts required to find the password in terms of $latex 2^n$, where $latex n$ is the number of entropy bits.
        </p>
        
        <p>
          I'm willing to accept Munroe's argument for the difficulty of remembering the passwords in his examples without dispute. When it comes to the difficulty of guessing the passwords, well - I wouldn't say I dispute what he says - it's just harder to digest what he's putting out there. So let's take a closer look.
        </p>
        
        <h2>
          Password Strength of the "Troubador" Method
        </h2>
        
        <p>
          First, let's look at the entropy bits he attributes to the difficult to remember password:
        </p>
        
        <ul>
          <li>
            Sixteen bits for the choice of an uncommon (non-gibberish) word.
          </li>
          <li>
            One bit because the first character may or may not be capitalized.
          </li>
          <li>
            Three bits because certain letters may or may not be swapped with numbers (a la "leet speak").
          </li>
          <li>
            Four bits for the special symbol at the end of the password.
          </li>
          <li>
            Three bits for the number at the end of the password.
          </li>
          <li>
            One bit because the order of the special symbol and the number at the end of the password might be switched.
          </li>
        </ul>
        
        <p>
          Let's get the easy ones out of the way first. Assigning one bit to the capitalization of the first letter and one to the order of the last two characters makes perfect sense. $latex 2^1 = 2$, which means figuring out whether the first character is capitalized or not takes a maximum of two guesses. Remember, at this point we're not worried about figuring out <em>what</em> that first letter is; the probabilities for guessing that are satisfied by some of the other entropy bits.
        </p>
        
        <p>
          The next easy ones are the bits assigned to the number and special character at the end of the password. If we're talking about a single digit, then we're looking at $latex 10 \approx 2^3$ choices. It's not exact, but we can see that Munroe is erring on the conservative side.
        </p>
        
        <p>
          Next, the common substitutions. Here, we are given three entropy bits, but why? That gives us about eight choices, or three choices between two things (notice how he's adding one entropy bit per possible replacement even though one character is still a letter and not a digit). I'm not sure how you'd represent the average entropy of this practice. You'd need to calculate the average number of digit-replaceable letters in any given word. For every letter like this, you have a two-way choice - is it the letter, or was it replaced with a digit? Three possible letter swaps in a word seems reasonable enough to me.
        </p>
        
        <p>
          Finally, the entropy bits assigned to the word itself. Munroe is saying that a dictionary of uncommon words has about $latex 2^{16} = 65,536$ words in it. A quick search reveals that there are well over a hundred thousand words in the English language, so it seems reasonable that a word list expansive enough to contain uncommon words would probably be something over fifty thousand.
        </p>
        
        <p>
          Upon closer examination, I'm satisfied with the entropy bits assigned to this method of password generation. How about Munroe's second method?
        </p>
        
        <h2>
          Password Strength of the "Battery Staple" Method
        </h2>
        
        <p>
          Here, there is only one rule:
        </p>
        
        <ul>
          <li>
            Eleven bits assigned to each common word used in the password.
          </li>
        </ul>
        
        <p>
          Already, we can see that there is a difference between common and uncommon words. The difference is about five bits of entropy, to be more precise. So a dictionary of common words might contain $latex 2^{11} = 2,048$? I can believe that. It is interesting to note, though, what a huge difference those five bits make. Still, when four of these common words are used together, the entropy adds up pretty quickly.
        </p>
        
        <h2>
          What's the Catch?
        </h2>
        
        <p>
          So Munroe's approach appears to hold water, however I still have one big misgiving. Assigning the entropy bits in this fashion makes the assumption that an attacker approaches the problem armed with the knowledge of the algorithm that was used to generate the password. What if an attacker used a simple brute force method that just tried every combination of letters, numbers, and special characters? There are twenty six letters, but really fifty two because lowercase and capital letters are different. There are ten digits, and let's stick with Munroe's four entropy bits (sixteen) possible choices for special characters.
        </p>
        
        <p>
          Using this simple brute force method, every character of the password has $latex 78 \approx 2^6$ possibilities. That means the method one password (11 characters long) now has sixty six bits of entropy. That's higher than the forty four bits Munroe assigned to the password generated by the second method. At the same time, what if we used the same simple brute force attack on the second password. It's got twenty five characters, and so would have one hundred and fifty bits of entropy.
        </p>
        
        <p>
          I doubt anyone actually uses such a basic brute force algorithm anymore (who knows!), but it's an easy way to illustrate the fact that a given password's entropy is relative to the method used to attack it. In my example, Munroe's second password was still the stronger of the two, but, there could be other algorithms that might render that password relatively weak.
        </p>
        
        <p>
          In the end, what can we do to increase the password strength on our accounts? The two key points brought up by the comic very clearly describe where we want to be: passwords that are easy for humans to remember, but hard for computers to guess. The question remains - how exactly do we do that when the actual strength of the password against an attack is relative to the attack algorithm? For me, I'll stick with the battery staple, at least I can remember it.
        </p>
        
        <p>
          &nbsp;
        </p>
        
        <div class="fusion-clearfix">
        </div>
      </div>
    </div>
  </div>
</div>