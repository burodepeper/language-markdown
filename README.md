# Markdown grammar

Our intention with this package is to _follow the specifications_ as they are defined in the [latest version (0.22)](http://spec.commonmark.org/0.22/) of [CommonMark](http://www.commonmark.org/), and to allow the user to dynamically **add flavor(s)** of their own choosing; `Github` or `Pandoc` for example.

Unfortunately however, because of how Atom parses grammar, certain things are simply impossible or unrealistic to detect/support. If you experience any issues above a reasonable level of annoyancy, please [create an issue](issues/new/) (or contact us directly) and supply as much relevant information as possible.

In the summaries below you can get an idea of the progress of our work.

---

## CommonMark

### Leaf blocks

Leaf blocks are blocks that can _not_ contain other blocks.

| Section | Specs | Progress | Contact |
| ------- | ----- | -------: | ------- |
| Horizontal rules | 20 of 25 | 80% | @burodepeper |
| ATX headings | 24 of 25 | 96% | @burodepeper |
| Setext headers | - | - | - |
| Indented code blocks | - | - | @burodepeper |
| Fenced code blocks | - | - | - |
| HTML blocks | - | - | - |
| Links reference definitions | - | - | - |

### Container blocks

Container blocks are blocks that _can_ contain other blocks.

| Section | Specs | Progress | Contact |
| ------- | ----- | -------: | ------- |
| Block quotes | - | - | @burodepeper |
| Lists | 19 of 19 | 100% | @burodepeper |

### Inlines

| Section | Specs | Progress | Contact |
| ------- | ----- | -------: | ------- |
| Backslash escapes | - | - | @burodepeper |
| Entities | - | - | - |
| Code spans | - | - | - |
| Emphasis and strong emphasis | - | - | - |
| Links | - | - | - |
| Images | - | - | - |
| Autolinks | - | - | - |
| Raw HTML | - | - | - |
| Hard line breaks | - | - | - |
| Soft line breaks | - | - | - |

---

## Flavors

TODO Add description of intention

| Section | Specs | Progress | Contact |
| ------- | ----- | -------: | ------- |
| Dynamic grammar selection | - | - | @leipert |
| Less verbose specs | - | - | @leipert |

### Github flavored Markdown

See: https://help.github.com/articles/github-flavored-markdown/

| Section | Specs | Progress | Contact |
| ------- | ----- | -------: | ------- |
| TODO @burodepeper | - | - | - |

### Pandoc flavored Markdown

| Section | Specs | Progress | Contact |
| ------- | ----- | -------: | ------- |
| TODO @leipert | - | - | - |

### CriticMarkup

See: https://github.com/CriticMarkup/CriticMarkup-toolkit/

| Section | Specs | Progress | Contact |
| ------- | ----- | -------: | ------- |
| TODO @burodepeper | - | - | - |
