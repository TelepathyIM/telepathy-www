---
title: Coding Style
categories: ["policies"]
---

This coding style is (or should be) used for all the core Telepathy components.

These are _guidelines only_ ; there are always exceptional circumstances. Consistency and readability are usually the most important considerations.

## Generic

### Filenames

* Don't put a common prefix on all files in a project - we like our tab completion to work. `<telepathy-glib/connection.h>` is good, `<telepathy-glib/tp-connection.h>` would be bad.
* If you're writing a library where headers will be included like `<foo/bar.h>`, put the headers (and probably the corresponding sources) in a directory called `foo` (probably top-level).
   * This way the library and its examples/tests can be compiled with `-I$(top_srcdir) -I$(top_builddir)` (or possibly `-I$(top_srcdir)/src -I$(top_builddir)/src` or something) and use `#include <foo/bar.h>` throughout, so that examples in the source tree have the same source code that they'd need in a third-party project.
* Code generation tools typically go in `./tools`
* autoconf macros usually go in `./m4`. This requires `AC_CONFIG_MACRO_DIR([m4])` in `configure.ac` **and** `ACLOCAL_AMFLAGS = -I m4` in the top-level `Makefile.am` (use both).

### `#include`s

If you're going to `#include "config.h"`, do that first, in case it defines things like `inline` or `_GNU_SOURCE`.

Next, `#include` the header in which this .c / .cpp file's API is declared. This guarantees that all public headers are self-contained.

Next, `#define` any extra libc feature-test macros you need (`_GNU_SOURCE` etc.) and `#include` any C/POSIX standard library headers you need, in alphabetical order.

Next, `#include` any headers you need from non-standard libraries (GLib, Gtk, telepathy-glib, Avahi, ...) in alphabetical order.

Finally, `#include` any private (non-installed) headers from the library or program you're writing.

For example:

    /* Example 1: foo.c
     * ... insert copyright etc. here ...
     */
    #include "config.h"

    #include "foo.h"

    #ifndef _POSIX_C_SOURCE
    #define _POSIX_C_SOURCE 200112L /* for posix_memalign */
    #endif
    #include <stdlib.h>
    #include <string.h>
    #include <sys/types.h>

    #include <avahi-common/address.h>
    #include <glib-object.h>
    #include <telepathy-glib/bar.h>

    #define DEBUG_FLAG DEBUG_FOO
    #include "bar.h"
    #include "debug.h"
    #include "foobar.h"

Try to avoid using non-standard functions that need feature test macros - I've just used `posix_memalign` here for the sake of an example.


## C code using GLib/GObject

### Layout

* Indentation is GNU-style:

            /* Example 2 */
            while (foo)
             {
               if (badger != NULL)
                 bar ();

               if (mushroom != NULL)
                 {
                   do_stuff ();
                 }
               else
                 {
                   do_more_stuff ();
                   do_yet_more_stuff ();
                 }
             }

* Function _declarations_ (with `;` at the end) are in the style:

        /* Example 3 */
        static void badger_mushroom (Mushroom *self,
            const gchar *reason,
            gint another_param,
            ...,
            gpointer omg_so_many_params);

    <br/> but function _definitions_ (i.e. implementations, with `{}` and code) are in the style:

        /* Example 4 */
        static void
        badger_mushroom (Mushroom *self,
            const gchar *reason,
            gint another_param,
            ...,
            gpointer omg_so_many_params)
        {
          ...
        }

{{% note title="Rationale" %}}
That way you can grep for ^function_name and you'll only find the definition, without any clutter caused by declarations
{{%/ note %}}

* Function calls have a space after the function name.

* Long lines (>79 chars) should be wrapped with a four-space indent and line-breaks between arguments in any sensible place, like this:

        /* Example 5 */
        static void
        do_some_stuff (Mushroom *self)
        {
          do_some_other_stuff (self, 123, 42, TP_TYPE_MUSHROOM,
              OTHER_STUFF_ADD_BADGERS | OTHER_STUFF_NO_SNAKES,
              "this example has too many parameters",
              CARROTS | HANDBAGS | CHEESE,
              TABLET, BRICK, POTATO, LLAMA);
        }

