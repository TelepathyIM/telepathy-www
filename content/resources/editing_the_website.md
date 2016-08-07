---
title: Editing this website
categories: ["information"]
---

This website uses [Hugo](https://www.gohugo.io/) to generate static pages out of markdown documents and html templates. If you are unfamiliar with hugo and go templates, you should first read some of hugo's documentation.

## Repository

TODO

## Editing a page

All pages can be found under `content/` in the form of markdown documents. Simply edit the file you want, `git commit` and `git push`.

If you need to add a new page, make sure to add the proper yaml header, like in other similar pages.

Any page with `draft: true` in the yaml header will not be displayed anywhere, it will only exist in git. You can use this to hide outdated pages that do not deserve to be deleted just yet or to hide new pages that shouldn't appear yet.

## Updating components

The components lists, their version numbers, their documentation links, etc are all generated from static toml documents that can be found in `data/`. After making a release, whoever makes it should ensure that these toml documents are up to date.
