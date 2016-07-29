---
title: Telepathy Gabble
---

## Description

telepathy-gabble is a connection manager for the XMPP (Jabber) protocol. It uses [Wocky](/components/wocky) for implementing the XMPP protocol and [Telepathy GLib](/components/telepathy-glib) for implementing the Telepathy D-Bus API.

{{< component_overview name="telepathy-gabble" >}}

## XEP status in Gabble

{{< warning title="Warning" >}}
This list is incomplete and quite possibly out of date
{{< /warning >}}

All XEP are available at: [http://www.xmpp.org/extensions/](http://www.xmpp.org/extensions/)

* [XEP-0004](http://www.xmpp.org/extensions/xep-0004.html): Data Forms
      * Implemented, used internally for MUC configuration, registration, etc
* [XEP-0020](http://www.xmpp.org/extensions/xep-0020.html): Feature Negotiation
      * Implemented, used internally for stream initiation
* [XEP-0030](http://www.xmpp.org/extensions/xep-0030.html): Service Discovery (Disco)
      * Implemented, used for capabilities, MUC room listing, discovering components, server features, etc
* [XEP-0045](http://www.xmpp.org/extensions/xep-0045.html): Multi-User Chat (MUC)
      * Implemented, chat and room configuration, missing role support
* [XEP-0047](http://www.xmpp.org/extensions/xep-0047.html): In-Band Bytestreams (IBB)
      * Implemented, used by tubes
* [XEP-0054](http://www.xmpp.org/extensions/xep-0054.html): vcard-temp
      * Implemented, used for avatars and nicknames, contact info is WIP
* [XEP-0055](http://www.xmpp.org/extensions/xep-0055.html): Jabber Search
      * WIP
* [XEP-0060](http://www.xmpp.org/extensions/xep-0060.html): Publish-Subscribe
      * Implemented partially, used internally for PEP
* [XEP-0065](http://www.xmpp.org/extensions/xep-0065.html): SOCKS5 Bytstreams
      * Implemented partially, used by tubes, relay support is WIP
* [XEP-0077](http://www.xmpp.org/extensions/xep-0077.html): In-Band Registration
      * Implemented
* [XEP-0080](http://www.xmpp.org/extensions/xep-0080.html): User Location
      * WIP
* [XEP-0084](http://www.xmpp.org/extensions/xep-0084.html): User Avatar
      * Implemented
* [XEP-0085](http://www.xmpp.org/extensions/xep-0085.html): Chat State Notifications
      * Implemented
* [XEP-0095](http://www.xmpp.org/extensions/xep-0095.html): Stream Initiation
      * Implemented, used by tubes
* [XEP-0096](http://www.xmpp.org/extensions/xep-0096.html): File Transfer
      * WIP
* [XEP-0115](http://www.xmpp.org/extensions/xep-0115.html): Entity Capabilities
      * [Version 1.3 (legacy format)](http://www.xmpp.org/extensions/attic/xep-0115-1.3.html) implemented
      * Version 1.5 implemented
* [XEP-0128](http://www.xmpp.org/extensions/xep-0128.html): Service Discovery Extensions
      * Implemented, used internally for MUC room listing and configuration
* [XEP-0153](http://www.xmpp.org/extensions/xep-0153.html): vCard-based Avatars
      * Implemented
* [XEP-0163](http://www.xmpp.org/extensions/xep-0163.html): Personal Eventing via Pubsub
      * Implemented, used internally for nicknames, location, avatars, OLPC extensions, etc
* [XEP-0166](http://www.xmpp.org/extensions/xep-0166.html): Jingle
      * Implemented (mid-2007 and current drafts), used for audio/video calls
* [XEP-0167](http://www.xmpp.org/extensions/xep-0167.html): Jingle RTP Sessions
      * Implemented (mid-2007 and current drafts) implemented, used for audio/video calls
* [XEP-0172](http://www.xmpp.org/extensions/xep-0172.html): User Nickname
      * Implemented
* [XEP-0176](http://www.xmpp.org/extensions/xep-0176.html): Jingle ICE-UDP Transport
      * WIP
* [XEP-0177](http://www.xmpp.org/extensions/xep-0177.html): Jingle Raw-UDP Transport
      * WIP
* [XEP-0249](http://www.xmpp.org/extensions/xep-0249.html): Direct MUC Invitations
      * Implemented
* [XEP-0276](http://www.xmpp.org/extensions/xep-0276.html): Temporary Presence Sharing
      * Implemented, used automatically for audio/video calls

### Vendor Extensions

* Google Session (Voice and Video)
      * Similar to Jingle
* Google P2P Transport
      * Similar to ICE
* Google Jingle Info
      * STUN and relay server discovery
* Google Roster
      * For blocking
* Telepathy
      * Tubes
      * MUC bytestreams
      * SI multiple (for falling back between SI methods)
* OLPC
      * Buddy and Activity Info
      * Gadget (server component for indexing buddies and activities)
