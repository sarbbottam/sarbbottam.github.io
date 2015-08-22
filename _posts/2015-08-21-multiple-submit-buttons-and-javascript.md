---
layout: post
title:  "Multiple submit buttons and JavaScript"
date:   2015-08-21 17:40:00
categories: forms
---

## Why do I need two submit buttons in a form? 

Two sets of action can happen as per users’ desire, guided by the respective `submit buttons`.
Might be a confusing user experience for a `form` *with* `input fields`, but helpful for a `form` *with out any* `input field`. 
May be also helpful, for a `form` *with only one* `input field`. 
 
An example would be, send text message or make a voice call to the users’ phone number for: 

* Sending One Time Password
* Verifying the user provided phone number.

<img src="http://i.imgur.com/bSaToGv.png" alt="SMS/Call form" style="width: 300px; display: block;"/>

For One Time Password, phone number is already associated with users’ account, so the UI could be potentially *without any* `input field`.
<br>
For verifying the user provided phone number, it could be part of the same UI or spread across two different UI.

The `action` handler can detect which `submit button` has been `clicked` from the `form data`, if the form was submitted via `POST` or from the `query parameters`, if the form was submitted via `GET` method.

Here is a working (dumb) example of the above-mentioned scenario, using `GET` method to greet users in Spanish or in French.
<p data-height="280" data-theme-id="0" data-slug-hash="QbXNzz" data-default-tab="result" data-user="sarbbottam" class='codepen'>See the Pen <a href='http://codepen.io/sarbbottam/pen/QbXNzz/'>greet</a> by Sarbbottam Bandyopadhyay (<a href='http://codepen.io/sarbbottam'>@sarbbottam</a>) on <a href='http://codepen.io'>CodePen</a>.</p>

`Form data` that would be passed to the `action` handler, depends on the user interaction.
<br>
Below table depicts the `user action` vs `form data` with respect to the above (dumb) example.

user action  | form data passed
------------- | -------------
clicks on **Hola** button  | name=Sarbbottam&greeting=**Hola**
clicks on **Bonjour** button | name=Sarbbottam&greeting=**Bonjour**
tabs to the **Hola** button and presses `enter` in the physical keyboard | name=Sarbbottam&greeting=**Hola**
tabs to the **Bonjour** button and presses `enter` in the physical keyboard | name=Sarbbottam&greeting=**Bonjour**
while being in the `name field` (editable fields), presses `enter` in the physical keyboard or `Go` in the soft keyboard<sup>†</sup> | name=Sarbbottam&greeting=**Hola**

<sup>†</sup> *Pressing/tapping the `enter/Go`, triggers `click event` on the `first submit button` (the submit button that appears first in the DOM).*

---

## JavaScript and form submit 

Things get interesting with introduction of JavaScript. 
You might want to perform certain actions before `submiting` the `form`.

For example:
 
* Fire beacon with the `value` of the `submit button` clicked, to the analytic system.
* Modify the appearence of the `submit button` clicked

To address the above use cases, we could attach `click event` listeners to each `submit buttons` and on `click event` perform the following actions:

* prevent the `default behavior` and stop the `event propagation`
* fire beacon
* submit the form via `form.submit()` method. 

**Simple, isn’t it?**
<br> 
Not really, in the above scenario the `submit button name/value` will not be passed to the form `action` handler.
<br> 
Please refer the below example.

<p data-height="280" data-theme-id="0" data-slug-hash="jLxKi" data-default-tab="result" data-user="sarbbottam" class='codepen'>See the Pen <a href='http://codepen.io/sarbbottam/full/jLxKi/'>greet-user</a> by Sarbbottam Bandyopadhyay (<a href='http://codepen.io/sarbbottam'>@sarbbottam</a>) on <a href='http://codepen.io'>CodePen</a>.</p>

>> Why the `submit button name/value` did not get pass to the `action` handler?

The `form` is not being submitted in the usual manner but via `form.submit()`. 
As we are acting upon the `click event` of the `submit buttons` and not on the `form submit event`, the `submit button name/value` is not part of the `serialized form data`. 

>> What could we do to address this problem?

