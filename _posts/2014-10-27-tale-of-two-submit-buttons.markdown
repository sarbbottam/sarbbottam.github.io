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

So far so good, but if the ~~form submit action is trapped~~ **click event of the submit buttons** is trapped and the form is submitted via JavaScript, the ``greeting`` parameter will not be part of the form data.

However, if the **form submit event is trapped** and the form is submitted via JavaScript, the clicked button will be part of the serialized form data.
Thanks to [Adam Brunner](https://twitter.com/clcpolevaulter) for the [pointer](https://twitter.com/clcpolevaulter/status/529822434287841280).

{% highlight javascript %}
var holaButton = document.getElementById('hola-button');
var bonjourButton = document.getElementById('bonjour-button');
var greetingForm = document.getElementById('greeting-form');

var submitForm = function(e) {
  e.preventDefault();
  e.stopPropagation();
  // some action, firing beacon with the value of the submit button
  greetingForm.submit();
};

holaButton.addEventListener('click', submitForm, false);
bonjourButton.addEventListener('click', submitForm, false);
{% endhighlight %}

<p data-height="260" data-theme-id="0" data-slug-hash="jLxKi" data-default-tab="result" data-user="sarbbottam" class='codepen'>See the Pen <a href='http://codepen.io/sarbbottam/pen/jLxKi/'>greeting-js-buggy</a> by Sarbbottam Bandyopadhyay (<a href='http://codepen.io/sarbbottam'>@sarbbottam</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//codepen.io/assets/embed/ei.js"></script>

Since the ``greeting`` parameter is not present the form action handler behavior is buggy.

## Proposed solution

Instead of listening to submit button click, listening to form submit resolves the issue. Sweet and simple.

But the whole idea of the [previously proposed solution](#(previously)-proposed-solution-(not-optimal)) was to detect which submit button was clicked.

The submit button clicked can be detected with ``document.activeElement``.

{% highlight javascript %}
var greetingForm = document.getElementById('greeting-form');

var submitForm = function(e) {
  e.preventDefault();
  e.stopPropagation();
  // which submit button is clicked
  var activeElement = document.activeElement;
  if(activeElement.type === 'submit' && activeElement.name !== '') {
    console.log(activeElement.value);
  }
  // some action, firing beacon with the value of the submit button
  greetingForm.submit();
};

greetingForm.addEventListener('submit', submitForm, false);

{% endhighlight %}

<p data-height="280" data-theme-id="0" data-slug-hash="fkjGH" data-default-tab="result" data-user="sarbbottam" class='codepen'>See the Pen <a href='http://codepen.io/sarbbottam/pen/fkjGH/'>greeting-js-proper</a> by Sarbbottam Bandyopadhyay (<a href='http://codepen.io/sarbbottam'>@sarbbottam</a>) on <a href='http://codepen.io'>CodePen</a>.</p>
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>

## (Previously) Proposed solution (not optimal)

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

Thanks to [Chris Coyier](https://twitter.com/chriscoyier) for the [mention](https://twitter.com/chriscoyier/status/527375172136108032), [Adam Brunner](https://twitter.com/clcpolevaulter) for the [suggestion](https://twitter.com/clcpolevaulter/status/529822434287841280) and internet for its feedback.

<blockquote class="twitter-tweet" lang="en"><p><a href="https://twitter.com/chriscoyier">@chriscoyier</a> <a href="https://twitter.com/sarbbottam">@sarbbottam</a> Why wouldn&#39;t you just use a form submit event instead of a click handler? <a href="http://t.co/IhGCmxUvo2">http://t.co/IhGCmxUvo2</a></p>&mdash; Adam Brunner (@clcpolevaulter) <a href="https://twitter.com/clcpolevaulter/status/529822434287841280">November 5, 2014</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>
