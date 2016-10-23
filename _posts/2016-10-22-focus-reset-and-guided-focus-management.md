---
layout: post
title: Focus Reset and Guided Focus Management
date: 2016-10-22 21:00:00
categories: Accessibility, HTML, CSS, JavaScript
excerpt_separator: <!--more-->
---

Focus reset happens when an active (currently focused) element, gets removed form the DOM or the render tree.
On focus reset, `document.activeElement` refers to relative top most `node`; i.e. `body` or `iframe`,
leading to an unpleasant user experience for keyboard only users and screen reader users.

To mitigate the `focus reset` problem, one must implement `guided focus management`.
As the name suggests, in `guided focus management`, one programmatically focuses the desired HTML element/node.

For example, when a modal is displayed, the modal container is focused,
similarly, when a modal is dismissed, the element that had triggered the modal display, is focused.

_When an HTML element/node is focused, screen reader [generally](#caveats) reads out the content of the HTML element,
which serves as a feed back to the non sighted users._

<!--more-->

## Focus reset

Chrome, Firefox, Safari handles focus reset gracefully.
But in IE 11, on the focus reset, any subsequent tab press will focus the `url bar`,
forcing a keyboard only user to tab through, from the beginning, once again.

Refer [CodePen example - Focus Reset](http://codepen.io/sarbbottam/full/ZpXKjA/).

<p data-height="370" data-theme-id="0" data-slug-hash="ZpXKjA" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/ZpXKjA/">Focus Reset</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

You might want to try the example with multiple screen readers, Safari/VoiceOver, IE/JAWS, Firefox/NVDA.

## Guided Focus Management

In `guided focus management`, the container of the dynamic content is focused.
So that screen reader can start reading the content of the dynamic container.
It also serves as a guided context switch. Any subsequent `tab` press will focus the next focusable element within/after this context.

Most likely the container is a non-focusable element like `div`, `section`, `article`, `span` etc.,
thus it needs to have `tabindex=-1` attribute, in order to be focused via JavaScript using `HTMLElement.focus()`.

For more on `tabindex=-1` please refer [tabindex=-1](/blog/2016/10/14/tab-order-and-tabindex#tabindex-1) section of my earlier post [tab order and tabindex](/blog/2016/10/14/tab-order-and-tabindex).

Refer [CodePen example - Guided Focus Management](http://codepen.io/sarbbottam/full/LRzyBq/).

<p data-height="300" data-theme-id="0" data-slug-hash="LRzyBq" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/LRzyBq/">Guided Focus Management</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

> Does one always need guided focus management for dynamic content?

_Not really, sometimes not required, sometimes you can't._

### Sometimes not required

Consider the [CodePen example - Guided Focus Management - Sometimes not required](http://codepen.io/sarbbottam/full/VKVpjp/)

<p data-height="450" data-theme-id="0" data-slug-hash="VKVpjp" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/VKVpjp/">Guided Focus Management - Sometimes not required</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

trigger node utilizes the `aria-expanded` attribute, which let's the screen reader user be aware of the situation.
As the expanded section immediately follows the trigger node, any subsequent `tab` will focus the first focusable element in the expanded section.

However, if the dynamic content appears before the trigger or replaces the trigger is replaced by the dynamic content, `guided focus management` is your best bet.

Consider the [CodePen example - Show more/less](http://codepen.io/sarbbottam/full/RRKOPy/)

<p data-height="300" data-theme-id="0" data-slug-hash="RRKOPy" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/RRKOPy/">Show more/less, better user experience</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

### Sometimes you can't

For example, an auto-complete or typeahead widget.
Focus must remain in the `textbox` as the user is interacting with it.

In scenarios, where you can't shift focus, you would want to utilize `aria live region` to provide feedback to non-sighted users.

Refer the [CodePen example - Typeahead](http://codepen.io/sarbbottam/full/yakYLV/)

<p data-height="720" data-theme-id="0" data-slug-hash="yakYLV" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/yakYLV/">Guided Focus Management - Sometimes you can't</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

### Caveats

If a container has any of [landmark roles](https://www.w3.org/TR/wai-aria/roles#landmark_roles) associated,
VoiceOver with Safari does not read out the dynamic content, though the container is focused, due to associated `landmark role`, at the time of writting this post.

Please refer [CodePen example - Guided Focus Management - role="main"](http://codepen.io/sarbbottam/full/PGydQy/)

<p data-height="265" data-theme-id="0" data-slug-hash="PGydQy" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/PGydQy/">Guided Focus Management - role="main"</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

### Single Page Application

Screen reading software, on page load, starts reading the content of the page from the beginning.
In Single Page Application, there is no page load after the initial one.

When the contents gets updated with out a page load, screen reading software has no clue by default.
However utilizing `guided focus management` one can explicitly let the screen reading software read out the updates.

_Guided focus management is higly desired in Single Page Applications._
