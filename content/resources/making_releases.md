---
title: Making Releases
categories: ["information"]
---

## Checklist

If you are about to make a new release of a telepathy component, here is a list of things to do:

* If there's a NEWS file, summarize important changes in it and name the release.
* Grep for `UNRELEASED` and replace it with the new version number in @since gtk-doc/doxygen comments.
* If it's a C/GLib project, bump the version number in configure.ac:
    * If the package has a nano version like 1.2.3.1, set it to 0 and increment the minor version to 1.2.4.
    * If the package has a version like 1.2.3+, remove the + and increment the minor version to 1.2.4.
    * If the package has a _release, set it to 1 and increment the minor version.
* If the component is Telepathy-GLib and it adds ABI, whitelist new symbols. Newly introduced symbols can be found in reference docs as follows (which will also list typedefs and macros, which should not be included in the .abi file):  `git diff telepathy-glib-$PREVIOUS_VERSION..HEAD docs/reference/telepathy-glib-sections.txt | grep '^+[^+]' | cut -c2-`
* `git commit -am "$VERSION"`
* `make maintainer-make-release`
* If it's a C/GLib project, bump the nano version again in configure.ac and commit.
* `git push && git push --tags`
* Email the content of the `release-mail` file to `telepathy@lists.freedesktop.org` and `ftp-release@lists.freedesktop.org` with subject line: `ANNOUNCE: $component $version`

### What does maintainer-make-release do?

`maintainer-make-release` is a custom make target that performs the following actions:

* Verifies that the version number has no nano in it.
* Verifies that no file includes the word `UNRELEASED`
* Verifies that your git tree is clean (no uncommited changes)
* Generates the ChangeLog file from `git log`
* Builds the project (`make all`)
* Runs all unit tests (`make check`)
* Runs `make distcheck`, which in turns does the following:
    * Creates the release tarball (`make dist`)
    * Extracts it in a new directory, configures it, compiles it and runs `make check` again
* Generates the release email from the NEWS file and saves it in a new file called `release-mail`
* Tags the current commit with `git tag`
* Signs the tarball with your gpg key
* Runs `make maintainer-upload-release`, which in turn does the following:
    * Verifies that the tarball and the signature exist
    * Verifies the signature with gpg
    * Uploads those two with rsync on `telepathy.freedesktop.org/releases/$PACKAGE/$PACKAGE-$VERSION.tar.gz{,.asc}`
    * Uploads documentation (if any) on `telepathy.freedesktop.org/doc/...`
    * **NOTE**: the exact path of the doc upload directory is hardcoded in `Makefile.am` and should be manually changed when switching even/odd series
