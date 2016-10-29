---
title: Every image must have alt attribute
date: 2016-10-27 19:00:00
categories: Accessibility, HTML, Image
---

Every `<img>` must have an associated `alt` attribute.
The associated `alt` attribute must either have _meaningful content_ or be _empty_.

## Why `alt` attribute?

As the name suggests, it's purpose is to serve as an alternate text. For example, see the below:

![Terracotta artwork at Jor Bangla temple of Bishnupur, West Bengal, India](/does-not-exist)

Though the image is not displayed, the reader is aware of the purpose of the image, from the alternate text.

Screen reader also uses the same information and conveys it to the user.

![](/images/vo-captions/img-with-alt-text.png){: .center-block}

Without an alt text, if the image is not displayed, the purpose of the image will remain unknown.

<img src="/asdf1234ghjk.png"/>

Also, without an alt text, screen reader will read out the path of the image.

The above image is read out as ___/asdf1234ghjk.png, image___ by VoiceOver, which is meaningless.

![](/images/vo-captions/img-without-alt-text.png){: .center-block}

An empty alt attribute would have been a better choice, as screen readers would ignore it completely.

## When to use empty alt attribute?

Whenever there is adjacent text content conveying the content or intent of the image, use `alt=""`.

For example, profile images, adding the name of the profile as alt text, would just end up in redundant information.
[Less is more](https://www.google.com/#q=less+is+more), avoid redundant information.

_However, if there are images which have no relationship with the content,
but just for aesthetics, probably you want to use CSS background images._

>Where possible, decorative images should be provided using CSS background images instead.

## Furter reading

- [Decorative Images - WAI Web Accessibility Tutorials](https://www.w3.org/WAI/tutorials/images/decorative/)
- [WebAIM: Alternative Text](http://webaim.org/techniques/alttext/)
