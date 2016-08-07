---
title: Debugging
categories: ["information"]
---

## If you are using Empathy or KDE-Telepathy...

Empathy and KDE-Telepathy both have debug consoles which show you the debug output from components of your choice. Refer to the [Empathy wiki](http://live.gnome.org/Empathy/Debugging) and the [KDE Community wiki](https://community.kde.org/KTp/FAQ#Providing_debug) respectively for more details.

If you're not using one of these clients, or you're debugging a crash, or you're just feeling old-school, read on!

## Connection managers

Many Telepathy problems are not directly the fault of the user interface (such as Empathy), but of the connection managers (Gabble, Idle, Salut, Rakia, ...), which are the services responsible for actually connecting to your IM accounts. CMs generally run in the background, with no visible output; in order to get debugging output from them, you'll need to run them manually.

Connection manager executables don't generally live in your `$PATH`, so you'll need to provide the full path in the following commands (rather than just `telepathy-foo`) to invoke them.

* on Fedora-like systems, connection managers live in `/usr/libexec/`
* on Debian-like systems connection managers live in `/usr/lib/telepathy/`
* if you have installed from source, the default location is `/usr/local/libexec/`

## Obtaining logs

First, quit your IM client (such as Empathy), and wait a few seconds for the connection managers to quit of their own accord. Then, in a terminal, run:

    G_MESSAGES_DEBUG=all FOO_PERSIST=1 FOO_DEBUG=all /path/to/telepathy-foo 2>&1 | tee foo.log

where `foo` should be the name of the relevant CM for the protocol you're having trouble with, as listed on [components](/components). For example, `gabble` for [telepathy-gabble](/components/telepathy-gabble) or `haze` for [telepathy-haze](/components/telepathy-haze).

As an example, this is how you would obtain logs from [telepathy-gabble](/components/telepathy-gabble) on a Debian-based system:

    G_MESSAGES_DEBUG=all GABBLE_PERSIST=1 GABBLE_DEBUG=all /usr/lib/telepathy/telepathy-gabble 2>&1 | tee gabble.log

Now, start your IM client again, and reproduce the problem; debugging output should appear in your terminal, and be written to `foo.log`. You can set the `_DEBUG` variable to values other than `all` if you only want the debugging output from a certain part of the CM, but usually this is unnecessary.

If the connection manager complains about "name already or use" and quits immediately, you should `kill` any existing instances of it and try again.

### Wocky (Gabble / Salut)

When debugging a CM that uses [Wocky](/components/wocky) (Gabble or Salut basically), it's usually a good idea to set `WOCKY_DEBUG=xmpp` so that the XML stanzas are also captured in the logfile.

If you actually want to debug Wocky rather than the CM, set `WOCKY_DEBUG=all`

### Mission Control

As an exception, [telepathy-mission-control](/components/telepathy-mission-control) uses `MC_DEBUG` as its debug environment variable and *doesn't* have an `MC_PERSIST` variable, simply because it does not exit automatically when it doesn't have anything to do. For this reason, it is also required to kill it in addition to going offline before starting it on the command line. For example:

    killall mission-control-5
    G_MESSAGES_DEBUG=all MC_DEBUG=all /usr/lib/telepathy/mission-control-5 2>&1 | tee mc.log


## Debugging connectivity issues on XMPP / SIP

If you're having difficulty connecting to a SIP or Jabber/XMPP server and you're using Linux, you can check whether SRV DNS lookups are broken on your network using the `host` command-line tool.

For example, Collabora's XMPP server has a SRV record which you can use to try this out, by running:

`host -t SRV _xmpp-client._tcp.collabora.co.uk`

If it works correctly, you'll see something like this:

`_xmpp-client._tcp.collabora.co.uk has SRV record 0 0 5222 xmpp.collabora.co.uk.`

If SRV lookups don't work on your network you might see an error like this, for instance:

`Host _xmpp-client._tcp.collabora.co.uk not found: 3(NXDOMAIN)`

In order to fix this, you can force your connection to use a different DNS server than the one provided by your DHCP server (in your router). OpenDNS or Google's `8.8.8.8` should work fine.


## Debugging crashes


### General

If you are experiencing crashes, it's a good idea to install any Telepathy debug packages provided by your distribution.

For example, on Debian-like systems, debugging packages related to `telepathy-gabble` include:

* libtelepathy-glib0-dbg
* libtelepathy-dbg
* telepathy-gabble-dbg

### GDB

You might be able to obtain debug information using gdb (for connection managers, you probably also want to use the `FOO_PERSIST` variable for this):

    $ GABBLE_PERSIST=1 gdb /usr/lib/telepathy/telepathy-gabble
    GNU gdb 6.7.1-debian
    Copyright (C) 2007 Free Software Foundation, Inc.
    License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
    This is free software: you are free to change and redistribute it.
    There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
    and "show warranty" for details.
    This GDB was configured as "i486-linux-gnu"...
    Using host libthread_db library "/lib/i686/cmov/libthread_db.so.1".
    (gdb) r
    Starting program: /usr/lib/telepathy/telepathy-gabble
    ** (telepathy-gabble:17666): DEBUG: started version 0.6.0 (telepathy-glib version 0.7.0)

If the program crashes while running under gdb, use the "bt" command to obtain a backtrace.

If you can't make it crash while running under gdb (this is not an uncommon state of affairs, for reasons I won't go into here):

1. make sure core dumps are enabled
   * `ulimit -c unlimited`
1. launch the telepathy component in question (as above)
   * `FOO_PERSIST=1 FOO_DEBUG=all /path/to/telepathy-foo 2>&1 | tee foo.log`
1. do whatever it is you do to produce a crash
1. inspect the core file (it's normally called "core", saved in your current working directory)
   * `gdb /path/to/telepathy-foo core`
   * at the gdb prompt: `bt full`

{{% note title="Note" %}}
If you are running more than one component to debug, either run them in different directories so their core files don't overwrite one another in the event of a crash,  or `sudo sysctl -w kernel.core_uses_pid=1` to make the core file name contain the PID
{{%/ note %}}

### Valgrind

Valgrind can find many bugs.

* [Valgrind home page](http://valgrind.org/)
* [suppression file](https://cgit.freedesktop.org/telepathy/telepathy-glib/tree/tools/telepathy-glib.supp) to stop it complaining about glibc and glib oddities.

### Electric Fence

Electric Fence can find some memory allocation bugs.

To use it, run programs with LD_PRELOAD=/usr/lib/libefence.so.0.0.

* [Electric Fence home page](http://perens.com/FreeSoftware/)
