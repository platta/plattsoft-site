---
title: 'Ruby Woes - Can''t Modify Self'
date: '2013-04-11'
author: Adam

layout: post

permalink: /2013/04/11/ruby-woes-cant-modify-self/

categories:
  - Programming
---
I've always liked to think that anyone can change if they want to badly enough.
 After about half an hour of searching, I discovered that Ruby objects, within
the context of class methods, cannot.  I was looking to extend the Numeric class
(this is something really cool you can do in Ruby) to add a method that would
"clamp" the number to be within a certain range, between a minimum and a maximum
value.  For example:

``` ruby
5.clamp(-2, 2) # => 2
-20.clamp(-2, 2) # => -2
1.clamp(-2, 2) # => 1`
```

This function is easy enough to write.

``` ruby
class Numeric
  def clamp(minimum, maximum)
    return minimum if self < minimum
    return maximum if self > maximum
    return self`
  end
end
```

But I also wanted to create a bang version of the function, that is a `clamp!()`
function that would modify the receiver and actually change its value, like
this:

``` ruby
x = 5 # => 5
x.clamp!(-2, 2) # => nil`
x # => 2`
```

What I learned is that this isn't possible. You can't even create a method that
modifies the self variable without getting an exception from Ruby. Just wanted
to share that bit of knowledge, because it seems like there's not much
documentation out there about it.
