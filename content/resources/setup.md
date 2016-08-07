---
title: Setting up
categories: ["tutorials"]
---

## Overview

Telepathy consists of multiple components that need to be compiled and installed separately in a certain order. Initially you should start by compiling and installing telepathy-glib, then continue with mission-control and any glib-based connection managers that you need, such as telepathy-gabble (highly recommended), telepathy-haze, etc... On the Qt side, you should first compile and install telepathy-qt and then continue with any qt-based components.

## GLib-based components (autotools)

All the GLib-based components at the moment use the autotools build system. The compilation and installation procedure for them is the same.

In this example, we are going to compile telepathy-glib:

```
PREFIX=$HOME/telepathy
git clone git://anongit.freedesktop.org/telepathy/telepathy-glib
cd telepathy-glib
./autogen.sh --prefix=$PREFIX
make
make install  # optional, to install the binaries and headers in $PREFIX
```

Obviously, `PREFIX` can be set to another path in your system.

### Finding libraries when building other components

After building telepathy-glib and/or telepathy-qt, other components will need to be able to find their binaries and headers. This can be achieved by exporting the `PKG_CONFIG_PATH` environment variable to point to the path where the pkgconfig (.pc) files of the libraries are installed.

For example, assuming that you have installed telepathy-glib in `$HOME/telepathy` as in the above instructions, here is how to compile telepathy-gabble with it:

```
PREFIX=$HOME/telepathy
git clone git://anongit.freedesktop.org/telepathy/telepathy-gabble
cd telepathy-gabble
PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig ./autogen.sh --prefix=$PREFIX
make
make install   # optional, to install the binaries in $PREFIX
```

## Qt-based components (CMake)

All the Qt-based components at the moment use the CMake build system. The compilation and installation procedure for them is the same.

```
PREFIX=$HOME/telepathy
git clone git://anongit.freedesktop.org/telepathy/telepathy-qt
cd telepathy-qt
mkdir build
cd build
PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig cmake .. -DCMAKE_INSTALL_PREFIX=$PREFIX
make
make install   # optional, to install the binaries and headers in $PREFIX
```

The `PKG_CONFIG_PATH` environment variable here is exported in order for telepathy-qt to be able to find telepathy-glib, which is an optional (but recommended) dependency for building some unit tests.

## Running unit tests

After having built a component with the `make` command, you can run its unit tests by executing `make check`. This will run all the automatic unit tests and will report their status on the output.

## Which components should I build?

That depends on what you want, but you should probably at least build the following:

* [Telepathy GLib](/components/telepathy-glib), required as a dependency for Mission Control
* [Mission Control](/components/telepathy-mission-control), the Account Manager and Channel Dispatcher, which is necessary to start any connection or channel
* [Telepathy Gabble](/components/telepathy-gabble), the XMPP connection manager, which also doubles as the reference CM to test things with
* A client... [Empathy](http://live.gnome.org/Empathy) / [KDE-Telepathy](http://community.kde.org/KTp) / yours...

### Nice to have

* [Telepathy Logger](/components/telepathy-logger), for logging messages and events
* [Telepathy Haze](/components/telepathy-haze), for supporting many protocols that are implemented in libpurple (pidgin/adium)
* Other connection managers...

## Running from a non-system prefix

Telepathy components are normally launched by the D-Bus daemon when their well-known address is requested on the bus. This is implemented by adding D-Bus .service files in the dbus services directory that tell D-Bus how to launch the necessary component, given an address. This directory is normally `$PREFIX/share/dbus-1/services`

For example, telepathy-gabble has the well-known address `org.freedesktop.Telepathy.ConnectionManager.gabble` and therefore installs the file `$PREFIX/share/dbus-1/services/org.freedesktop.Telepathy.ConnectionManager.gabble.service` that contains an `Exec=` line pointing to the path of the telepathy-gabble executable.

The D-Bus daemon, by default, looks for these files in `$XDG_DATA_DIRS/dbus-1/services`, where `$XDG_DATA_DIRS` is a directory list, like `$PATH` that defaults to `/usr/share:/usr/local/share`.  As you can understand, in order for your D-Bus daemon to find the .service files that you just installed from source, either your `$PREFIX` must be `/usr` or `/usr/local`, or you need to change `$XDG_DATA_DIRS` to look like `$PREFIX/share:/usr/share:/usr/local/share`.

However, both of these methods are usually undesirable. Changing `$XDG_DATA_DIRS` must happen before your desktop session starts and it's quite tricky to achieve, and installing in /usr or /usr/local is often undesirable because it requires root and messes up with your system.

### The solution

The solution is to run an isolated dbus-daemon for your telepathy. The following script can achive this for you:

```
#!/bin/bash

export PREFIX=$HOME/telepathy/install
export PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
export LD_LIBRARY_PATH=$PREFIX/lib:$PREFIX/lib/x86_64-linux-gnu
export PATH=$PREFIX/bin:$PATH

export XDG_DATA_DIRS=$PREFIX/share:/usr/share:/usr/local/share
export QT_PLUGIN_PATH=$PREFIX/lib/x86_64-linux-gnu/plugins:/usr/lib/x86_64-linux-gnu/qt5/plugins/

dbus-launch --sh-syntax --exit-with-session /bin/bash

# cleanup - --exit-with-session waits for SIGHUP to quit dbus-daemon
DBUS_LAUNCH_PID=`ps | grep dbus-launch | cut -d' ' -f1`
kill -HUP $DBUS_LAUNCH_PID

```

Running the above script will launch a shell with an independent dbus session, where you can start telepathy clients and work with them. You could also replace `/bin/bash` in the `dbus-launch` command line directly with a client, like `ktp-contactlist` or `empathy` if you prefer to launch the client directly instead of dropping in a shell.