{{% warning title="Exception" %}}
Definitions (but not declarations) have exactly one parameter per line, with second and subsequent lines indented to match first line, like Example 4
{{%/ warning %}}

* Pairs or triples of arguments (as seen in g_object_new, g_object_get, tp_value_array_unpack etc.) should always be one pair/triple to a line, even if the line is short enough to fit more:

        m = g_object_new (G_TYPE_MUSHROOM,
            "species", "Badger Agaric",
            "flags", SPOTTED | POISONOUS,
            NULL);

    <br/> even if the number of pairs in a particular invocation is zero:

        m = g_object_new (G_TYPE_MUSHROOM,
            NULL);

### configure.ac

Use AS_IF and AS_CASE instead of shell conditionals:

    # don't do this...
    if test "x$with_badgers" = "xyes"; then
        AC_MSG_NOTICE([Badgers enabled])
    else
        AC_MSG_NOTICE([Badgers not enabled])
    fi
    case "x$with_mushrooms" in
        (*poison*)
            AC_MSG_ERROR([Poisonous mushrooms selected])
            ;;
        (*magic*|*hallucinogen*)
            AC_MSG_WARN([Hallucinogenic mushrooms selected])
            ;;
        (*)
            AC_MSG_NOTICE([Ordinary mushrooms selected])
            ;;
    esac

    # ... do this instead (in this case it's equivalent, but
    # the difference matters in more complicated situations)
    AS_IF([test "x$with_badgers" = "xyes"],
        [echo "with badgers"],
        [echo "without badgers"])
    AS_CASE(["x$with_mushrooms"],
        [*poison*],
            [AC_MSG_ERROR([Poisonous mushrooms selected])]
        [*magic*|*hallucinogen*],
            [AC_MSG_WARN([Hallucinogenic mushrooms selected])]
        [*],
            [AC_MSG_NOTICE([Ordinary mushrooms selected])])

See <https://bugzilla.gnome.org/show_bug.cgi?id=681413> for more info.

### Makefiles (including Automake Makefile.am)

List include directories (`CFLAGS`/`CPPFLAGS`) and libraries (`LDADD`/`LIBS`) in stack order, with lowest in the stack first (so one can link against highest in the stack somewhere else without picking up everything from the somewhere else). (This guideline was borrowed from gstreamer.)

As an exception, any libraries or `CFLAGS` within the same source tree (e.g. `-I$(top_srcdir)`) must come before external `CFLAGS`. This is necessary to compile against uninstalled libraries correctly, if they have directories that conflict with directories in your project (e.g. Gabble and telepathy-glib both have `/extensions`), and to prefer linking against the library you just compiled instead of a system-wide copy.

    # Example 6
    AM_CFLAGS = \
        -I$(top_srcdir) -I$(top_builddir) \
        -I$(top_srcdir)/src \
        $(DBUS_CFLAGS) \
        $(GLIB_CFLAGS) \
        $(DBUS_GLIB_CFLAGS) \
        $(TP_GLIB_CFLAGS)

    something_LDADD = \
        $(top_builddir)/src/libmiscutils.la \
        $(DBUS_LIBS) \
        $(GLIB_LIBS) \
        $(DBUS_GLIB_LIBS) \
        $(TP_GLIB_LIBS)

### Misc

* Use glib types for preference.
* Pointer types look like `Type *variable`, not `Type* variable`, so that the whitespace suggests the correct C precedence: `int *foo, bar;` and `int bar, *foo` and `int* foo, bar` all declare `foo` to be an `int *`, and `bar` to be an `int`.
* Don't declare variables of type `int` and `int *`, or `gchar *` and `gchar **`, or similar, in the same declaration: it's possible but needlessly confusing.
* Casts look like this:

        Fungus *fungus;
        Mushroom *mushroom;

        mushroom = MUSHROOM (fungus);
        /* or if there's no suitable asserting macro or if the cast is from
         * a subclass to a superclass, */
        mushroom = (Mushroom *) fungus;

