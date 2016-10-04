# Markdown grammar

A realistic implementation of various Markdown specifications as a flexible, drop-in alternative for [language-gfm](https://github.com/atom/language-gfm/). Adds smart context-aware behavior to lists, and keyboard shortcuts for inline emphasis.

If you experience any issue above a reasonable/tolerable level of annoyancy, don't hesitate to [create an issue](issues/new/).

[![Build Status](https://travis-ci.org/burodepeper/language-markdown.svg?branch=master)](https://travis-ci.org/burodepeper/language-markdown)
[![apm](https://img.shields.io/apm/dm/language-markdown.svg)](https://atom.io/packages/language-markdown)
[![apm](https://img.shields.io/apm/v/language-markdown.svg)]()

---

## Supported grammars

- CommonMark Markdown
- Github Flavored Markdown (including AtomDoc)
- Markdown Extra
- CriticMark annotation
- Front Matter (yaml and toml)
- R Markdown

### Additional features

- **Smarter lists**
  - Automatically create new list-items when pressing <kbd>enter</kbd>
  - Indent or outdent list-items by pressing <kbd>tab</kbd> or <kbd>shift+tab</kbd>
  - Toggle tasks with <kbd>cmd+shift+x</kbd> or <kbd>ctrl+shift+x</kbd>
  - Remove empty trailing list-items when pressing <kbd>enter</kbd>
- Adds shortcuts (via <kbd>_</kbd>, <kbd>*</kbd> and <kbd>~</kbd>) for toggling inline-emphasis and strike-through on selected text
- Supports embedded `HTML`- and `Liquid`-tags

### Syntax-theme support

By default, most syntax-themes only provide basic styling for `.markup` classes. This package provides additional, more specific classes which are supported by the following syntax-themes:

**Full/extended support**

- [minimal-syntax](https://atom.io/themes/minimal-syntax) (light, high-contrast)
- [minimal-syntax-dark](https://atom.io/themes/minimal-syntax-dark) (dark, high-contrast)
- [pen-paper-coffee](https://atom.io/themes/pen-paper-coffee-syntax) (light, low-contrast)
- [pubster-syntax](https://atom.io/themes/pubster-syntax) (dark, high-contrast)
- [one-o-eight-syntax](https://atom.io/themes/one-o-eight-syntax) (various, medium-contrast)

#### Add extended support for language-markdown to your syntax-theme

This grammar generates scopes that (slightly) differ from those set by `language-gfm`. I've tried to consistently add a primary non-markup-related scope to each element, and additionally some generic markup-related scopes for more specific styling. Support for `markup` scopes in most syntax-themes in minimal, so I've created a `.less` [template](https://github.com/burodepeper/language-markdown/blob/dev-scopes/resources/markup-and-down.less) to easily implement these generic styles as part of your syntax-theme. See [minimal-syntax](https://github.com/burodepeper/minimal-syntax) for a good-to-go full implementation. [Let me know](https://github.com/burodepeper/language-markdown/issues/new/) when you've added full (or partial) `language-markdown` support to your syntax-theme, and I'll add your package to the list above.

---

## Installation instructions

1. Install `language-markdown` via
  - your console: `apm install language-markdown`
  - the Atom GUI: `Atom` > `Settings` > `Install` > Search for `language-markdown`
2. Restart Atom (as a pre-caution; shouldn't be necessary)
3. Select `language-markdown` as your Markdown grammar:
  - press <kbd>ctrl+shift+L</kbd> and choose "Markdown" (this disables `language-gfm` to minimize conflicts); or
  - manually disable `language-gfm`, and let `language-markdown` automatically handle Markdown files

#### Uninstalling language-markdown

The core-package `language-gfm` is automatically disabled (unless you've enabled the setting that prevents this) when using `language-markdown` to avoid any conflicts. Because `language-markdown` is intended as a drop-in replacement you most likely won't need both anyway. However, if you uninstall `language-markdown`, `language-gfm` doesn't automatically get re-activated. There's no API available to do this, so you'll have to re-activate `language-gfm` manually, which is quite easy.

1. Open the "Settings" and go to the "Packages" tab
2. Search for `language-gfm`
3. Click `Enable` to re-activate it
4. You probably want to reload Atom to make sure the change takes effect

## F.A.Q.

**Spell-check doesn't work; how do I enable it?**<br>The core-package `spell-check` doesn't scan documents in the `text.md` by default. You can easily add this yourself:

- Open the Atom settings, and find the Packages tab
- Search for the `spell-check` package; you can find it under the Core Packages
- Open the settings for `spell-check`
- Append `text.md` to the list of grammars (make sure the scopes are comma-separated)
- Reload Atom to make sure the updated settings take effect

**Some of my Markdown elements aren't highlighted**<br>`language-markdown` parses your Markdown document; it does not directly color the different elements. This is done by the syntax-theme you are using. There's a good chance that your syntax-theme doesn't support all the different elements that `language-markdown` recognizes. You can ask the author of the theme to add better support for `language-markdown`, or [add styles to your custom stylesheet](http://flight-manual.atom.io/using-atom/sections/basic-customization/#style-tweaks). You can also try one of the tried and tested syntax-themes featured above. If you can't get it to work, feel free to [open an issue](https://github.com/burodepeper/language-markdown/issues/new/), and I'll see what I can do.

**Which elements of Markdown are supported?**<br>Because there is no clear Markdown standard, I've chosen to follow the [CommonMark Spec](http://spec.commonmark.org/) as closely as possible within the Atom environment. On top of that, I've implemented support for a few extensions: Github Flavored Markdown, Markdown Extra, CriticMark, Front Matter, and R Markdown. Together, I believe these specs cover a solid 98% of your day-to-day Markdown needs. If you feel that an element is missing, please [open an issue](https://github.com/burodepeper/language-markdown/issues/new/).

---

## Contributing

First of all, **any and all contributions are more than welcome!** Having said that, things over here are a little different than in other Atom packages.

1. The main grammar file (`language-markdown.json`) is compiled, so there is no use in changing it directly. Instead, the grammar has been split up into several smaller pieces which can be found in `/grammars/repositories`, and the grammar for fenced-code-blocks is compiled from a list that can be found in `/grammars/fixtures`. After you have changed anything, you can recompile the main grammar by executing the `compile-grammar-and-reload` command (<kbd>cmd+alt+ctrl+c</kbd> on Mac OS X, and <kbd>shift-alt-ctrl-c</kbd> on other platforms) which is only available while in `dev-mode`. This will also automatically reload Atom for you.
2. Specs are written in a custom format called `ASS` and can be found in `/spec/fixtures` as `.ass` files. I believe they are pretty self-explanatory, and installing [language-ass](https://github.com/burodepeper/language-ass/) will add syntax highlighting for you. In combination with [minimal-syntax](https://atom.io/packages/minimal-syntax) this makes them a breeze to work with. Pun intended.
3. When submitting a PR, please do so on the `dev` branch, instead of directly on `master`. It's not that big of a deal, but it keeps merge conflicts going back and forth between `master` and `dev` to a minimum.
4. When in doubt about a conflict on the main grammar file, don't worry about it. Before publishing an update, it will be re-compiled anyway.

---

#### Notes

- Raw `html` is included when you have the default `language-html` grammar enabled
- The Github Flavored `task-lists` are implemented as part of 'normal' `lists`
- Setext-headers (underlined-headers) are not supported
- `indented-code-blocks` have been disabled to prevent false-positives; use `fenced-code-blocks` instead ([more details](https://github.com/burodepeper/language-markdown/issues/88#issuecomment-183344420))
- Github tables require pipes at the start of each line, and cells need a padding of at least one space; this is a suggested convention to prevent false positives

#### References

- http://spec.commonmark.org/0.22/
- https://help.github.com/categories/writing-on-github/
- https://github.com/CriticMarkup/CriticMarkup-toolkit/
- http://jekyllrb.com/docs/frontmatter/
- http://pandoc.org/README.html#epub-metadata
- http://pandoc.org/demo/example9/pandocs-markdown.html
- http://rmarkdown.rstudio.com/authoring_rcodechunks.html
- http://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf
- http://yihui.name/knitr/options/
