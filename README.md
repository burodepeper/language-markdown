# Markdown grammar

A realistic implementation of various Markdown specifications as a flexible, drop-in alternative for [language-gfm](https://github.com/atom/language-gfm/). Adds smart context-aware behavior to lists, and keyboard shortcuts for inline emphasis and links/images.

[![Build Status](https://travis-ci.org/burodepeper/language-markdown.svg?branch=master)](https://travis-ci.org/burodepeper/language-markdown)
[![apm](https://img.shields.io/apm/dm/language-markdown.svg)](https://atom.io/packages/language-markdown)
[![apm](https://img.shields.io/apm/v/language-markdown.svg)](https://atom.io/packages/language-markdown)

## Installation

1. Install `language-markdown` via either
  - your terminal: `apm install language-markdown`
  - the Atom GUI: `Atom` > `Settings` > `Install` > Search for `language-markdown`
2. Select `language-markdown` as your Markdown grammar. Open a Markdown file and
  - press <kbd>ctrl+shift+L</kbd> and choose "Markdown"
  - choose "Markdown" from the grammar selection interface in the bottom right-hand corner of the window

To avoid conflicts this package tries to disable the core package `language-gfm`. If you run into any issue, make sure you've selected the correct grammar.

## Supported grammars

- CommonMark Markdown
- Github Flavored Markdown (including AtomDoc)
- Markdown Extra
- CriticMark annotation
- Front Matter (yaml, toml and json)
- R Markdown

### Additional features

- **Smarter lists**
  - Automatically create new list-items when pressing <kbd>enter</kbd>
  - Indent or outdent list-items by pressing <kbd>tab</kbd> or <kbd>shift+tab</kbd>
  - Toggle tasks with <kbd>cmd+shift+x</kbd> or <kbd>ctrl+shift+x</kbd>
  - Remove empty trailing list-items when pressing <kbd>enter</kbd>
- Add shortcuts (via <kbd>_</kbd>, <kbd>*</kbd> and <kbd>~</kbd>) for toggling inline-emphasis and strike-through on selected text
- Add shortcuts for converting selected text to a link (via <kbd>@</kbd>) or an image (via <kbd>!</kbd>)
- Supports embedded `HTML`- and `Liquid`-tags
- Embedded math functions (via `language-latex` and `language-mathematica`)

### Syntax-theme support

By default, most syntax-themes only provide basic styling for `.markup` classes. This package provides additional, more specific classes which are supported by the following syntax-themes:

- [minimal-syntax](https://atom.io/themes/minimal-syntax) (light, high-contrast)
- [minimal-syntax-dark](https://atom.io/themes/minimal-syntax-dark) (dark, high-contrast)
- [pen-paper-coffee](https://atom.io/themes/pen-paper-coffee-syntax) (light, low-contrast)
- [pubster-syntax](https://atom.io/themes/pubster-syntax) (dark, high-contrast)
- [one-o-eight-syntax](https://atom.io/themes/one-o-eight-syntax) (various, medium-contrast)

If you are interested in adding support for all `.markup` classes to your syntax-theme, take a look at [the relevant section](https://github.com/burodepeper/language-markdown/blob/master/CONTRIBUTING.md#syntax-theme-support) in [the contribution guide](https://github.com/burodepeper/language-markdown/blob/master/CONTRIBUTING.md).

## F.A.Q.

If you run into any issues, consult the [F.A.Q.](https://github.com/burodepeper/language-markdown/blob/master/FAQ.md) first. Amongst other things, this document contains information about common issues involving:

- spell-check
- autocompletion
- syntax-highlighting
- whitespace

## Contributing

If you want to contribute to this package, have a look at [the contribution guide](https://github.com/burodepeper/language-markdown/blob/master/CONTRIBUTING.md).
