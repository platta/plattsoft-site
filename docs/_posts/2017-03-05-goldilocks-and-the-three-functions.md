---
title: Goldilocks and the Three Functions
date: '2017-03-05'
author: Adam

layout: post

permalink: /2017/03/05/goldilocks-and-the-three-functions/

categories:
  - Programming
---

How much code is enough code? Does the phrase "less is more" apply here? Some
people take pride in condensing their code into "one-liners," but the reality is
that makes for obtuse, unmaintainable code where defects love to hide. Sure,
there are some cases where gaining performance or some other type of efficiency
justifies writing code that's a little hard to follow, but as a general rule I
avoid this kind of code whenever possible.

In the real world the true measure of the quality of someone's code goes beyond
how well it performs. High quality code must strike a balance between
performance, maintainability, fault tolerance, and other factors dictated by the
situation. The question remains, how much code is enough code? The answer,
however unsatisfying, is: it depends.

Let's look at some examples. We'll be using JavaScript, for no particular
reason.

## Example 1

``` javascript
function f(n){return n<3?1:f(n-1)+f(n-2);}
```

Ouch, writing that hurt my soul a little bit.

This is as condensed as I could make this function, bringing everything onto a
single line. The only time I would ever, _ever_, write code like this is if I
was troubleshooting an emergency issue and needed to accomplish something
immediately. Even then, if the code didn't get thrown away at the end of the day
I would go back and clean it up before saving it.

This code (which is the classic recursive Fibonacci algorithm, by the way)
should never make it to a source control repository in its current state.

<div class="row">
  <div class="col-lg-6" markdown="1">

### Example 1 - Pros

- The code...uh...returns the correct value?
- Can you tell this example is my least favorite?

