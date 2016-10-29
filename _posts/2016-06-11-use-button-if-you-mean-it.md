---
title: Use button if you mean it
date: 2016-06-11 11:50:00
categories: Accessibility, JavaScript
redirect_from: /accessibility,/javascript/2016/06/11/use-button-if-you-mean-it/
---

Use `<button>` if you want it to behave as a button.
If you are using any other `HTML element` and updating its look, to look like `button`, you are either bothering your users or yourself.

## Why?

If you, want to fake any other `HTML element` element as `<button>`, you have to make sure the `fake button`:

* is reachable via keyboard
* can be activated by pressing `enter` and `space` keys, i.e. invoke the click handler
* is treated as `button` by assistive technologies, for example, screen reading software

For example, try it at [sarbbottam.github.io/empower-your-users/button/accessible/](https://sarbbottam.github.io/empower-your-users/button/accessible/)

`<button>Surprise me!</button>` and `function clickHandler(e) { ... } button.addEventListener('click', clickHandler);` is sufficient to satisfy all the criteria.

---

To make a `<span>` or `<div>` or some other non-intractable `HTML element` behave as button.

You have to

* add `tabindex=0`, to make it reachable via keyboard
* listen to `keydown` event and detect if `enter` or `space` is pressed and invoke the `click` handler
* use `role=button` so that it is treated as `button` by assistive technologies, for example, screen reading software

Otherwise, it would result in a broken behavior, try it out at [sarbbottam.github.io/empower-your-users/button/inaccessible](https://sarbbottam.github.io/empower-your-users/button/inaccessible)

The markup would look something like

```diff
- <span>Surprise me!</span>
+ <span tabindex=0 role="button">Surprise me!</span>
```
And associated JavaScript

```diff
function clickHandler(e) { ... }
button.addEventListener('click', clickHandler);

+ span.addEventListener('keydown', function(e) {
+  if (e && (e.keyCode === 32 || e.keyCode === 13) ) {
+    // e.preventDefault();
+    // e.stopPropagation();
+    clickHandler(e);
+  }
+});
```

**Why would you write so much extra code?**

## How about `<a>`?

You still have to write few extra lines.

* `<a>` with out an `href` attribute is similar to `<span>`, `<div>` or some other non-intractable `HTML element`
* `<a>` with `href` attribute reacts to `enter` keys but not `space`
  * So you have to listen to `keydown` event and detect if `space` was pressed and invoke the `click` handler
  * Also you have to **prevent the default behavior** if `enter` key was pressed, other wise browser will navigate to the location, specified by `href`,
  even if `href` is `#`, other wise page will scroll up by default.
* Have to add `role=button` so that it is read and treated as `button` and not `link` by screen readers and assistive technologies

In [Anchors vs Buttons](https://bitsofco.de/anchors-vs-buttons/), [Ire Aderinokun](https://bitsofco.de/) explores different possibilities and suggests a hybrid approach of using `<a>` and progressively enhancing it to a `button`

>If Javascript is enabled, we can then change all the anchor elements to buttons.

I see the intent, of making the UI functional in non-JavaScript scenario, which is great.

>The `<button type=“button”>` element, as mentioned, by default does nothing.
JavaScript must be used to add functionality to it.
Therefore, if the user doesn’t have JavaScript enabled on their device,
then they can no longer access the content behind the interaction, in this case the navigation menu.

But I have a different opinion.

Purpose of buttons other than `submit|reset` is coupled with JavaScript. Buttons other than `submit|reset`, are of no use without JavaScript.

If you are relying on an interface, for non-JavaScript scenario, (which you should, as the base criteria),
design your interface accordingly, it should be simple.
For non-JavaScript UI, there should not be any notion of `button` other than `submit|reset`.

Let's consider a scenario, **inline edit of user's profile information**, it is not possible provide the functionality without JavaScript.
IMO, don't display the inline edit option, for non-JavaScript UI, but display a `link` which would navigate to an *edit page*.

If JavaScript is enabled, enhance the experience accordingly, progressively.

If you are still not encouraged to use `<button>`, if you mean it, please read [You can’t create a button](https://www.nczonline.net/blog/2013/01/29/you-cant-create-a-button/) by [Nicholas C. Zakas](https://www.nczonline.net/)

If you have enjoyed and feel benefitted from the post, please share it.
Should you have different opinion, please share it via comments.
