# Markdown grammar

A realistic implementation of the [CommonMark](http://www.commonmark.org/) specifications as a flexible (drop-in) alternative to [language-gfm](https://github.com/atom/language-gfm/). Adds smart context-aware behavior to lists.

If you experience any issue above a reasonable/tolerable level of annoyancy, don't hesitate to [create an issue](issues/new/).

[![Build Status](https://travis-ci.org/burodepeper/language-markdown.svg?branch=master)](https://travis-ci.org/burodepeper/language-markdown)
[![apm](https://img.shields.io/apm/dm/language-markdown.svg)](https://atom.io/packages/language-markdown)
[![apm](https://img.shields.io/apm/v/language-markdown.svg)]()

## Supported grammar

- CommonMark Markdown
- Github Flavored Markdown (+AtomDoc)
- Markdown Extra
- CriticMark annotation
- Front Matter (yaml and toml)
- R Markdown
- View [more details](STATUS.md) or a [bunch of examples](EXAMPLES.md)

### Additional features

- **Smarter lists**
  - Automatically create new list-items when pressing <kbd>enter</kbd>
  - Indent or outdent list-items by pressing <kbd>tab</kbd> or <kbd>shift+tab</kbd>
  - Toggle tasks with <kbd>cmd+shift+x</kbd> or <kbd>ctrl+shift+x</kbd>
  - Remove empty list-items when pressing <kbd>enter</kbd>

### Syntax-theme support

By default, most syntax-themes only provide basic styling for `.markup` classes. This package provides additional, more specific classes which are supported by the following syntax-themes:

**Full/extended support**

- [minimal-syntax](https://atom.io/themes/minimal-syntax) (light)
- [minimal-syntax-dark](https://atom.io/themes/minimal-syntax-dark) (dark)
- [pubster-syntax](https://atom.io/packages/pubster-syntax) (dark)

---

## Installation instructions

1. Install `language-markdown` via
  - your console: `apm install language-markdown`
  - the Atom GUI (Atom > Settings > Install > Search for `language-markdown`)
2. Restart Atom (as a pre-caution, shouldn't be necessary)

## Contributing

First of all, any and all contributions are more than welcome! Having said that, things over here are a little different than in other Atom packages.

1. The main grammar file (`language-markdown.json`) is compiled, so there is no use in changing it directly. Instead, the grammar has been split up into several smaller pieces which can be found in `/grammars/repositories`, and the grammar for fenced-code-blocks is compiled from a list that can be found in `/grammars/fixtures`. After you have changed anything, you can recompile the main grammar by executing the `compile-grammar-and-reload` command (<kbd>cmd+alt+ctrl+c</kbd> on Mac OS X, and <kbd>shift-alt-ctrl-c</kbd> on other platforms) which is only available in dev-mode. This will also automatically reload Atom for you.
2. Specs are written in a custom format called `ASS` and can be found in `/spec/fixtures` as `.ass` files. I believe they are pretty self-explanatory, and installing [language-ass](https://github.com/burodepeper/language-ass/) will add syntax highlighting for you. In combination with [minimal-syntax](https://atom.io/packages/minimal-syntax) this makes them a breeze to work with. Pun intended.
3. When submitting a PR, please do so on the `dev` branch, instead of directly on `master`. It's not that big of a deal, but it keeps merge conflicts going back and forth between `master` and `dev` to a minimum.
4. When in doubt about a conflict on the main grammar file, don't worry about it. Before publishing an update, it will be re-compiled just to be sure anyway.

### Add extended support for language-markdown to your syntax-theme

TODO Learn more about adding support for `language-markdown` to your syntax-theme

----

#### Notes

- Raw `html` is included when you have `language-html` installed
- The Github `task-lists` are implemented as a part of `unordered-lists`
- Setext-headers (underlined-headers) are not supported
- `Indented-code-blocks` have been disabled to prevent false-positives; use `fenced-code-blocks` instead
- Github tables require pipes at the start of each line, and cells need a padding of at least one space

#### References used

- http://spec.commonmark.org/0.22/
- https://help.github.com/articles/github-flavored-markdown/
- https://github.com/CriticMarkup/CriticMarkup-toolkit/
- http://jekyllrb.com/docs/frontmatter/
- http://pandoc.org/README.html#epub-metadata
- http://pandoc.org/demo/example9/pandocs-markdown.html
