---
title: "Bug tracker"
---

Upstream Telepathy components use the **[freedesktop bugzilla](http://bugs.freedesktop.org/)**.

* [File a new bug](https://bugs.freedesktop.org/enter_bug.cgi?product=Telepathy) against a Telepathy component.

* [Browse](https://bugs.freedesktop.org/buglist.cgi?bug_status=__open__&list_id=586220&order=Importance&product=Telepathy&query_format=specific) all bugs regarding Telepathy components

## Clients & 3rd-party components

Other 3rd-party components and clients may be using other bug tracking systems. Please try to figure out where is the best place to report a bug before doing so, in order to avoid wasting developers' time.

For the record, here is a list of known applications / components that track their bug reports somewhere else:

<table>
    <tr>
        <th>Application</th>
        <th>Bug tracker</th>
    </tr>
    <tr>
        <td>Empathy</td>
        <td><a href="https://bugzilla.gnome.org/enter_bug.cgi?product=empathy">Gnome Bugzilla</a></td>
    </tr>
    <tr>
        <td>KDE-Telepathy</td>
        <td><a href="https://bugs.kde.org/enter_bug.cgi?product=telepathy&format=guided">KDE Bugzilla</a></td>
    </tr>
</table>

## Wocky

Wocky is the XMPP library used internally by telepathy-gabble and telepathy-salut. It is not a Telepathy component, but it is maintained by the Telepathy project, using a separate product on bugzilla.

* [File a new bug](https://bugs.freedesktop.org/enter_bug.cgi?product=Wocky) against Wocky

* [Browse](https://bugs.freedesktop.org/buglist.cgi?bug_status=__open__&list_id=586221&order=Importance&product=Wocky&query_format=specific) all bugs regarding Wocky.

{{< warning title="Request" >}}
Please don't file bugs against Wocky, unless you know what you are doing. Telepathy-gabble and telepathy-salut bugs can be reported using the first link on this page.
{{< /warning >}}

## Low hanging fruit

Developers sometimes tag certain bugs as tasks that could be fixed by new contributors, for familiarizing with the code. Such bugs are tagged with the keyword *'love'* in bugzilla.

* Here's a [list of all bugs tagged with 'love'](https://bugs.freedesktop.org/buglist.cgi?quicksearch=product:Telepathy+keywords:love)

{{< note title="Note" >}}
Always consult with developers before picking a task, in any case
{{< /note >}}
