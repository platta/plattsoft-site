---
title: Strong Typing Considerations
date: '2013-07-31'
author: Adam

layout: post

permalink: /2013/07/31/why-strong-typing-is-important/

categories:
  - Programming
---
You could also call this one "Why I Hate JavaScript," but there are many popular
languages today that do not employ strong typing. JavaScript was just the
language I happened to be working in when the following code had me pulling my
hair out for nearly twenty minutes:

```javascript
var value = $("#myTextbox").val();
var calculation = value + (value * 0.05);
alert(calculation);
```

When I typed `1` into `#myTextbox`, I got an alert that said `10.05`. I lost
count of how many times I double checked my math.

Now, programmers who have been routinely working in JavaScript for some time
might already have spotted the issue, but I've only recently spent a significant
amount of time with the language. I've also completely given the answer away in
the post title. The problem with my code was that jQuery's `val()` method
returns a string. My `calculation` variable was being assigned like this:

```javascript
var value = $("#myTextbox").val();
var calculation = value + (value * 0.05);
alert(calculation);
```

<div class="fusion-fullwidth fullwidth-box hundred-percent-fullwidth non-hundred-percent-height-scrolling"  style='background-color: rgba(255,255,255,0);background-position: center center;background-repeat: no-repeat;padding-top:0px;padding-right:0px;padding-bottom:0px;padding-left:0px;'>
  <div class="fusion-builder-row fusion-row ">
    <div  class="fusion-layout-column fusion_builder_column fusion_builder_column_1_1 fusion-builder-column-46 fusion-one-full fusion-column-first fusion-column-last fusion-column-no-min-height 1_1"  style='margin-top:0px;margin-bottom:0px;'>
      <div class="fusion-column-wrapper" style="background-position:left top;background-repeat:no-repeat;-webkit-background-size:cover;-moz-background-size:cover;-o-background-size:cover;background-size:cover;"   data-bg-url="">
        <pre class="brush: jscript; title: ; notranslate" title="">
var value = $("#myTextbox").val();
var calculation = value + (value * 0.05);
alert(calculation);
</pre>

        <p>
          When I typed <code>1</code> into <code>#myTextbox</code>, I got an alert that said <code>10.05</code>. I lost count of how many times I double checked my math.
        </p>

        <p>
          Now, programmers who have been routinely working in JavaScript for some time might already have spotted the issue, but I've only recently spent a significant amount of time with the language. I've also completely given the answer away in the post title. The problem with my code was that jQuery's <code>val()</code> method returns a string. My <code>calculation</code> variable was being assigned like this:
        </p>

        <ul>
          <li>
            Evaluate <code>(value * 0.05)</code>,where <code>value</code> is implicitly cast as a number.
          </li>
          <li>
            Add <code>value</code> to the result of the above evaluation, where that result is cast as a string.
          </li>
        </ul>

        <p>
          From what I've been able to gather after a little digging, the <code>+</code> operator will cast one operand as a string if the other operand is a string, regardless of their order. Similarly, the <code>*</code> operator will cast both operands as numbers all the time (I even tried this with boolean values).
        </p>

        <h2>
          The Benefits of Strong Typing
        </h2>

        <p>
          <a href="http://45.55.182.154/wp-content/uploads/2013/07/bicep.gif"><img src="http://45.55.182.154/wp-content/uploads/2013/07/bicep.gif" alt="bicep" width="216" height="221" class="alignright size-full wp-image-1421" /></a>
        </p>

        <p>
          Languages like JavaScript, Python, and Ruby let you do whatever you want with your variables, and that limits the ability for IDEs and compilers to perform static checking. My example is three lines of code and produces a fairly obvious logical bug, but it took me close to half an hour to identify the problem. When you have a system consisting of thousands or hundreds of thousands of lines of code, the risk of defects increases exponentially; most defects (logical bugs especially) are not nearly as obvious as my example. In a language with strongly typed variables, type conflicts can be caught at compile time instead of during testing or, worse, in production.
        </p>

        <h2>
          Draw Your Own Conclusions
        </h2>

        <p>
          The lack of strong typing in languages like JavaScript is neither good nor bad, I really want to stress that. Yes, my preference is to use languages with strong typing, but there is nothing inherently wrong with loosely typed languages.
        </p>

        <p>
          The important thing to keep in mind is that you should always choose the tools that are appropriate for your task. If you're building an application for the enterprise or a safety critical system, you will definitely want a language with strong typing so that you can take advantage of the additional static checking it gives you. If you're building a web site for your kid's baseball team, maybe that's not so important. At the end of the day, we all have our preferences, but a strong software engineer must make smart choices based on the needs of the project.
        </p>

        <div class="fusion-clearfix">
        </div>
      </div>
    </div>
  </div>
</div>