---
title: Expression Translator
date: '2009-08-20'
author: Adam

layout: post

permalink: /2009/08/20/expression-translator/

categories:
  - General Blog
---
In this context, we're talking about simple mathematical expressions like
`5 + 5`.  There are three ways to write these types of expressions:

1. Prefix or Preorder - In this form, the operator is placed before the
    operands (`+ 5 5`)
2. Infix or Inorder - The "standard" way we are used to seeing things.  The
    operator is sandwiched in between the operands (`5 + 5`)
3. Postfix or Postorder - The operator is placed after the operands (`5 5 +`)

The Expression Translator application allows you to enter an expression in any
of the three formats, and will convert the expression to any of the three
formats.  It will also evaluate the expression and display the answer.

The interesting thing about this is that Infix can potentially require
parentheses.  Actually, it is the only form that ever uses them.

Take the expression `(5 + 5) * 3`, for example.  Because of the parentheses, you
would evaluate `5 + 5` first, and then multiply the result by `3` to get `30`.
Without the parentheses, multiplication has higher precedence than addition, so
you would evaluate `5 * 3` first, then add `5` to the result to get `20`.

`(5 + 5) * 3` and `5 + 5 * 3` are extremely similar when represented in Infix.
The only difference is the parentheses.  When written in Prefix or Postfix,
however, you must actually change the order of the characters in the expression
to change its meaning.  For example:

* Infix: `(5 + 5) * 3`
* Prefix: `* + 5 5 3`
* Postfix:`5 5 + 3 *`

* Infix: `5 + 5 * 3`
* Prefix: `+ 5 * 5 3`
* Postfix: `5 5 3 * +`

<!-- TODO: Figure out the right way to implement these download links. -->
The binary is available here: [Expression Translator
Binary](http://45.55.182.154/wp-content/uploads/2009/08/ExpressionTranslator.zip)

The original source code is also available here: [Expression Translator
Source](http://45.55.182.154/wp-content/uploads/2009/09/ExpressionTranslator_src.zip)
