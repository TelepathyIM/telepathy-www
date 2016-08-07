---
title: Using bugzilla
categories: ["policies"]
---

This page describes how certain bugzilla features are used in Telepathy. It assumes that you are already familiar with bugzilla.

## Keywords

Keywords are pre-defined terms that can be added as tags on bugs. A full list of available keywords can be seen [here](https://bugs.freedesktop.org/describekeywords.cgi).

In Telepathy we mostly use the following ones:

* `patch`: The report has a valid patch attached
* `love`: The report is something that a beginner could pick up and do on his own with little to no help. This should **only** be set by a maintainer or people familiar with the code base, and **only** when it looks like a project suitable for a new developer looking for a task.
* `security`: Security-sensitive bugs

On the list of keywords that we **do not** use is the `NEEDINFO` keyword. This is dealt with the `NEEDINFO` *status* instead.

{{% note title="Kind request" %}}
Please, **do** use keywords when appropriate, as it helps sorting out the bugs.
{{%/ note %}}

## Whiteboard

The whiteboard allows free-form text to be inserted, which shows up in the bug lists and can be useful for some additional sorting. Since adding new keywords requires filing a freedesktop sysadmin request, this is the best way to use custom keywords.

Some known whiteboard keywords that we use:

* `review+` / `review-`: Indicating that a patch (bug should also have the `patch` keyword) has been reviewed and is either deemed ok for commit (+ sign) or it needs more work (- sign)
* a version number: Means that the bug should be fixed in this version. This is used instead of the Version / Target Milestone fields of bugzilla, as editing them also requires sysadmin tickets...

## Personal Tags

Personal tags are free-form text, just like the Whiteboard, with the difference that only **you** can see them. They are stored per-user, so two different users can have different text written in this field. It is advised that you make use of them when you triage bugs to remember things without writing them on public visible fields (or on some notebook on your desk).

Please remember, though, not to put information that *should* be public in these fields. Do communicate information that others may also need.

## Importance (Priority / Severity)

Priority and Severity are two fields that are often confused (even I confused them while writing this document...!). Here is what they mean:

* Priority: This indicates how soon a bug *should* be fixed. Bugs with high priority should be addressed sooner than bugs with normal or low priority.
* Severity: How important it is to address a certain bug or feature request. Even if something is highly important, though, it doesn't necessarily mean that it should be fixed asap.

In order to avoid confusion as to what the scale is on these values, here is a table with reference meanings:

### Priority

<table>
    <tr>
        <th>Priority</th>
        <th>Meaning</th>
    </tr>
    <tr>
        <td>highest</td>
        <td>something that needs to be addressed asap</td>
    </tr>
    <tr>
        <td>high</td>
        <td>something that needs to be addressed soon, but not necessarily asap</td>
    </tr>
    <tr>
        <td>medium</td>
        <td>normal reports</td>
    </tr>
    <tr>
        <td>low</td>
        <td>something that can be left for a while later</td>
    </tr>
    <tr>
        <td>lowest</td>
        <td>something that will most likely never be fixed</td>
    </tr>
</table>

### Severity

<table>
    <tr>
        <th>Severity</th>
        <th>Meaning</th>
    </tr>
    <tr>
        <td>blocker</td>
        <td>we can't release the next version until this bug is fixed</td>
    </tr>
    <tr>
        <td>critical</td>
        <td>a problem or a needed feature that has a big impact to users, however, it will not block the next release if it's not ready</td>
    </tr>
    <tr>
        <td>major</td>
        <td>an important problem or feature</td>
    </tr>
    <tr>
        <td>normal</td>
        <td>normal reports</td>
    </tr>
    <tr>
        <td>minor</td>
        <td>not very important stuff, but we might want to keep them in the loop</td>
    </tr>
    <tr>
        <td>trivial</td>
        <td>an unimportant bug that is probably easily fixable</td>
    </tr>
    <tr>
        <td>enhancement</td>
        <td>feature requests that are not very interesting for us at the moment, but we could consider patches for them at some point</td>
    </tr>
</table>
