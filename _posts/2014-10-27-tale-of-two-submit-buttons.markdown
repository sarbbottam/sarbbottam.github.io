---
layout: post
title:  "Tale of two submit buttons!"
date:   2014-10-27 14:45:00
categories: forms
---

## Why two submit buttons?

Two different action as per users' preference, on the same data provided.
For (dumb) example: User can choose to be greeted either in Spanish or in French.

{% highlight html %}
<form id="greeting-form" method="get" action="">
  <input type="text" name="name" value="Sarbbottam">

  <input type="submit" id="hola-button" value="Hola" name="greeting">
  <input type="submit" id="bonjour-button" value="Bonjour" name="greeting">
</form>
{% endhighlight %}

## User action vs Form data

Form data passed, to the form action, depends on the user interaction.

user action  | form data passed
------------- | -------------
clicks on **Hola** button  | name=Sarbbottam&greeting=**Hola**
clicks on **Bonjour** button | name=Sarbbottam&greeting=**Bonjour**
tabs to the **Hola** button and presses ``enter`` in the physical keyboard | name=Sarbbottam&greeting=**Hola**
tabs to the **Bonjour** button and presses ``enter`` in the physical keyboard | name=Sarbbottam&greeting=**Bonjour**
while being in the ``name field`` (editable fields), presses ``enter`` in the physical keyboard or ``Go`` in the soft keyboard<sup>*</sup> | name=Sarbbottam&greeting=**Hola**

<sup>*</sup> *Pressing/tapping the ``enter/Go`` button, triggers the click event on first submit button (the submit button that appears first in the DOM).*

Form action handler, can rely on the value of ``greeting`` parameter to take desired action.

{% highlight javascript %}
if(greeting === 'Hola') {
  // Hola action
} else {
  // Bonjour action
}
{% endhighlight %}

## Example - Two submit button

<p data-height="280" data-theme-id="0" data-slug-hash="fDqIw" data-default-tab="result" data-user="sarbbottam" class='codepen'>See the Pen <a href='http://codepen.io/sarbbottam/pen/fDqIw/'>greeting-no-js</a> by Sarbbottam Bandyopadhyay (<a href='http://codepen.io/sarbbottam'>@sarbbottam</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//codepen.io/assets/embed/ei.js"></script>

Form action handler is relying on the value of the ``greeting`` parameter(name of the submit button) to greet the user.

## What problem might arise?

So far so good, but if the form submit action is trapped and the form is submitted via JavaScript, the ``greeting`` parameter will not be part of the form data.

{% highlight javascript %}
var holaButton = document.getElementById('hola-button');
var bonjourButton = document.getElementById('bonjour-button');
var greetingForm = document.getElementById('greeting-form');

var submitForm = function(e) {
  e.preventDefault();
  e.stopPropagation();
  // some action, like validation
  greetingForm.submit();
};

holaButton.addEventListener('click', submitForm, false);
bonjourButton.addEventListener('click', submitForm, false);
{% endhighlight %}

<p data-height="260" data-theme-id="0" data-slug-hash="jLxKi" data-default-tab="result" data-user="sarbbottam" class='codepen'>See the Pen <a href='http://codepen.io/sarbbottam/pen/jLxKi/'>greeting-js-buggy</a> by Sarbbottam Bandyopadhyay (<a href='http://codepen.io/sarbbottam'>@sarbbottam</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//codepen.io/assets/embed/ei.js"></script>

Since the ``greeting`` parameter is not present the form action handler behavior is buggy.

## Proposed solution

Using a ``hidden input`` to track the user action (the button clicked).
{% highlight html %}
<input type="hidden" id="proxy-submit-button">
{% endhighlight %}

Before the form is submitted via JavaScript, the name and value of the ``proxy-submit-button`` is updated.
{% highlight javascript %}
var holaButton = document.getElementById('hola-button');
var bonjourButton = document.getElementById('bonjour-button');
var proxySubmitButton = document.getElementById('proxy-submit-button');
var greetingForm = document.getElementById('greeting-form');

var submitForm = function(e) {
  e.preventDefault();
  e.stopPropagation();
  /* set the proxy button value */
  proxySubmitButton.value = this.value;
  /* set the proxy button name */
  proxySubmitButton.name = this.name;
  greetingForm.submit();
};

holaButton.addEventListener('click', submitForm, false);
bonjourButton.addEventListener('click', submitForm, false);

{% endhighlight %}

<p data-height="280" data-theme-id="0" data-slug-hash="Biqzu" data-default-tab="result" data-user="sarbbottam" class='codepen'>See the Pen <a href='http://codepen.io/sarbbottam/pen/Biqzu/'>greeting-js-proper</a> by Sarbbottam Bandyopadhyay (<a href='http://codepen.io/sarbbottam'>@sarbbottam</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//codepen.io/assets/embed/ei.js"></script>

If for any reason JavaScript is not executed, the ``proxy-submit-button`` element will not be passed to the form action as it does not have any name and ``greeting`` parameter will always be passed to the form action.

If JavaScript is functional, then ``proxy-submit-button`` will be named as ``greeting`` and its value will be updated to the value of the **submit** button clicked<sup>*</sup>. Thus at a time only one parameter named ``greeting`` will be passed to the form action.

<sup>*</sup> *Pressing/tapping the ``enter/Go`` button, triggers the click event on first submit button (the submit button that appears first in the DOM).*


## Wrap up
Technically, the [proposed solution](#proposed-solution) holds good for any number of submit buttons but more than two submit button might not be a desired user experience.
