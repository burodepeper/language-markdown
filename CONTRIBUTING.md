# Contributing to language-markdown

Thank you for considering contributing to `language-markdown`. It is much appreciated. Read this guide carefully to avoid unnecessary work and disappointment for anyone involved.

## Getting started

Setting up your environment is pretty straight forward:

1. Fork the repository
2. `git clone` this repository to your machine (note: do _NOT_ clone the repo into `~/.atom/packages`, we want a separate development copy)
3. `cd` to where you've cloned the repo
4. `apm install` to install the dependencies
5. `apm link -d` to link this location to Atom's dev-mode
6. Restart Atom
7. `atom -d .` to open the package in dev-mode

When you are working a patch, create a separate branch and PR for each feature or fix. Submit your patch(es) against the `master` branch if you're unsure. Before submitting your patch, make sure the automated tests don't fail by running `apm test`.

Your ideas are most likely good, but that doesn't guarantee your patch will be merged. To avoid disappointment, open a new issue or empty PR to discuss your contribution before spending too much time on it.

---

## Compiling the grammar file

The main grammar file for this package (`grammars/language-markdown.json`) is compiled from all the separate bits and pieces found in the `/grammars` folder. `/grammars/repositories` holds the base grammar file in addition to the various repositories. `/grammars/fixtures` contains the instructions used to generate the fenced-code-blocks.

Any changes you make to these grammar repositories don't work until you've re-compiled the main grammar file and reloaded Atom. You can do this by executing the `language-markdown:compile-grammar-and-reload` command which is mapped to <kbd>cmd+alt+ctrl+c</kbd> or <kbd>shift+alt+ctrl+c</kbd> while in dev-mode.

---

## Testing grammar spec using `.ass`

As a personal exercise, the tests for this project are written in a custom format named `.ass`. This format describes how input is split of in different elements and allows for re-usable nested components. The syntax is very limited yet powerful. Be sure to install the [language-ass](https://atom.io/packages/language-ass) package for syntax-highlighting, which works well in combination with [minimal-syntax](https://atom.io/themes/minimal-syntax) or [minimal-syntax-dark](https://atom.io/themes/minimal-syntax-dark).

Let's dissect some simple HTML to see how this works.

```ass
# This is a comment
@identifier
"This is a <strong>test</strong>.": html
```

Lines that start with a `#` are considered comments. Lines can only contain a single type of declaration, and as such, comments can not be added to the end of another declaration and must exist on their own line.

A line that starts with a `@` is an optional identifier for a test. When omitted, an identifier will be assigned based on the path of the test and an incrementer.

The test itself, `"This is a <strong>test</strong>.": html`, consists of the input (`"This is a <strong>test</strong>."`) and a description (`html`) separated by a colon (and an optional though preferred space).

Input will often contain more than a single thing, and in such cases the input can be split up in separate tokens. A test is only valid if the input matches the resulting combined tokens.

```ass
"This is a <strong>test</strong>." {
  "This is a "
  "<strong>test</strong>"
  "."
}
```

A description can be applied directly to a token (as seen in the first example), but it can also be applied to a group of tokens:

```ass
"This is a <strong>test</strong>." {
  html {
    "This is a "
    "<strong>test</strong>"
    "."
  }
}
```

All three tokens are now described as `html`. The second token however can be described in more detail. Notice how the token is now essentially a new input, though nested, and can be re-used and considered as a separate test.

```ass
"This is a <strong>test</strong>." {
  html {
    "This is a "
    "<strong>test</strong>" {
      "<strong>"
      "test"
      "</strong>"
    }
    "."
  }
}
```

The following example shows how this simple test might be fully specified:

```ass
"This is a <strong>test</strong>." {
  html {
    "This is a "
    "<strong>test</strong>" {
      emphasis {
        strong {
          "<strong>" {
            tag {
              open {
                "<": punctuation
                "strong"
                ">": punctuation
              }
            }
          }
          "test"
          "</strong>" {
            tag {
              close {
                "</": punctuation
                "strong"
                ">": punctuation
              }
            }
          }
        }
      }
    }
    "."
  }
}
```

When parsed by `/spec/ass-spec.coffee` this would result in the creation of the following data to be tested:

| token | scope
| ----- | -----
| `This is a ` | html
| `<` | html, emphasis, strong, tag, open, punctuation
| `strong` | html, emphasis, strong, tag, open
| `>` | html, emphasis, strong, tag, open, punctuation
| `test` | html, emphasis, strong
| `</` | html, emphasis, strong, tag, close, punctuation
| `strong` | html, emphasis, strong, tag, close
| `>` | html, emphasis, strong, tag, close, punctuation
| `.` | html

---

## Syntax theme support

This grammar generates scopes that (slightly) differ from those set by `language-gfm`. I've tried to consistently add a primary non-markup-related scope to each element, and additionally some generic markup-related scopes for more specific styling. Support for `markup` scopes in most syntax-themes in minimal, so I've created a `.less` [template](https://github.com/burodepeper/language-markdown/blob/dev-scopes/resources/markup-and-down.less) to easily implement these generic styles as part of your syntax-theme.

See [minimal-syntax](https://github.com/burodepeper/minimal-syntax) for a good-to-go full implementation. [Let me know](https://github.com/burodepeper/language-markdown/issues/new/) when you've added full (or partial) `language-markdown` support to your syntax-theme, and I'll add your package to the README.

---

### Resources and references

- http://spec.commonmark.org/0.22/
- https://help.github.com/categories/writing-on-github/
- https://github.com/CriticMarkup/CriticMarkup-toolkit/
- http://jekyllrb.com/docs/frontmatter/
- http://pandoc.org/README.html#epub-metadata
- http://pandoc.org/demo/example9/pandocs-markdown.html
- http://rmarkdown.rstudio.com/authoring_rcodechunks.html
- http://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf
- http://yihui.name/knitr/options/
- https://github.com/iainc/Markdown-Content-Blocks
