---
layout: post
title: Show more/less actionable list items
description:
  Hide the extra items completely, if you mean it.
  Otherwise they might be avialable to keyboard only and screen reader users, even though not available for mouse only users.
date: 2016-06-26 10:30:00
categories: Accessibility, CSS
excerpt_separator: <!--more-->
redirect_from: /accessibility,/css/2016/06/26/show-more-show-less-actionable-list-items/
---

## TL;DR;

Hide the extra items completely, if you mean it.
<!--more-->
## CodePen example - Show more/less, bad user experience

There are 10 links as line items, with mouse only first 5 are available(accessible) initially.
The remaining are available only, if the use clicks the "Show more" button.

How ever that's not true for a keyboard user, using `tab`, or for a screen reader user.
In the below example all the 10 links are available to the user. Try accessing the below UI using `tab`.

<p data-height="265" data-theme-id="0" data-slug-hash="aZpMPN" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/aZpMPN/">Show more/less  - bad example</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

The `Show more` button is not only meaningless, as it appears after the user has navigated through all the links, but confusing too.

One could add, `aria-hidden="true"` attribute to the button, so that screen reading software, ignores it.
But it does not fix the behavior for keyboard only user.
More over, it is not an optimal user experience for a keyboard user, they have to pass through all the links, when accessing a web document, in top down fashion.

## Solution

A better experience would be to wrap the _more_ items in a `container`, and set its `display` to `none` initially.
And updated the `display` to `block` or `none` on demand, i.e. when the corresponding button is interacted.

Also focus the `container`, so the screen reading software can start reading out its the content.

Try the following example.

<p data-height="265" data-theme-id="0" data-slug-hash="RRKOPy" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/RRKOPy/">Show more/less, better user experience</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>
