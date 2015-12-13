# Markdown grammar

A realistic implementation of the [CommonMark](http://www.commonmark.org/) specifications as a flexible (drop-in) alternative to [language-gfm](https://github.com/atom/language-gfm/). Adds smart context-aware behavior to lists.

If you experience any issue above a reasonable/tolerable level of annoyancy, don't hesitate to [create an issue](issues/new/).

[![Build Status](https://travis-ci.org/burodepeper/language-markdown.svg?branch=master)](https://travis-ci.org/burodepeper/language-markdown)

## Supported grammar

- CommonMark Markdown
- Github Flavored Markdown
- Markdown Extra
- CriticMark annotation
- Front Matter (yaml and toml)
- View [more details](STATUS.md) or a [bunch of examples](EXAMPLES.md)

## Additional features

- **Smarter lists**
  - Automatically create new list-items when pressing <kbd>enter</kbd>
  - Indent or outdent list-items by pressing <kbd>tab</kbd> or <kbd>shift+tab</kbd>
  - Toggle tasks with <kbd>cmd+shift+x</kbd> or <kbd>ctrl+shift+x</kbd>

## Installation instructions

1. Install `language-markdown` via
  - your console: `apm install language-markdown`
  - the Atom GUI (Atom > Settings > Install > Search for `language-markdown`)
2. Restart Atom (as a pre-caution, shouldn't be necessary)

---

### Created with blood, sweat, tears, and these amazing tools:

[minimal-syntax](https://atom.io/packages/minimal-syntax)<br>
A light syntax theme, high contrast/low brightness, three primary colors, and easy on the eyes. Now also available as [minimal-syntax-dark](https://atom.io/packages/minimal-syntax-dark).

[lib-ass](https://www.npmjs.org/packages/lib-ass)<br>
Describe your tests in re-usable language-independent semantical format, and have them quickly translated into automated tests of your choosing.

[language-ass](https://github.com/burodepeper/language-ass/)<br>
Syntax highlighting in Atom for `.ass` files.
