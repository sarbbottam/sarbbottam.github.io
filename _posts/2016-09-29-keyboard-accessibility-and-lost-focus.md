---
layout: post
title: Keyboard Accessibility and Lost Focus
date: 2016-09-29 16:50:00
categories: Accessibility, CSS
excerpt_separator: <!--more-->
redirect_from: /accessibility,/css/2016/09/29/keyboard-accessibility-and-lost-focus/
---

Visual indicator is must for a keyboard user, to identify an active element, so that the user can press the corresponding desired keys, to interact with the active element.

For example,

* pressing `space` on a `checkbox` toggles the `checked` status
* pressing down arrow on a `select` displays the `options` list
* pressing `space/enter` on a button activates it.

Without a visual indicator a keyboard only user has no clue to identify the active element.

<!--more-->

A keyboard user, uses `tab` to navigate to the focusable elements in the UI.
A keyboard user, may also use up/down/left/right arrow keys for navigating between groups or widgets, for example, radio buttons, tab panel, suggestions in a typeahead etc.

When a user presses `tab`, browser focuses the next focusable element, in the tab order.
By default browsers highlights any focusable element, with a default focus indicator, when it is focused.

But sometimes the default focus indicator is suppressed, via `:focus {outline: none}`, leading to an inaccessible UI for a keyboard only user.

*Would you use `* {cursor: none}`? Why `:focus {outline: none}` then?*

**Consider focus indicator for a "keyboard only" user is analogous to mouse pointer/hover indicator for a "mouse only" user.**

_If you want to suppress the default focus indicator, please compensate with some visually distinguishable style._

I hope by now you have understood the importance of visual focus indicator. If not, keep reading and try out the examples.

> The example are targeted for non-touch interactions, to emphasize keyboard accessibility.

## Why visual focus indicator is so important?

Let’s imagine a hypothetical situation, where mouse (and related input devices, for example trackpad) is functional, but the mouse pointer is not visible.
Refer [CodePen example - No mouse pointer - No hover effect](http://codepen.io/sarbbottam/full/WGAGXZ/), for the above stated hypothetical situation. Can you click the “Click me” button at [CodePen example - No mouse pointer - No hover effect](http://codepen.io/sarbbottam/full/WGAGXZ/)?

<p data-height="650" data-theme-id="0" data-slug-hash="WGAGXZ" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/WGAGXZ/">No mouse pointer - No hover effect</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

**I could not click the "Click me" button.**
I could not figure out, if the mouse pointer is over the button.

 _You can resize the window to approximately guess the mouse pointer, but that's an awful user experience._

A `:hover` style might have been helpful.
Refer [CodePen example - No mouse pointer - But hover effect](http://codepen.io/sarbbottam/full/mAVAXQ/).

<p data-height="650" data-theme-id="0" data-slug-hash="mAVAXQ" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/mAVAXQ/">No mouse pointer - But hover effect</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

Though it has not created a great user experience, but much better than the previous example. I was able to click the “Click me” button.

As stated earlier, a keyboard only user, uses `tab` (primarily) to navigate between focusable elements and a focus indicator identifies  the active element.

Can you navigate to “Click me” button via `tab`, and activate it by pressing `space/enter` at [CodePen example - No mouse pointer - No Hover effect  - No Focus Indicator](http://codepen.io/sarbbottam/full/JRGRqv/)?

<p data-height="760" data-theme-id="0" data-slug-hash="JRGRqv" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/JRGRqv/">No mouse pointer - No Hover effect  - No Focus Indicator</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

**There is no easy way, but to try back and forth, and guess when the "button" is focused.**
Imagine when there are several elements. One has to keep a mental map and order of the focusable elements. It can be tedious and not a good user experience.

**Make sure any active element is clearly distinguishable.** Good to have :focus & :hover style go hand in hand.

Refer [CodePen example - :hover and :focus goes hand in hand](http://codepen.io/sarbbottam/full/XjXjLz/).

<p data-height="700" data-theme-id="0" data-slug-hash="XjXjLz" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/XjXjLz/">:hover and :focus goes hand in hand</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

## Lost focus

**When ever the active element can not be identified, it results in lost focus.**

So far we have seen "Lost focus" happens when there is no focus indicator, but lost focus can also happen
- when background and focus indicator color is same
- when invisible elements are focused

### Non distinguishable focus indicator

Refer [CodePen example - non distinguishable focus indicator in chrome/safari](http://codepen.io/sarbbottam/full/yaJXkx/), the default focus indicator is not distinguishable in Chrome/Safari

<p data-height="500" data-theme-id="0" data-slug-hash="yaJXkx" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/yaJXkx/">non distinguishable focus indicator in chrome/safari</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

It would be better add a custom focus indicator in such scenario, refer [CodePen example - custom focus indicator](http://codepen.io/sarbbottam/full/YGxYpa/).

<p data-height="500" data-theme-id="0" data-slug-hash="YGxYpa" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/YGxYpa/">custom focus indicator</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

### Invisible focusable elements

Refer [Codepen example - Invisible focusable element](http://codepen.io/sarbbottam/full/LRjZoB/).

<p data-height="500" data-theme-id="0" data-slug-hash="LRjZoB" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/LRjZoB/">Invisible focusable elements</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

Though the intermediate buttons are not visible they are focusable and thus reachable via `tab`, resulting in lost focus.

If you want to hide an element use `display:none` or `visibility:hidden`,
so that the elements are not only invisible, but also removed from the tab order, and can not be focused.

Refer [Codepen example - No Invisible focusable element](http://codepen.io/sarbbottam/full/mArXyY/)

<p data-height="500" data-theme-id="0" data-slug-hash="mArXyY" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/mArXyY/">No invisible focusable elements</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

_When ever there is an invisible focused element, it results in lost focus._


## Conclusion

Avoid lost focus and enhance users’ experience.
