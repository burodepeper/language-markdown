# Roadmap

## v0.1

### Janitorial

- [x] Make `README.md` more compact, and move secondary info to separate files
- [x] Add keybinding for `markdown:compile`
- [x] Move table-grammar to github-directory
- [ ] Break down spec-status in PASS, SKIP and FAIL counts
- [ ] Proper examples in EXAMPLES.md

### Core

- [x] specs for `blocks/fenced-code`: 77-103
- [ ] specs for `inlines/links`: 442-520, @479
- [ ] specs for `inlines/images`: 521-542, @522
- [x] specs for `inlines/autolinks`: 543-558
- [x] specs for `blocks/links-references`
- [ ] specs for `html`: 104-145 & 559-579 (if possible)
- [ ] specs for `inlines/line-breaks`: 580-594

### Flavors

- [x] grammar for `github/strikethrough`
- [x] grammar for `github/emojis`
- [x] specs for `github/mentions`
- [x] specs for `github/issues`
- [ ] specs for `github/emojis`
- [ ] specs for `github/strikethrough`
- [ ] specs for `github/tables`
- [ ] specs for `criticmark/annotation`
- [x] specs for `yaml-front-matter`

### Community

- [x] support `yaml-front-matter`
- [ ] import additional specs from [language-gfm]
- [ ] import/check issues from [language-gfm]

[language-gfm]: /atom/language-gfm

--------------------------------------------------------------------------------

## v0.2

### Janitorial

- [ ] Automatically load all `.ass` files in `/spec/fixtures` when `fixtures` is not defined.
- [ ] Perhaps remove the `/examples` directory; requires a lot of upkeep
