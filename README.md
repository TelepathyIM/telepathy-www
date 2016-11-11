# telepathy-www

Website source code of https://telepathy.freedesktop.org

This website uses [Hugo](https://www.gohugo.io/) to generate static pages out of markdown documents and html templates. If you are unfamiliar with hugo and go templates, you should first read some of hugo's documentation.

## Repository

The code of this website can be found [here](https://github.com/TelepathyIM/telepathy-www)

## Building

The static content is build from the sources using `hugo`. For convenience, there is also a Makefile that also includes a target for uploading the content to the `telepathy.freedesktop.org` server.

Assuming that `hugo` is in your `PATH`, the following commands can be used interchangeably to build the content:

`$ hugo`

or

`$ make`

When finished, the generated pages will be available in the `public` subdirectory.

If hugo is not in your `PATH`, the Makefile can be instructed to find it elsewhere with the `HUGO` environment variable. For example:

`$ HUGO=./hugo make`

In order to locally preview changes with a bit more ease (hugo supports automatic page reloading in the browser when a markdown file changes on disk), you can run:

`$ hugo server`

## Uploading to telepathy.freedesktop.org

Assuming that you have shell access to telepathy.freedesktop.org, the following command will build and upload the latest version from your local sources:

`$ make upload`

## Editing a page

All pages can be found under `content/` in the form of markdown documents. Simply edit the file you want, `git commit` and `git push`.

If you need to add a new page, make sure to add the proper yaml header, like in other similar pages.

Any page with `draft: true` in the yaml header will not be displayed anywhere, it will only exist in git. You can use this to hide outdated pages that do not deserve to be deleted just yet or to hide new pages that shouldn't appear yet.

## Updating components

The components lists, their version numbers, their documentation links, etc are all generated from static toml documents that can be found in `data/`. After making a release, whoever makes it should ensure that these toml documents are up to date.
