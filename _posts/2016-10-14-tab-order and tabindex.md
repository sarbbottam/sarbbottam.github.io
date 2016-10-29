---
title: tab order and tabindex
date: 2016-10-14 13:10:00
categories: Accessibility, HTML, CSS, JavaScript
excerpt_separator: <!--more-->
redirect_from: /accessibility,/html,/css,/javascript/2016/10/14/tab-order-and-tabindex/
---

A keyboard only user, primarily uses `tab` key to reach the actionable controls in a web page.
The order in which `focusable` elements are focused via `tab` press, is called `tab order`.
When a user presses `tab`, browser focuses the next `tabable` element in the `tab order`.

<!--more-->

All `tabable` elements are `focusable` but not all `focusable` elements are `tabable`.

*tabable* - an element that can be reached via `tab` press.

*focusable* - an element that can be focused by any means, by `tab` press, `up/down/left/right` press, mouse click or via JavaScript using `HTMLElement.focus()`.

Refer [CodePen example - tab order - 101](http://codepen.io/sarbbottam/full/vXpaPO/) to experience `tab order`.

<p data-height="380" data-theme-id="0" data-slug-hash="vXpaPO" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/vXpaPO/">tab order  - 101</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

In the [CodePen example - tab order - 101](http://codepen.io/sarbbottam/full/vXpaPO/) the `tab order` is `1, 2, 3, 4, 5`.

`tab order` matches the order in which the `focusable` elements appear, if the DOM is traversed in [preorder, depth-first traversal](https://www.w3.org/TR/dom/#concept-tree-order).
<br/>
In other words, `tab order` matches the order, in which `focusable` elements appear in the HTML from start to finish.

_Ideally `tab order` must match the `natural visual order`. Otherwise it might lead to a confusing user experience._

Refer [CodePen example - tab order - confusing](http://codepen.io/sarbbottam/full/amEjaP/) where `natural visual order` does not match the `tab order`

<p data-height="440" data-theme-id="0" data-slug-hash="amEjaP" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/amEjaP/">tab order  - confusing</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

Visually the `tab order` seems 1, 2, 3, 4, 5. In reality, it is 5, 4, 3, 2, 1, to the match the DOM. Refer the HTML section of the [CodePen example - tab order - confusing](http://codepen.io/sarbbottam/amEjaP/).

**Don't do this.**

If you were unfamiliar with the concept of `tab order`, I hope you got the hang of it, by now.
If not try accessing the above two examples using `tab` and poke around the corresponding code.

## What are the `focusable` elements?

Any intractable HTML element, which does not have a `disabled` attribute is `focusable`.

* `input:not([type=hidden])`
* `select`
* `textarea`
* `button`
* `a[href]`

⚠︎︎ However, if an intractable element or its ancestor has `display:none` or `visibility:hidden`, it is not `focusable`.

💡 If a non-intractable elements can be made intractable, it will be focusable too.
For example, `div`, a non-intractable element, can be made intractable by adding `contenteditable="true"` to it, thus making it `focusable`.

👊 Using `tabindex` attribute, one can make a non-intractable elements `focusable`.

## tabindex

As the name suggests, `tabindex` re-indexes the `tab order` or in other words modifies the `tab order`.
Using `tabindex` one can

* take elements out of the `tab order`
* insert elements in the natural `tab order`
* modify the order of elements in the `tab order`.

`tabindex` attribute can have any of the following three values

* `-1`
* `0`
* `{1, 2, 3, 4, 5, ... }`; [any whole number](https://www.mathsisfun.com/whole-numbers.html)

### tabindex=-1

`tabindex=-1` takes the corresponding `focusable` element out of the `tab order`.

An element with `tabindex=-1` attribute can never be reached via `tab` press, but it can be focused via JavaScript using `HTMLElement.focus()`.

_So not all `focusable` elements are `tabable`._

Refer [CodePen example - tabindex=-1](http://codepen.io/sarbbottam/full/WGrRVO/)

<p data-height="650" data-theme-id="0" data-slug-hash="WGrRVO" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/WGrRVO/">tabindex=-1</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

`tabindex=-1` could be very useful to enhance the user experience for Rich Internet Applications.

Whenever there is a UI, where there are bunch of intractable elements, serving similar purpose,
it is better to take them out of the `tab order`, and focus them programmatically. Similar to the behavior of radio group.

There are many use cases, where `tabindex=-1` could be useful.

**In short when ever you want any element to be focused only via JavaScript and not via `tab` press, use `tabindex=-1` attribute.**

### tabindex=0

`tabindex=0` makes an non-intractable element `focusable` and inserts it in the natural `tab order`, that is the order in which it appears in the DOM.

Refer [CodePen example - tabindex=0](http://codepen.io/sarbbottam/full/YGZkmV/)

<p data-height="450" data-theme-id="0" data-slug-hash="YGZkmV" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/YGZkmV/">tabindex=0</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

_I had been considering `tabindex=0` a great utility, until recently._

Let's consider that there is _clickable_ `div`. And we want this `div` to be operable via keyboard.

* First we have to add`tabindex=0` to make it `focusable`, so that it can be reached via `tab` press.
* Then we have to listen to `enter/space` press on the `div` and execute the `click` handler.

However, if a `button` was used, not only it would have been `focusable` by default,
but browser would have triggered a `click` event on `enter/space` press.

Why to write so much extra code? [Less is more](https://www.google.com/#q=less+is+more)

Please refer the [CodePen example - why tabindex=0](http://codepen.io/sarbbottam/full/vXdxPm/)

<p data-height="500" data-theme-id="0" data-slug-hash="vXdxPm" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/vXdxPm/">Why tabindex=0?</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

### tabindex=X

Where `X` is `{1, 2, 3, 4, 5, ... }` etc.; i.e. a [whole number](https://www.mathsisfun.com/whole-numbers.html).

It modifies the natural `tab order`.

**Don't use it**

Seriously, don't use it, as it modifies (rather screws up) the natural `tab order` it will challenge the user expectation.

Please refer the [CodePen example - why tabindex=X](http://codepen.io/sarbbottam/full/ozrrjx/)

<p data-height="350" data-theme-id="0" data-slug-hash="ozrrjx" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/ozrrjx/">tabindex=X</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

Visually the `tab order` seems 1, 2, 3, 4, 5. In reality, it is 5, 1, 4, 2, 3, due to the `tabindex=X`. Refer the HTML section of the [CodePen example - why tabindex=X](http://codepen.io/sarbbottam/pen/ozrrjx/).

## Conclusion

Don't alter the natural visual `tab order`

You might also want to take a look at [tab order and tab navigation simulation](/blog/2016/10/16/tab-order-and-tab-navigation-simulation) post.
