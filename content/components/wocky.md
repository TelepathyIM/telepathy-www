---
title: Wocky
---

## Description

Wocky is the XMPP library used by telepathy-gabble (the regular XMPP backend) and telepathy-salut (the iChat-compatible link-local XMPP backend as specified in [XEP-0174](http://xmpp.org/extensions/xep-0174.html)). It uses GObject, GIO, libxml2, plus your choice of [GnuTLS](http://www.gnutls.org/) or [OpenSSL](http://www.openssl.org/).

{{< component_overview name="wocky" >}}

{{< note title="Note" >}}
At present, Wocky does not receive its own independent releases. It is included as a Git submodule in the Gabble and Salut repositories, and is distributed as part of their releases.
{{< /note >}}

## Supported features, amongst others

* Jingle ([XEP-0166](http://xmpp.org/extensions/xep-0166.html), [XEP-0167](http://xmpp.org/extensions/xep-0167.html), [XEP-0176](http://xmpp.org/extensions/xep-0176.html), [XEP-0177](http://xmpp.org/extensions/xep-0177.html))
* Data Forms ([XEP-0004](http://xmpp.org/extensions/xep-0004.html))
* Multi-User Chat ([XEP-0045](http://xmpp.org/extensions/xep-0045.html))
* PEP ([XEP-0163](http://xmpp.org/extensions/xep-0163.html)) and certain other parts of PubSub ([XEP-0060](http://xmpp.org/extensions/xep-0060.html))
* HTTP CONNECT proxies
* Pluggable SASL authentication
