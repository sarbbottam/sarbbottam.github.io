---
layout: post
title: tab order and tab navigation simulation
description:
  This is a follow up of tab order and tabindex post, simulating tab order and tab navigation using left and right arrows.
date: 2016-10-16 11:20:00
categories: Accessibility, HTML, CSS, JavaScript
redirect_from: /accessibility,/html,/css,/javascript/2016/10/16/tab-order-and-tab-navigation-simulation/
---

>This is a follow up of [tab order and tabindex](/blog/2016/10/14/tab-order-and-tabindex) post.

In `tab navigation`, one uses

- `tab` for forward navigation
- `shift + tab` for backward navigation

Let's simulate `tab navigation` like so:

- `right arrow` for forward navigation
- `left arrow` for backward navigation

_In order to simulate `tab navigation` we need to first simulate a `tab order`._

## tab order simulation

Let's simulate `tab order` like so:

- traverse the DOM in `preorder`, `depth-first traversal` to find the all the `focusable` elements.
  - use [Document.querySelectorAll()](https://developer.mozilla.org/en-US/docs/Web/API/Document/querySelectorAll),
as it returns a list of the elements within the document (using depth-first pre-order traversal of the document's nodes) that match the specified group of selectors.
  - use `'input:not([type=hidden]), select, textarea, button, a[href], tabindex=0'` as the `selector` for `querySelectorAll`
  - filter the returned `node list` against the presence of `disabled` and `tabindex=1` attribute.
- a variable to keep track of the `current tabable index`.

## tab navigation simulation

Once the `tab order` is simulated, we can simulate simulate `tab navigation` like so:

- whenever right arrow is pressed, increment this index by 1 and focus the corresponding node.
  - if the value of the index is more then the number of focusable element; reset it to 0.
- whenever left arrow is pressed, decrement this index by 1 and focus the corresponding node.
  - if the value of the index is less then 0; reset it to the number of focusable element.

_For the sake of simplicity, `tabindex=X` is not considered._

Whenever a `focusable element` is either **added** or **removed** from the DOM, we need to update the simulated `tab order` and  corresponding `current tabable index`.


Refer [CodePen example - tab navigation simulation](http://codepen.io/sarbbottam/full/NRBBXE/) to experience simulated tab navigation.

<p data-height="530" data-theme-id="0" data-slug-hash="NRBBXE" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/NRBBXE/">tab navigation simulation</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

For convenience, I have also embedded the corresponding JavaScript below.

<p data-height="2350" data-theme-id="0" data-slug-hash="NRBBXE" data-default-tab="js" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/NRBBXE/">tab navigation simulation</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

>Do browsers facilitate `tab navigation` in similar fashion?

_I have no idea_ :)

---

If you have enjoyed reading this post you can follow me in twitter [@sarbbottam](https://twitter.com/sarbbottam) and learn about any new posts.