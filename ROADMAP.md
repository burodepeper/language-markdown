# Roadmap

## v0.1

### Janitorial

- [x] Make `README.md` more compact, and move secondary info to separate files
- [x] Add keybinding for `markdown:compile`
- [x] Move table-grammar to github-directory
- [x] Allow `/` in `lib-ass` identifiers

### Core

- [x] specs for `blocks/fenced-code`: 77-103
- [x] specs for `inlines/links`: 442-520
- [x] specs for `inlines/images`: 521-542
- [x] specs for `inlines/autolinks`: 543-558
- [x] specs for `blocks/links-references`
- [x] specs for `html`: 104-145 & 559-579 (if possible)
- [x] specs for `inlines/line-breaks`: 580-594
- [x] specs for `inlines/textual-content`

### Flavors

- [x] grammar for `github/strikethrough`
- [x] grammar for `github/emojis`
- [x] specs for `github/mentions`
- [x] specs for `github/issues`
- [x] specs for `github/emojis`
- [x] specs for `github/strikethrough`
- [ ] specs for `github/tables`
- [ ] specs for `criticmark/annotation`
- [x] specs for `yaml-front-matter`

### Community

- [x] support `yaml-front-matter`

--------------------------------------------------------------------------------

## v0.2

### Janitorial

- [ ] Use a `dev` branch
- [ ] Automatically load all `.ass` files in [/spec/fixtures] when `fixtures` is not defined.
- [ ] Perhaps remove the `/examples` directory; requires a lot of upkeep
- [ ] Proper examples in [EXAMPLES.md]
- [ ] Thin out the specs:
  - [ ] Remove unneccessary repeated elements that provide context unimportant to syntax highlighting
  - [ ] Remove duplicates
  - [ ] Remove tests aimed at interpretation rather than representation (for instance, uppercase vs lowercase testing, or logical dependencies)

### Community

- [ ] import additional specs from [language-gfm]
- [ ] import/check issues from [language-gfm]

[language-gfm]: /atom/language-gfm
