---
title: "Source code"
draft: true
---

Telepathy uses [git](http://git.or.cz/) and is hosted on freedesktop.org.

You can **browse** the source code via the **[cgit web interface](http://cgit.freedesktop.org/telepathy/)**. That site's "summary" links also list the URLs for both anonymous access (git://, https://) and developer access (ssh://) for individual modules.

## Checking out the source code

If you want bleeding-edge code, (or if you want to help out with development of Telepathy), you can check out the source code from git. Of course, you might prefer to use our [Source Code Tarballs](/components/releases).

Anybody can checkout the latest source code anonymously with a command such as the following:

`git clone git://anongit.freedesktop.org/telepathy/telepathy-glib`

You can commit changes to your local repository but will not be able to push them to the central repository.

**If you are a developer** with an ssh account in the `telepathy` group and would like to be able to push your changes to the central repository, please clone the main repository on the server to your public_html, to have a public repository of your own, then clone _that_ to your development machine. See "Working on an existing git repository" below.

## Working on an existing git repository

This workflow gives you a personal repository to point people towards for code review, and avoids the problem of accidentally pushing unreviewed changes to the central repository.

Replace the values of PROJECT, USERNAME and OTHERUSER as appropriate.

    # on annarchy.freedesktop.org: create your personal repository
    PROJECT=telepathy-glib
    cd ~
    git clone --bare git://anongit.freedesktop.org/telepathy/$PROJECT $PROJECT.git

    # on your laptop: check out a copy
    PROJECT=telepathy-glib
    USERNAME=foo
    git clone ssh://people.freedesktop.org/~$USERNAME/$PROJECT
    cd $PROJECT
    git remote add upstream ssh://git.freedesktop.org/git/telepathy/$PROJECT

    # if you are interested in unreviewed code published by other users, e.g. smcv:
    OTHERUSER=smcv
    git remote add smcv git://people.freedesktop.org/~$USERNAME/$PROJECT
    git config remote.$OTHERUSER.tagopt --no-tags
    git remote update

    # on your laptop: do some work on a new branch, and publish it
    git checkout -b bug-12345 master
    vim something.c
    make check
    git commit -a
    git push --all

    # on your laptop: (for committers only) once your code is reviewed, merge it
    git checkout master
    git remote update upstream
    git merge upstream/master   # this should always be a "fast-forward" merge
    git checkout bug-12345
    git rebase master   # to maintain an easy to read history
    git checkout master
    git merge --no-ff bug-12345  # never "fast-forward"; write the Reviewed-by tag on the merge commit's comment
    git push upstream master
