---
layout: post
title:  "Display focus-indicator for styled radio and checkbox"
date:   2016-06-25 10:30:00
categories: Accessibility, CSS
---

## TL;DR;

When styling `radio buttons` and `checkboxes` by hiding them visually
and using [pseudo-elements](https://developer.mozilla.org/en-US/docs/Web/CSS/Pseudo-elements),
along with [pseudo-classes](https://developer.mozilla.org/en-US/docs/Web/CSS/pseudo-classes),
_please ensure to add custom focus indicator_.

Otherwise, a user accessing the user interface via keyboard, has no idea, what is the active element/field.

### CodePen example - Styled radio & checkbox without focus-indicator

Try accessing the below example using keyboard; `tab`, `space`, `enter`, `up/down/left/right` arrow keys.

<p data-height="265" data-theme-id="0" data-slug-hash="EyZENx" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/EyZENx/">Styled radio & checkbox w/o focus-indicator</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

>Was that difficult?

## Solution

With respect to the above example, add a custom focus indicator to the `pseudo-element`, when the field is focused.

```css
[type="checkbox"]:focus + label:before,
[type="radio"]:focus + label:before{
  /*
  add a style that visually distinguishes it from others
  border: -
  box-shadow: -
  ...
  better to have a consistent treatment across the page.
  */
  outline: 2px solid #50e3c2;
}
```

_Irrespective of the approach, please ensure any active element is visually distinguishable from others._

### CodePen example - Styled radio & checkbox with focus-indicator

Try accessing the example using keyboard; `tab`, `space`, `enter`, `up/down/left/right` arrow keys.

<p data-height="265" data-theme-id="0" data-slug-hash="KMaogG" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/KMaogG/">Styled radio & checkbox w/ focus-indicator</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

>It's much better than the previous example.

If using, native HTML elements as is, you get it (focus outline) for free.

### CodePen example - Unstyled radio & checkbox (default focus-indicator)

<p data-height="265" data-theme-id="0" data-slug-hash="oLBqYL" data-default-tab="result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/oLBqYL/">Unstyled radio & checkbox (default focus-indicator)</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

## Protip

Never use `display: none`; any element or its ancestor with `display` set to `none`, will not be reachable via keyboard.
It is out of the `tab order`.