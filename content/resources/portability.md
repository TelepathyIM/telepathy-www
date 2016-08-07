---
title: Portability Guidelines
categories: ["information"]
---

This page lists some known caveats that you should keep in mind when writing Telepathy code, in order to keep things portable.

**Reviewers, please pay special attention to these.**

## Compilers

* MSVC doesn't like declaration after statement (a C99 feature); use -Wdeclaration-after-statement to track down such issues.

* C99 named initializers are also not supported by MSVC.

* GNU-style variadic macros with "foo..." don't work on Windows; ISO-style with **VA_ARGS** do.

        /* bad */
        #define DEBUG(f...) g_debug (f)
        /* good */
        #define DEBUG(f, ...) g_debug (f , ## __VA_ARGS__)

* MSVC doesn't like empty structs, which are a GNU extension.

        /* bad */
        struct foo {};
        /* acceptable */
        struct foo { int dummy; }
        /* better still is to not define struct foo at all, until it contains something :-) */

## C library

* unistd.h is not universal: check for it in configure.ac, and guard the #include with #ifdef HAVE_UNISTD_H. Similarly sys/socket.h, sys/un.h, netdb.h, arpa/nameser.h, netinet/in.h, resolv.h.
* Windows has winsock2.h, ws2tcpip.h, Windows.h, Winbase.h, Windns.h which are (obviously) not universal either.
* localtime_r and strptime aren't very portable. Consider using g_timeval_{to,from}_iso8601 if possible.

## OS features

* Only Unix (G_OS_UNIX) has Unix sockets.
* Credentials passing in Unix sockets is different on different OSs; we only support it on Linux, and this will remain the case until a BSD, Solaris etc. guru tells us how it works on their OS :-)

## Windows porting suggestions

* When you include winsock2.h, undefine interface and ERROR keywords. Include winsock2.h in this manner:

        #ifdef HAVE_WINSOCK2_H
        #include <winsock2.h>
        #undef interface
        #undef ERROR
        #endif

* _fcntl_ and _ioctl_ methods are not found on windows by default, one workaround is to do AC_DEFINE(fcntl,ioctlsocket) and AC_DEFINE(ioctl,ioctlsocket) for windows in configure.ac.

_This wouldn't get past code review from me. We should be clear about what's a socket and what's a libc file descriptor (because they're distinct on Windows), and conditionally use either ioctl or ioctlsocket, etc., in some sort of portability-utilities file. -smcv_

* what also is needed is to define parameters as corresponding ioctlsocket parameters like: F_SETFL as FIONBIO and O_NONBLOCK as 1

_This wouldn't get past code review from me either: we should have a wrapper function like `gabble_socket_set_noblocking()` that invokes either fcntl or fcntlsocket as appropriate for Windows or Unix, rather than pretending that fcntl is portable and trying to hack around the fact that it actually isn't. See GLib and libdbus, with their *-sysdeps-{unix,windows}.c. -smcv_
