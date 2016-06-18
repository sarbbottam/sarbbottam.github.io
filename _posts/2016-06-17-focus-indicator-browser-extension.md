---
layout: post
title:  "Focus Indicator - Browser(Chrome) Extension"
date:   2016-06-17 17:30:00
categories: Accessibility, JavaScript, Browser Extension
---

TL;DR;

<a href="https://www.youtube.com/watch?v=r-AYcPC-Dsg" title="Screencast - Focus Indicator Chrome extension in action">
  <img src="http://i.imgur.com/qqEXCal.png" alt="Screencast - Focus Indicator Chrome extension in action" style="display: block; max-width:100%; margin: auto"/>
</a>

## What is the problem?

While accessing any digital interface, focus indicator, is very important.
Focus indicator highlights the active intractable component or control.
It is true for web pages also.

By default, every browser highlights the active intractable element.
But sometimes, web developers, suppress it using `outline: none`, which creates the problem.

For example, when accessing [Times of India](http://timesofindia.indiatimes.com/), a leading Indian daily, via keyboard,
active intractable element is not visually distinguishable.

I have no intension to shame or criticize [Times of India](http://timesofindia.indiatimes.com/), it is just an example.
There are tons of other examples, across the web.

[Searching for `outline: none` in Github displays hundreds of `outline: none`'s existence.](https://github.com/search?l=css&q=outline%3A+none&type=Code&utf8=%E2%9C%93)

## [Focus Indicator](https://chrome.google.com/webstore/detail/focus-indicator/heeoeadndnhebmfebjccbhmccmaoedlf) to the rescue.

As the name suggests, 'Focus Indicator' extension highlights the active intractable element in a webpage.

<img src="http://i.imgur.com/pck8LJW.png" alt="Times of India logo highlighted by Focus Indicator" style="display: block; max-width:100%; margin: auto"/>

If you prefer accessing web pages via keyboard, I hope this extension will be helpful.

## Disclaimer

>> The idea behind this extension was to help me at my Job

As a part of my job, I started auditing web interface w.r.t. accessibility.
Keyboard operability is one of the key aspect of accessibility.

If there are no focus indicators for active intractable elements, for sure, it's an issue.
But I need to also verify, that the intractable elements are operable too (considering the focus indicator issue does not exist), and report accordingly.

In the lack of focus indicator, I had been very tedious for me to verify, if an intractable element is operable via keyboard.

## Solution

Enforce outline (-ve) on the active element.

```css
:focus {
  outline: 2px solid #50e3c2 !important;
  outline-offset: -2px !important;
}
```

## Evolution

I wish I knew about `outline-offset` and it's `-ve` value.

### Initial approach

I would open up JavaScript console and look for the `document.activeElement`; but that would result in resetting the tab order.
I had to start tab-ing from the beginning again.

### Second pass

Then I used the following snippet

```js
document.addEventListener('focus', function() {
  console.log(document.activeElement);
}, true);
```

It was better than the previous approach, but logging the markup was not of great help.
From the markup, it was not clear (many a time), what visual co-ordinate it represented.
In order to co-relate the markup, I had to access the `dev tool` and that would reset the tab order.
I had to start tab-ing from the beginning again.

### Then ...

Why not add a border? `border: 1px solid red`, good old way debugging layout.

Yep, that's what I used, along with `alert` for debugging, when there were no dev tools.

But `border` was impacting the layout and was not always distinguishable, due to foreground and background color.

So, I used `box-shadow`, it was better, but did not work for all the elements.
`box-shadow` was not visible for, the elements that were enclosed within another, without any spacing and `overflow: hidden`.

<p data-height="265" data-theme-id="0" data-slug-hash="QEKyKG" data-default-tab="css,result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/QEKyKG/">box-shadow</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

> `outline` had similar issue.

Then, I used, `box-shadow: inset`, only to find out the reverse situation.
`box-shadow: inset` was not visible, for the elements that contained other elements, without any spacing.

<p data-height="265" data-theme-id="0" data-slug-hash="gMwPwO" data-default-tab="css,result" data-user="sarbbottam" data-embed-version="2" class="codepen">See the Pen <a href="http://codepen.io/sarbbottam/pen/gMwPwO/">box-shadow: inset</a> by Sarbbottam Bandyopadhyay (<a href="http://codepen.io/sarbbottam">@sarbbottam</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

### How about `absolute`ly `position`ed element

Use an `absolute`ly `position`ed element, update it's `dimensions` to that of the active element and `position` is over the active element?

I was about to pat myself, but noticed, it broke the mouse interaction.

> Things were already becoming complex.

Why or rather how?
Well it was stacked above the active element and prevented any mouse event to pass through.
Thanks to `pointer-events: none`, it saved the day.

So far so good!

## Updates (Jun 18, 2016)

I published the extension and [shared it on Twitter](https://twitter.com/sarbbottam/status/744005122104131584)

I am thankful to [Ted Drake](https://twitter.com/ted_drake) & [Thierry Koblentz](https://twitter.com/thierrykoblentz) for their feedback and suggestions.

[Ted appreciated the extension, and emphasized about `outline`](https://twitter.com/ted_drake/status/744110815117213696).
On replying, that it behaves similar to `box-shadow`, [Thierry suggested -ve outline-offset](https://twitter.com/thierrykoblentz/status/744233653333463042)

`-ve outline-offset` worked, but I was not satisfied as it affected readability.

<img src="http://i.imgur.com/jTyiOya.png" alt="-ve outline overlapping the content" style="display: block; max-width:100%; margin: auto"/>

I addressed it, then noticed something else. I addressed that, and noticed something else. It was turning in to never-ending rabbit hole.

So, I followed Thierry's suggestion and settled with `-ve outline-offset`. You can find the complete conversation [here](https://twitter.com/sarbbottam/status/744005122104131584).

[Though the eventual source code is just 2 lines](https://github.com/sarbbottam/focus-indicator/blob/master/src/style.css#L1-L4), I learnt a lot.

---

[Focus Indicator](https://chrome.google.com/webstore/detail/focus-indicator/heeoeadndnhebmfebjccbhmccmaoedlf) is in active development.

- Should you find any be issue, [please report it](https://github.com/sarbbottam/focus-indicator/issues).
- Should you want to make it better, please raise a [pull request](https://github.com/sarbbottam/focus-indicator/compare).

If you have found it useful please share it with others.
