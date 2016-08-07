---
title: Using Git
categories: ["policies"]
---

This page explains how we use the various Git features in Telepathy.

## Commit messages

If a commit is linked to a certain bug report, it should reference the bug report's full link on the bottom of the commit message. For example:

        This is a bug fix for foo

        It turns out that bar was bugging foo.
        This commit fixes the problem.

        https://bugs.freedesktop.org/show_bug.cgi?id=12345

If a commit has been reviewed by someone (which is mandatory btw), then the commit should have a `Reviewed-by:` tag mentioning his full name and email. This tag should go under the bug report link, if there is any. For example:

        This is a bug fix for foo

        It turns out that bar was bugging foo.
        This commit fixes the problem.

        https://bugs.freedesktop.org/show_bug.cgi?id=12345
        Reviewed-by: Name Surname <email@domain.name>

If a commit is related to a bug report but is part of a whole series of commits (work branch) that addresses this bug as a whole, then no commit should reference the bug link or the reviewer's name. This information should be on the *merge commit* instead. See the `Merging work branches` section below for more information.

## Branches

### Series branches

Each stable release series should have its own branch. Any commits made in this branch should follow the rule of being only bug fixes or translation updates.

If a bug fix needs to be applied both in a stable branch and in master, then it should be applied to the branch and then the branch should be merged in master. The opposite way of cherry-picking from master is allowed, but should be avoided.

In any case, the stable series branch should always be merged in master after a stable release, ensuring that master always has all the history included and is not missing any commits.

Unstable release series should not have a branch of their own. Unstable releases should be made from master directly.

### Work branches

Anything that you are working on should be worked in a branch. The branch is advised to be named after the feature or the bug number.

Work branches should not be pushed to main repositories, unless it has been discussed and agreed by all contributors. They should instead be kept in private repositories until they are reviewed.

### Merging work branches

Work branches should always be merged in the following way:

1. `git rebase` on top of the branch that they are going to be merged into - this means that the branch should be possible to be merged in fast-forward mode
1. `git merge --no-ff` on the branch (**--no-ff is important**) - this will create a merge commit, although the branch could be fast forwarded
1. Write the bug report link and any `Reviewed-by:` tags on the merge commit's message. For example:

        Merge branch 'bug-12345'

        https://bugs.freedesktop.org/show_bug.cgi?id=12345
        Reviewed-by: Name Surname <email@domain.name>


