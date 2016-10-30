---
title: "text-overflow:ellipsis - Is it worth using?"
date: 2016-10-29 23:00:00
categories: Accessibility, HTML, CSS, JavaScript
image: /images/posts/ellipsis.png
---

>Ellipsis is a series of dots that usually indicates an intentional omission of a word,
sentence, or whole section from a text without altering its original meaning. _- [Wikipedia](https://en.wikipedia.org/wiki/Ellipsis)_

The usage of ellipsis dates back to 16th century, as suggested by Anne Toner in her book,
[Ellipsis in English Literature: Signs of Omission](https://www.amazon.com/Ellipsis-English-Literature-Signs-Omission/dp/1107073014).

In print media, usage of ellipsis has been deliberate and deterministic, _without altering its original meaning_.
But that's not true for web media. With `text-overflow: ellipsis` style, the author does not have any control over the appearance of the `...`.
It depends on the available width of the container, at the time of rendering.

And the currently rendered content with `...` might or might not make sense to the reader.

Consider the following sentence, the truncation will depend on your device width.
<style>
  .sukumar {
    font-style: italic;
    background: #198fff;
    color: #fff;
    padding: 10px;
    width: 100%;
  }
  .truncate {
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }
</style>
<p class="truncate sukumar">
Sukumar Ray was an Indian Bengali humorous poet, story writer and playwright who mainly wrote for children.
His works such as the collection of poems "Aboltabol", novella "HaJaBaRaLa", short story collection "Pagla Dashu" and play "Chalachittachanchari" are considered equal in stature to Alice in Wonderland.
More than 80 years after his death, Ray remains one of the most popular of children's writers in both West Bengal and Bangladesh.
</p>

One can argue, that on `:hover` the complete content can be displayed as a tooltip or overlay.
And for screen reader users, the complete text is available, as it only visually truncated.

Fair enough, but still there are couple of concerns:
* How does the user know that they need to `:hover`?
* What about touch interface, there is no notion of `:hover`?
* What about keyboard only user?

***How do we make the information available for all?***

I don't know, I have seen a couple of implementation but ... (that's an intentional ellipsis).

## Implementation - I

* attach a click handler to the ellipsis-fied container
* add tabindex=0, so that it can be focused via `tab` press
* listen to `space`/`enter` press and invoke the click handler

_Consider the following example:_

<p class="sukumar truncate" id="implementation-one">
Sukumar Ray was an Indian Bengali humorous poet, story writer and playwright who mainly wrote for children.
His works such as the collection of poems "Aboltabol", novella "HaJaBaRaLa", short story collection "Pagla Dashu" and play "Chalachittachanchari" are considered equal in stature to Alice in Wonderland.
More than 80 years after his death, Ray remains one of the most popular of children's writers in both West Bengal and Bangladesh.
</p>

* Does it make sense to make a text content focusable?
* Isn't a focusable textual content confusing for a screen reader user?
* Is it a known pattern, that a user would `click` when they see '...'

## Implementation - II

* let there be a dedicated "See more" button
* toggle the truncation when "See more" is interacted

_Consider the following example:_

<p class="sukumar truncate" id="implementation-two">
Sukumar Ray was an Indian Bengali humorous poet, story writer and playwright who mainly wrote for children.
His works such as the collection of poems "Aboltabol", novella "HaJaBaRaLa", short story collection "Pagla Dashu" and play "Chalachittachanchari" are considered equal in stature to Alice in Wonderland.
More than 80 years after his death, Ray remains one of the most popular of children's writers in both West Bengal and Bangladesh.
</p>
<style>
button {
  background: none;
  border: none;
  font: inherit;
  color: #198fff;
  cursor: pointer;
}
</style>
<button id="see-more">See More</button>

* Is the "See more" button confusing for screen reader user?
* What purpose is it serving for screen reader user? The complete text was already available to them.

## Conclusion

I would stay away from `text-overflow:ellipsis` till I find a better solution.

<script>
var implementationOne = document.getElementById('implementation-one');
var implementationTwo = document.getElementById('implementation-two');
var seeMore = document.getElementById('see-more');

function toggleTruncation(node) {
  node.classList.toggle('truncate')
}

implementationOne.addEventListener('click', function(e) {
  toggleTruncation(this);
});

implementationOne.addEventListener('keypress', function(e) {
  if (e.keyCode === 32 || e.keyCode === 13) {
    toggleTruncation(this);
  }
});

seeMore.addEventListener('click', function(e) {
  if (implementationTwo.classList.contains('truncate')) {
    this.innerHTML = "See less"
  } else {
    this.innerHTML = "See more"
  }
  toggleTruncation(implementationTwo);
});
</script>
