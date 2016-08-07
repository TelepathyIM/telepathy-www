---
title: Developing with Telepathy
categories: ["guides"]
---

Welcome to Telepathy! So, you want to develop some application with real-time communication and/or collaboration features or provide a protocol backend? Great! Read on...

## Getting started

First of all, start by reading the [Telepathy Developer's Manual](http://telepathy.freedesktop.org/doc/book). This document will get you acquainted with the basic concepts of Telepathy and show you some examples of how to use the API.

At the same time, it is useful for you to look at the [Telepathy D-Bus API Specification](http://telepathy.freedesktop.org/spec) to understand how the concepts map to API and discover interesting details!

## Choose your library

Telepathy is a D-Bus API, but because using D-Bus directly is kind of hard (especially with such heavy use of it that Telepathy requires), there are convenience high-level libraries available for you to work with:

* [Telepathy GLib](/components/telepathy-glib) (C, Glib/GObject-based API)
* [Telepathy Qt](/components/telepathy-qt) (C++, Qt-based API, compatible with Qt4 and Qt5)

The [API Documentation](/documentation) of these libraries will help you get acquainted and start using them.

## I don't want to use C or C++, can I use a modern language instead?

In many cases, yes, you can. Telepathy GLib can be used from many other languages (mostly scripting ones) via [GObject Introspection](https://wiki.gnome.org/Projects/GObjectIntrospection). Here is a list of [languages](https://wiki.gnome.org/Projects/GObjectIntrospection/Users) that you can use this with.

## Further information

Working on an application does not require you to build Telepathy from source. You can use packages from your distribution. If you, however, wish to build things from source, take a look at our **[setup](/resources/setup)** tutorial.

While developing, you will probably find it useful to know how to **[debug](/resources/debugging)** Telepathy.

If you wish to contribute your code to the Telepathy project upstream, then you should also read our **[contributing](/resources/contributing)** guide.

You can also find more information, tutorials, guides, etc, in our **[resources](/resources)** section.

## What next?

Join our [mailing list](/community/mailing_list) and [IRC channel](/community/chat) and get in touch with us. Let us know what you are developing and ask us any questions that you might have.