[//]: #

  </div>
  <div class="col-lg-6" markdown="1">

### Example 1 - Cons

- There are no comments.
- The function and parameter names are not descriptive.
- It is hard to read because it is all on one line and there are very few
  spaces.
- The condition `n<3` contains a hard-coded number whose meaning isn't readily
  apparent.

[//]: #

  </div>
</div>

<div class="card border-info mb-3">
  <div class="card-header bg-info text-white">
    <i class="fas fa-question-circle"></i>
    Unfamiliar with Fibonacci numbers?
  </div>
  <div class="card-body">
    <p>If you don't know what Fibonacci numbers are, take a moment to read about
    them.</p>
    <button type="button" class="btn btn-primary" data-toggle="modal" data-target=".fibonacci-explanation">
      Fill Me In
    </button>
  </div>
</div>

<div class="modal fade fibonacci-explanation" tabindex="-1" role="dialog">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h3 class="modal-title" data-dismiss="modal">
          Fibonacci numbers
        </h3>
        <button class="close" type="button" data-dismiss="modal"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
        <p>
          Fibonacci numbers are a sequence of integers with the characteristic
          that each number is the sum of the previous two numbers. Since there
          are no "previous two numbers" for the first two numbers of the
          sequence, they are both 1. The beginning of the sequence looks like
          this:
        </p>
        <p>
          1, 1, 2, 3, 5, 8, 13, 21 ... and so on.
        </p>
        <p>
          Because of the nature of how each element is calculated, this sequence
          is commonly used to teach recursive algorithms in programming.
          Calculating the _nth_ Fibonacci number quickly becomes a tree of
          recursive function calls to calculate the previous numbers in the
          sequence.
        </p>
        <p>
          One interesting thing is that numbers from the Fibonacci sequence
          occur many places in nature. From patterns on flowers and plants to
          the size and shape of seashells, the Fibonacci sequence appears to be
          linked to many patterns in nature.
        </p>
        <p>
          To read even more about Fibonacci numbers, check out the
          <a href="https://en.wikipedia.org/wiki/Fibonacci_number" target="_blank">
            Wikipedia article
          </a>.
        </p>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

## Example 2

_Please don't feel like you have to read all of this code. I promise, it is a
working Fibonacci function._

``` javascript
/**
 * Calculates and returns a number, specified by a one-based index, from the
 * Fibonacci number series.
 *
 * @summary Gets a number from the Fibonacci number series.
 *
 * @author Adam Platt
 * @copyright Adam Platt 2017
 * @license MIT
 * @version 1.0.0
 *
 * @param {number} index - A one-based index specifying which element of the
 * series should be returned.
 *
 * @returns {number} the nth number of the Fibonacci series, where n is
 * the index value.
 *
 * @see {@link https://en.wikipedia.org/wiki/Fibonacci_number}
 *
 * @example
 * // returns 1
 * getFibonacciNumberByIndex_Recursive(2);
 *
 * @example
 * // returns 8
 * getFibonacciNumberByIndex_Recursive(6);
 */
function getFibonacciNumberByIndex_Recursive(index) {
    /**
     * The minimum supported index of this function. If a value below this is
     * given for the index parameter an exception will be thrown.
     *
     * @type {number}
     * @const
     */
    const MINIMUM_INDEX = 1;

    /**
     * The number of previous values to add together to get the current value.
     * This also determines the number of initial terms in the sequence with the
     * default value.
     *
     * @type {number}
     * @const
     */
    const INITIAL_TERMS = 2;

    /**
     * The default value returned when the specified index is low enough that we
     * will not make a recursive call.
     *
     * @type {number}
     * @const
     */
    const DEFAULT_VALUE = 1;

    /**
     * The error message to throw when an invalid index value is provided.
     *
     * @type {string}
     * @const
     */
    const INVALID_INDEX_MESSAGE  = 'Specified index outside the valid range.';

    /**
     * Holds the value to be returned at the end of the function.
     *
     * @type {number}
     */
    var returnValue;

    // Ensure the index provided is within the valid range.
    if (index < MINIMUM_INDEX) {
        throw INVALID_INDEX_MESSAGE;
    }

    // Check whether or not we need to make a recursive call.
    if (index <= INITIAL_TERMS) {
        // The index is low enough that we should just return the default value.
        returnValue = DEFAULT_VALUE;
    } else {
        // Because the index is high enough, we must make recursive calls to
        // determine the result.

        // Initialize the return value.
        returnValue = 0;

        // Iterate from one to (and including) the value of INITIAL_TERMS and
        // add the values of each previous number together.
        for (var iterator = 1; iterator <= INITIAL_TERMS; iterator++) {
            // Add the nth previous value to the result.
            returnValue += getFibonacciNumberByIndex_Recursive(index - iterator);
        }
    }

    // Return the calculated result.
    return returnValue;
}
```

I was really hoping I'd be able to push it to 100 lines or more, but I only made
it to 98. For this example, I was as pedantic as possible. I invoked all the
best practices I could think of such as parameter validation, avoiding
in-line hard-coded numbers and strings, and giving the function a single exit
point.

This level of detail, believe it or not, is not always overkill. In embedded
systems where it is very expensive to patch your code once it's been deployed,
or safety critical systems where a defect could cause a loss of life, you have
to write code like this. In fact, many organizations enforce coding standards to
ensure all developers meet certain criteria regarding function and variable
naming, exception handling, and commenting practices.

<div class="row">
  <div class="col-lg-6" markdown="1">

### Example 2 - Pros

- Function, parameter, and variable names are descriptive.
- Plenty of comments to help understand what the code is doing.
- Proper spacing and indentation makes it easier to follow the code.
- Uses JSDoc self-documenting comments.
- Use of constants makes conditional expressions easier to understand.
- Input validation prevents undefined function values (i.e. an `index` value
  less than `1`)

[//]: #

  </div>
  <div class="col-lg-6" markdown="1">

### Example 2 - Cons

- Comments are so verbose it actually makes the code harder to follow.
- Exception handling code complicates the function's logic.
- Forcing a single exit point requires the use of an additional variable.
- Extra conditional logic and variable usage could impact performance for larger
  values of `index`.
- Seriously, almost 100 lines for a simple Fibonacci function? Imagine if this
  was a function of any significant complexity.

[//]: #

  </div>
</div>

## Example 3

``` javascript
/**
 * Gets the Fibonacci number at the specified index in the series.
 *
 * @param {number} index - The one-based index of the element to return.
 */
function fibonacci(index) {
    if (index &lt;= 2) {
        // The first two elements of the Fibonacci series are 1.
        return 1;
    } else {
        // Every other element of the Fibonacci series is the sum of the
        // previous two elements.
        return fibonacci(index - 1) + fibonacci(index - 2);
    }
}
```

This is a nice middle-of-the-road function. It's longer than one line, but still
pretty short. I didn't blindly follow all the best practices because I wrote the
code while considering the context. This is not a safety critical application,
it's a programming example. We don't need to do parameter validation. I kept
some of the JSDoc comment header for the function because that's useful for
anyone using an editor that will parse it for IntelliSense. I left numbers
hard-coded in-line but the surrounding comments explain their meaning. The key
to this one is to make it "good enough" without sacrificing either performance
or readability.

<div class="row">
  <div class="col" markdown="1">

### Example 3 - Pros

- Relies on descriptive variable names to convey meaning without needing comments.
- Provides comments where helpful to explain the logic of the function.
- Clear and easy to read.

[//]: #

  </div>
  <div class="col-lg-6" markdown="1">

### Example 3 - Cons

- Allows you to pass invalid values for the <code>index</code> parameter.
- Some best practices not followed.

[//]: #

  </div>
</div>

## Which Approach is Just Right?

As I said above, there is no simple answer to this question, it will always
depend on the specifics of the function you are writing and the context in which
you are writing it. I would say, however, that the majority of cases warrant the
third approach, striking a balance between concise and verbose code.

As you can see, different approaches to even a simple function can produce a
vast difference in the number of lines of code produced.

Code that is properly balanced for its context is performant, easy to understand
and maintain, and less likely to contain defects. Whether it makes your
functions shorter or longer, it should be the only kind of code you write.

If you enjoyed this thought exercise, I would highly recommend the book [Clean
Code: A Handboook of Agile Software
Craftmanship](https://www.amazon.com/Clean-Code-Handbook-Software-Craftsmanship/dp/0132350882/ref=sr_1_1?ie=UTF8&qid=1488570044&sr=8-1&keywords=clean+code+a+handbook+of+agile+software+craftsmanship)
by Robert C. Martin.
