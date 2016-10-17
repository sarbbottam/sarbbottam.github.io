---
layout: post
title:  "Do you know this?"
date:   2015-09-16 10:50:00
categories: oops
redirect_from: /oops/2015/09/16/do-you-know-this/
---

The value of `this` in ECMAScript refers to the execution context of the function.
In ECMAScript there are three execution context; namely global, function and evaluation.
Following example will help to comprehend the concept better.

## Global context:

In the global context `this` refers to the window object.

```js
console.log(this) // Window
```

## Function context:

In ECMAScript a function can be invoked in five different way:

 * method invocation
 * function invocation
 * constructor invocation
 * apply invocation
 * call invocation.

The value of this within the function context depends on how the function has been invoked.

### Method invocation:

In method invocation pattern this refers to the object (on which the method has been invoked) itself. The value of this gets bound to the object at the time of invocation.

```js
var foo = {
    bar : function() {
       console.log(this);
       return this;
    }
}

console.log(foo.bar()) // Object; that refers to foo

var foo = {
    bar : function() {
       return this;
    }
}

console.log(foo === foo.bar()); // true; 'this' returned by bar is nothing but foo
```

### Function invocation:

In function invocation pattern this refers to the window object.
In the broader perspective even function invocation pattern is nothing but method invocation pattern.
The context of the function is window. Lets consider we have a named function `baz` as below:

```js
var baz = function() {
    console.log(this);
}
```

In the function invocation pattern `baz` can be invoked as:

```js
baz(); // Window
```
However `baz` can also be invoked as:

```js
window.baz(); // Window; as stated in method invocation pattern
```

All the global (variables, objects, functions) are associated with window and as per the specification, when referring a global the window reference can be omitted.
Thus window refers to the global context in function invocation pattern.

### Constructor Invocation:

In the constructor invocation pattern, when a function is invoked with `new` operator, `this` refers to the new object that gets created and returned by the function (provide there is no explicit return statement).

```js
var Foo = function () {// By convention the constructor name starts with upper case letter
    console.log(this); // Foo
}
```

The above code is can be interpreted as

```js
var Foo = function () {// By convention the constructor name starts with upper case letter
    // create a new object
    // using the object literal
    // var this = {};
    console.log(this); // Foo, only when invoked as new Foo(); otherwise this will refer to Window
    // return this;
}
```

**ES2015** provides `class` functionality, which follows the same paradigm.

### Apply Invocation & Call Invocation:

Apply and Call invocation differs the way argument is treated. But with respect to this both the pattern behaves in the same way.
The beauty of these two patterns is that this can be set to any desired context.

**ES5** provides the [`bind`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Function/bind) functionality, it creates a new function that, when called, has its `this` keyword set to the provided value.

```js
var bar = {}

var qux = function () {
    console.log(this);
}

qux.apply(bar) // Object; that refers to bar

qux.call(bar) // Object; that refers to foo
```

### Evaluation context:

In evaluation context the value of this refers to the context of the scope.

```js
eval('console.log(this)') // Window
```

```js
var foo = {
    bar : function() {
       eval('console.log(this)')
    }
}

foo.bar(); // Object; that refers to foo
```

A word of caution: One should refrain from using `eval`, most of the ECMAScript ninjas consider “`eval` is evil”.
However, I feel that `eval` is too powerful to be utilized.
Improper utilization can produce unexpected results, which can be really frightening, for example [XSS](https://en.wikipedia.org/wiki/Cross-site_scripting) attacks.

### Anonymous function

In `strict` mode; it's `undefined` other wise global `this`, `Window` in browser.

```js
(function() {
  'use strict';
  console.log(this); // undefined
}());

(function() {
  console.log(this); //[object global]
}());
```

In **ES2015 arrow function**, `this` is the lexical `this`.