* Use `gchar *` for strings that should be freed with `g_free`, but `char *` for strings that should be freed with something else, such as libc `free` or `avahi_free`.
* Use the `G_GNUC_*` function annotations where possible.
* Use GSlice allocation for non-GObjects where possible.
* Use `g_set_error` instead of `g_error_new` where possible.
* Never use explicit comparisons with `TRUE` and `FALSE` for booleans - if have_value is a `gboolean`, use `if (have_value)` instead of `if (have_value == TRUE)`.
* Always use explicit comparisons for non-boolean integers and for pointers - if `i` is an integer and `p` is a pointer, use `if (i != 0)` instead of `if (i)`, and `if (p != NULL)` instead of `if (p)`.

### Telepathy-GLib specific rules

Those policies have been discussed on bug [#39189](https://bugs.freedesktop.org/show_bug.cgi?id=39189). Those are not global rules we want to apply on all our projects, but rather a compromise given the history of existing telepathy-glib API. They could change in a distant future if we decide it is important to be threadsafe (maybe after porting to gdbus).

#### Transfer policy

* tp_foo_get_bar() must return the internal pointer/value. No copy is made.
* tp_foo_dup_bar() must return a new ref or deep-copy.
* tp_foo_borrow_bar() should not be used.
* tp_foo_bar_finish() must return a new ref or deep-copy return value and out args.
* Since _finish() returns a copy, tp_foo_dup_bar_async() should be prefered over tp_foo_get_bar_async().

#### Container policy

telepathy-glib uses either GList or GPtrArray, it is left to developer's choice. The most important to keep in mind is to use the most convenient format given the existing APIs. For example it is preferable to return a set of contacts as a GPtrArray because tp_connection_upgrade_contacts_async() takes a C-array + length.

* GPtrArray must always be used in a way that reffing it is enough to keep the container AND its elements, and unreffing it is enough to 'unown' the container AND its elements. In most case this means that the array must own its elements and have a free_func set, and g_ptr_array_free() must never be used. Returning such GPtrArray, if not retunring the internal pointer, must be annotated with "transfer container" and the function name must be tp_foo_dup_bar().
* GHashTable is similar to GPtrArray case.
* When returning a GList, if not returning the internal pointer, it must be deep-copied, annotated with "transfer full", and function name must be tp_foo_dup_bar().

#### Unsure?

tp_foo_dup_bar() it is!

### GNU Indent

This command line doesn't exactly produce Telepathy style (and please do not run it over any existing codebase without very specific maintainer approval!), but it's a reasonable first approximation:

    indent -bad -bap -cdb -sc -bl -bli2 -cli0 -cbi2 -cs -bs -saf -sai -saw -di1 \
        -nbc -psl -bls -blf -ci4 -ip4 -ppi2 -il0 -l78 -bbo

### Emacs C Mode

Adding the following to your `.emacsrc` creates a Telepathy style for you:

    (defun telepathy-c-initialization-hook ()
      (c-add-style "telepathy"
      '("gnu"
        (indent-tabs-mode . nil)
        (c-offsets-alist
         (arglist-intro . 4)
         (arglist-cont-nonempty . 4)))))

    (add-hook 'c-initialization-hook 'telepathy-c-initialization-hook)

You can also set telepathy style as default:

    (setq c-default-style "telepathy")

### Vim Configuration

Adding the following to your `.vimrc` should help with adherence to these guidelines:

    set cinoptions=>2s,{1s,n-s,^-s
    autocmd FileType python setlocal textwidth=78 tabstop=4 softtabstop=4 shiftwidth=4 expandtab
    autocmd FileType c      setlocal textwidth=78 tabstop=4 softtabstop=2 shiftwidth=2 expandtab cindent


## C++ code using Qt

telepathy-qt is meant to be in the [kdelibs coding style](https://community.kde.org/Policies/Kdelibs_Coding_Style).

The Generic rules mentioned above (`#include` and filename guidelines) also apply to C++.

## Python

See [PEP 8](http://www.python.org/dev/peps/pep-0008/).

Indentation should always be 4 spaces.
