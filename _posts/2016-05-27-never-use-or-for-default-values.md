---
layout: post
title:  "I will never use || (OR) for default values"
date:   2016-05-27 11:30:00
categories: javascript
---

## TL;DR;

I will never use `||` for default values, but [default parameter](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Default_parameters).

For example, instead of

```js
function sort(array, startIndex, endIndex) {
  startIndex = startIndex || 0;
  endIndex = endIndex || array.length — 1;
  ...
}
```

I would use,

```js
function sort(array, startIndex = 0, endIndex = array.length - 1) {
  ...
}
```

## Why?

I have been using `||` for default values, till date.

But it bite me big time. A [quick sort implementation in JavaScript](https://github.com/sarbbottam/js-ds/commit/11e5e6b8ec2f3220ae81e121e75d3fe405381d3d#diff-c0c1d6f81c13fd41660d58b54f5adbfbL20),
fell in to infinite [`recursion`](https://en.wikipedia.org/wiki/Recursion),
because of `||`, when an [already sorted array was passed](https://github.com/sarbbottam/js-ds/commit/11e5e6b8ec2f3220ae81e121e75d3fe405381d3d#diff-c39e9bafb9e79fcf0b4d8a08966430d1R15).

Long story short, w.r.t the above [quick sort implementation in JavaScript](https://github.com/sarbbottam/js-ds/blob/5721959e402bdffa0b5ffbbe5bea21495a1e84ec/lib/algo/sort/quick/index.js#L20)
even if `endIndex` will be passed as `0` (zero), on purpose, it would be evaluated to `array.length - 1`.
As `0` is a `falsy` value in JavaScript. Same would happen if `''` or `null`, is passed as `endIndex`,
or any other [`falsy`](https://developer.mozilla.org/en-US/docs/Glossary/Falsy) values.

However the intention have been, if `endIndex` was not passed (`undefined`), then evaluate it to `array.length — 1`.
Thus, modifying the condition to
[`endIndex = endIndex === undefined ? length - 1 : endIndex;`](https://github.com/sarbbottam/js-ds/commit/11e5e6b8ec2f3220ae81e121e75d3fe405381d3d#diff-c0c1d6f81c13fd41660d58b54f5adbfbR20), resolves the issue.

[ES2015 nakes it easier with default parameter](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Default_parameters).

> With default parameters, the `undefined` checks in the function body is no longer necessary.

So, instead of

```js
function sort(array, startIndex, endIndex) {
  startIndex = startIndex === undefined ? 0 : startIndex;
  endIndex = endIndex === undefined ? array.length — 1 : endIndex;
  ...
}
```

I would use,

```js
function sort(array, startIndex = 0, endIndex = array.length - 1) {
  ...
}
```