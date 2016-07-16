---
title: "About Telepathy"
weight: 10
---

Telepathy is a flexible, modular communications framework for desktop and mobile devices that enables real-time communication via pluggable protocol backends. Telepathy is a **communications service** that can be accessed by many applications ("clients") simultaneously. This allows any application to access presence information, request a communication channel (potentially handled by another client), or provide collaboration features contact-to-contact.

<center>![Telepathy Architecture Overview](/TelepathyArchitectureOverview.png)</center>

## Multiple protocols

Telepathy provides protocol backends for the most popular protocols, including: Jabber/XMPP/Jingle, link-local XMPP, SIP and IRC via a unified [D-Bus](http://dbus.freedesktop.org) API. It also provides convenience libraries for GLib and Qt to simplify using the API from applications.

*See the full [list of supported protocols](/about/supported_protocols)*

## Multiple capabilities

Telepathy exposes the available real-time communications capabilities of each protocol and allows applications to deal with only the part that they are interested in.

### Presence

Applications can see your online status or change it.

### Contact rosters

Your contacts are made available to applications.

### Messages

Applications can send or receive any kind of messages over any protocol.

### Voice/video calls

Applications can easily integrate calls with voice and/or video content and more, depending on the application's needs.

### File transfers

File transfers between friends are made easy for applications.

### Telepathy Tubes

Tubes are contact-to-contact networking. Tubes enable one-to-one, one-to-many or many-to-many communication between contacts using either network sockets (stream tubes) or a private D-Bus bus (D-Bus tubes). This allows applications to support collaboration between users, with a minimal amount of effort on the part of both application developers and the end-user. Application developers can focus on their application protocols, without having to worry about networking, firewall traversal or service discovery. End users no longer have to configure collaboration accounts, share IP addresses or forward ports on their firewalls.

## Modularity

Telepathy is **modular**. Each backend and client runs in a separate process, allowing for much greater security and resilience. It is suitable both for embedded and desktop environments.

*Why does Telepathy take a modular approach to real time communications?*

* **Robustness**: one component can crash without crashing others
* **Ease of development**: components can be replaced within a running system; tools like dbus-inspector can trace interactions between components
* **Language independence**: components can be written in any language that has a D-Bus binding; if the best free implementation of the Oscar (AOL) protocol is in Java, you can write your Oscar connection manager in Java to take advantage of that
* **Desktop independence**: D-Bus has been adopted as an IPC mechanism by both GNOME and KDE
* **License independence**: components can be under different licenses that would be incompatible if all components were running in one process
* **Code reuse**: Telepathy allows clients to ignore protocol details as much as possible, easing transitions between different communications systems
* **Connection reuse**: multiple Telepathy components can use the same connection simultaneously
* **Security**: components can run with very limited privileges; a typical connection manager only needs access to the network and to the D-Bus bus, making it possible for an SELinux policy to prevent protocol code from e.g. accessing the disk
