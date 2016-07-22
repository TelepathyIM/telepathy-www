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
