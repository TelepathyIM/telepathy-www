---
title: Versioning policy
categories: ["policies"]
audiences: ["contributors"]
---

Telepathy in general is following the [Gnome Versioning Guidelines](https://developer.gnome.org/programming-guidelines/stable/versioning.html.en). This pages summarizes some important parts.

## Package versioning

Every package has a version number in the form *major.minor.micro*

The major number rarely changes. It should only change when there is a major change in functionality or an API break.

The minor number indicates a release series. **Even** minor numbers represent a stable release series and **odd** ones represent an unstable release series.

The micro number is the number of the release in the series. On an **unstable** release series, the code difference between micro releases can be significant if necessary, although it's ususally avoided to make big changes in order to give time for the code to stabilize. On a **stable** release series, the difference between micro releases can only be bug fixes or translation updates; it is strictly prohibited to have new features or other significant changes.

### Nano versions

Between releases, a nano version is also inserted in the package version. This number should be:

* 0 when making a release
* 1 after having made a release, indicating on users of git sources that this version was directly built from git

## Library API / ABI compatibility

Libraries are strictly not allowed to break API / ABI in a stable release series or between different stable release series. It is allowed, however, to break API / ABI between unstable releases in the same release series. This means that new API added in a certain unstable release series is allowed to break until there is a stable release with it.
