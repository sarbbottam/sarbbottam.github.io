---
title: "Raspbian, Apple Bluetooth Keyboard and Trackpad"
date: 2018-06-10 01:00:00
categories: Raspbian, RPi, Bluetooth, Apple Keyboard, Apple Trackpad
image: /images/posts/rpi-bluetooth.png
---

I started with [this post](https://thepihut.com/blogs/raspberry-pi-tutorials/17841464-bluetooth-installing-and-using-bluetooth-on-the-raspberry-pi) and was able to connect the Apple Bluetooth Trackpad but not the Apple Bluetooth Keyboard.

And as part of the steps I have updated the system and installed the bluetooth related utilities.

```
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install bluetooth blueman bluez python-gobject python-gobject-2
```

Then I came across [Connect Apple Wireless Keyboard to Raspbian (Jessie)](https://www.rickwargo.com/2016/03/09/connect-apple-wireless-keyboard-to-raspbian-jessie/) and it guided me guided to the success pairing of Apple Bluetooth Keyboard and  Bluetooth Trackpad.

All I need to do for every RPi start/restart is to restart the apple wireless keyboard, and it automatically gets connected.

I am using [this bluetooth dongle](https://www.amazon.com/gp/product/B009ZIILLI/ref=oh_aui_detailpage_o00_s00?ie=UTF8&psc=1)