As suggested [in this tweet](https://twitter.com/clcpolevaulter/status/529822434287841280) with respect to [my previous post](https://sarbbottam.github.io/forms/2014/10/27/tale-of-two-submit-buttons/), if we listen to the `form submit event` and perform our desired action, 
the `submit button name/value` would be passed to the `action` handler.

>> Wait a second, I have to fire beacons with respect to the `submit button clicked`. How do I know which button was clicked? 

We can use `document.activeElement`.

`document.activeElement` returns the element which currently has the `focus`. While clicking the `submit button` we are also focusing it<sup>*</sup>.

But the form could be submitted by pressing the `enter` in the physical keyboard or the `Go` button in the soft keyboard. Then?

If the `form` have been submitted by pressing/tapping the `enter/Go`, i.e. `document.activeElement.type !== 'submit'`, we could asssume the `button clicked`, to be the `first submit button`.
or else the `button` that was clicked.

Refer the below example.

<p data-height="280" data-theme-id="0" data-slug-hash="fkjGH" data-default-tab="result" data-user="sarbbottam" class='codepen'>See the Pen <a href='http://codepen.io/sarbbottam/pen/fkjGH/'>greet-on-submit</a> by Sarbbottam Bandyopadhyay (<a href='http://codepen.io/sarbbottam'>@sarbbottam</a>) on <a href='http://codepen.io'>CodePen</a>.</p>

**Try the above example in a new tab/window in Chrome only.**
Hold on to your breath, prior trying it out in different browsers. 
I hear you about the browser compatibility. We will address it, please follow along.

Navigate to **devtools console**. 
You can see the `activeElemen`t is being logged and if the type is `submit` its `value` will also be logged.

{% highlight javascript %}
var submitForm = function(e) {
  e.preventDefault();
  e.stopPropagation();
  // which submit button is clicked
  var activeElement = document.activeElement;
  console.log(activeElement);
  if(activeElement.type === 'submit') {
    console.log(activeElement.value);
  }
  // some action, firing beacon with the value of the submit button
  greetingForm.submit();
};
{% endhighlight %}

So far, so good. Let's try it in iOS safari. Irrespective of the button clicked, `document.activeElement` always returns the `body` element.

>> What’s going on?

As stated earlier `document.activeElement` returns the element, which currently has the focus.
And in **iOS Safari** `button` never gets the focus, neither in **Chrome for iOS**. **FireFox/Mac** and **Safari/Mac** follow the same pattern.

<sup>*</sup>Please refer the [clicking and focus matrix](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/button#Clicking_and_focus) for further details.

**So technically we cant use this solution, for multiple submit buttons.**

### Cross browser solution

In my [earlier proposed solution](https://sarbbottam.github.io/forms/2014/10/27/tale-of-two-submit-buttons/#(previously)-proposed-solution-(not-optimal))  I used a `hidden field`. 
{% highlight html %}
<input type="hidden" id="proxy-submit-button">
{% endhighlight %}
Listen to the `click event` of each `submit buttons` *instead of the* `form submit event`.
In the event listener’s callback

* populate the value of the hidden field` with the value of the `clicked button` 
* `name` the hidden field as the name of the `submit button clicked`.
* submit the form via `form.submit()`

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


Please refer the below example.

<p data-height="280" data-theme-id="0" data-slug-hash="Biqzu" data-default-tab="result" data-user="sarbbottam" class='codepen'>See the Pen <a href='http://codepen.io/sarbbottam/pen/Biqzu/'>greeting-js-proper</a> by Sarbbottam Bandyopadhyay (<a href='http://codepen.io/sarbbottam'>@sarbbottam</a>) on <a href='http://codepen.io'>CodePen</a>.</p>

If for any reason JavaScript is not executed, the `proxy-submit-button name/value`will not be passed to the form `action` handler, as it does not have any `name`.
But the `name/value` of the `submit button clicked` will be passed to the form `action` handler.

If JavaScript is functional, then `proxy-submit-button`'s `name` and `value` will be updated, with respect to the `submit button` clicked, prior submitting the `form`.
And thus it would be part of the `serialized form data` and the `submit button` clicked will not be part of the `serialized form data`. 

*Pressing/tapping the `enter/Go`, triggers `click event` on the `first submit button` (the submit button that appears first in the DOM).*

**Note:**
If you are not carrying out any `button specific actions` but `generalized actions` you can listen to `form submit` instead of listening to individual `button click`.

An example of generalized action would be to **disable the submit buttons on form submit, in order to prevent multiple form submission**.

Please refer the below example for disabling the submit buttons and preventing multiple form submits.

<p data-height="280" data-theme-id="0" data-slug-hash="oXrmjv" data-default-tab="result" data-user="sarbbottam" class='codepen'>See the Pen <a href='http://codepen.io/sarbbottam/pen/oXrmjv/'>greet-on-submit-disable</a> by Sarbbottam Bandyopadhyay (<a href='http://codepen.io/sarbbottam'>@sarbbottam</a>) on <a href='http://codepen.io'>CodePen</a>.</p>

Something does not look right, the `submit button name/value` is not getting passed to the form action handler in the above example. Strange!!

>> What have we done other than disabling the submit buttons? 

That exactly what we have done. We have `disabled` the `submit buttons`. Any disabled `form fields name/value` will not be passed to the form action handler. 

>> How do we disable the submit button then?

Event loop to the rescue. We have to carry out disabling the submit button in a `setTimeout` callback, even a `0ms` would do good. `setTimeout` with `0ms` will push the `callback` to the end of the job queue and it will only be executed once the previous jobs have been out of the queue, i.e. the `form` has been `submitted`.

<p data-height="268" data-theme-id="0" data-slug-hash="waLNGe" data-default-tab="result" data-user="sarbbottam" class='codepen'>See the Pen <a href='http://codepen.io/sarbbottam/pen/waLNGe/'>greet-on-submit-disable-ok</a> by Sarbbottam Bandyopadhyay (<a href='http://codepen.io/sarbbottam'>@sarbbottam</a>) on <a href='http://codepen.io'>CodePen</a>.</p>

>> What if I want to perform specific actions with respect to the buttons clicked along with generalized actions on form submit? 

You better listen to `button click event` instead of the `form submit event`.

>> How about form validations?

Listen to the `form submit event` and carry out the validation followed by `form submit` on **successful validation**. 

>> But if there are multiple submit buttons? 

You need to ask yourself, if you really need `multiple submit buttons` on a form *with* `input fields`. 
Most likely you don’t, if there are `multiple input fields`. 
As stated earlier, it might lead to a confusing user experience. 

But if you really need it, you might have to listen to `button click event`.

---

This has been my expereinece and comprehension so far; it would be great to know if there are other aspects.
<script async src="//assets.codepen.io/assets/embed/ei.js"></script>