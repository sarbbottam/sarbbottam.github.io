---
title: Inheritance in JavaScript
date: 2015-09-11 20:50:00
categories: JavaScript, OOps
redirect_from: /oops/2015/09/11/inheritance-in-javascript/
---

Let's consider that `square` is a special type of `rectangle`, whose `length` and `width` are equal.
Thus we can create `blueprint` of a `square` by extending the `blueprint` of a `rectangle`.
I am using the term `blueprint` as JavaScript/ECMAScript version prior ES2015 did not have `class` functionality.

## Pre ES5

Let's create `blueprint` of a `rectangle`

{% highlight javascript %}
function Rectangle(length, width) {
  this.length = length;
  this.width = width;
}

Rectangle.prototype.getArea = function() {
  return this.length * this.width;
}
{% endhighlight %}

Now, let's create `blueprint` of a `square` by extending the above `blueprint` of a `rectangle`

{% highlight javascript %}
function Square(length) {
  Rectangle.call(this, length, length);
}
{% endhighlight %}

Let's create an instance of square

{% highlight javascript %}
var square = new Square(3);
{% endhighlight %}

{% highlight javascript %}
console.log('square.length: ', square.length); // square.length: 3
console.log('square.width: ', square.width); // square.width: 3
{% endhighlight %}

That's good, the length and width of the square has been set without any explicit code.
`Rectangle.call(this, length, length);` is behind the magic.
`Rectangle` is being invoked with the context of current `this`; i.e. `Square` with same value for `length` as well as `width`.

Let's print the area of the `square`
{% highlight javascript %}
console.log('square.getArea(): ', square.getArea()); // Uncaught TypeError: square.getArea is not a function
{% endhighlight %}

Well, there is no `getArea` function associated with `Square`, but there is a `getArea` function associated with `Rectangle`.
So, the inheritance did not establish properly.

JavaScript inheritance is established via the `prototype chain` and the `square` instance created above does not have any link to the `Rectangle`
Please refer the below image.
<img src="http://i.imgur.com/KPEn7rX.png" alt="square.__proto__" style="display: block; max-width:100%"/>

We could establish the `prototype chain` between `Square` and `Rectangle` by assigning an instance of `Rectangle` to `Square`'s `prototype`.

{% highlight javascript %}
Square.prototype = new Rectangle();
{% endhighlight %}

Please refer the below example:
<p data-height="850" data-theme-id="0" data-slug-hash="XmJqgb" data-default-tab="js" data-user="sarbbottam" class='codepen'>See the Pen <a href='http://codepen.io/sarbbottam/pen/XmJqgb/'>JavaScript Inheritance - Pre ES5</a> by Sarbbottam Bandyopadhyay (<a href='http://codepen.io/sarbbottam'>@sarbbottam</a>) on <a href='http://codepen.io'>CodePen</a>.</p>

> What is the purpose of `Square.prototype.constructor = Square;`?

Every instances of `Square` will have a constructor of `Square`, not of `Rectangle`.

If we plan to create another instance of `Square` with respect to an existing instance of `Square`, we need the above line.
For example, if we comment out the `Square.prototype.constructor = Square;`
and try to create another instance of `Square` from an existing instance of `Square`;
the `toString` method of the new instance will refer to the `toString` method of the `Rectangle blueprint` instead of the `Square blueprint`.

{% highlight javascript %}
...
// Square.prototype.constructor = Square;
...

var anotherSquare = new square.constructor(4);
console.log('anotherSquare.toString(): ', anotherSquare.toString()); // anotherSquare.toString(): a rectangle
console.log('square.toString(): ', square.toString()); // square.toString(): a square
{% endhighlight %}

Please refer the below example:
<p data-height="850" data-theme-id="0" data-slug-hash="gaaZbw" data-default-tab="js" data-user="sarbbottam" class='codepen'>See the Pen <a href='http://codepen.io/sarbbottam/pen/gaaZbw/'>JavaScript Inheritance - Pre ES5 - w/o constructor</a> by Sarbbottam Bandyopadhyay (<a href='http://codepen.io/sarbbottam'>@sarbbottam</a>) on <a href='http://codepen.io'>CodePen</a>.</p>

## ES5

If you have got the hang of `prototype` and `constructor` in the pre ES5 example, comprehending the ES5 compliant example would be easy.

Instead of

{% highlight javascript %}
Square.prototype = new Rectangle();
Square.prototype.constructor = Square;
{% endhighlight %}

we will use

{% highlight javascript %}
Square.prototype = Object.create(Rectangle.prototype, {
    constructor: {
        value:Square,
        enumerable: true,
        writable: true,
        configurable: true
    }
});
{% endhighlight %}

We are utilizing ES5 [Object.create](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/create) functionality.

Please refer the below example:

<p data-height="1000" data-theme-id="0" data-slug-hash="jbWbrq" data-default-tab="js" data-user="sarbbottam" class='codepen'>See the Pen <a href='http://codepen.io/sarbbottam/pen/jbWbrq/'>JavaScript Inheritance - ES5</a> by Sarbbottam Bandyopadhyay (<a href='http://codepen.io/sarbbottam'>@sarbbottam</a>) on <a href='http://codepen.io'>CodePen</a>.</p>

## ES2015

ES2015 comes with `class`, `extends`, `super`, and makes inheritance achievable in lesser lines, similar to other object oriented languages.

{% highlight javascript %}
class Rectangle {
  constructor(length, width) {
    ...
  }
}

class Square extends Rectangle {
  constructor(length) {
    super(length, length); // same as Rectangle.call(this, length, length)
  }
}
{% endhighlight %}

We no longer need to set the `prototype` and `prototype.constructor` explicitly.

Please refer the below example:
<p data-height="870" data-theme-id="0" data-slug-hash="WQrQQv" data-default-tab="js" data-user="sarbbottam" class='codepen'>See the Pen <a href='http://codepen.io/sarbbottam/pen/WQrQQv/'>JavaScript Inheritance - ES2015</a> by Sarbbottam Bandyopadhyay (<a href='http://codepen.io/sarbbottam'>@sarbbottam</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

## Further reading

* [OOP in JS, Part 2 : Inheritance](http://phrogz.net/js/classes/OOPinJS2.html)
* [Understanding ECMAScript 6 - Classes](https://github.com/nzakas/understandinges6/blob/master/manuscript/08-Classes.md)
