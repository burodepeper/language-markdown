# Roadmap

## v0.2

### Maintenance

- [x] Use a `dev` branch from now on
- [x] Automatically load all `.ass` files in [/spec/fixtures] when `fixtures` is not defined.
  - [x] Split up `github` spec to test the automatic loading of the fixtures.
- [x] Clean up the main grammar file; subrepos for helpers
- [x] Perhaps remove the `/examples` directory; requires a lot of upkeep
- [x] Proper examples in [EXAMPLES.md]
- [ ] Thin out the specs:
  - [ ] Remove unneccessary repeated elements that provide context unimportant to syntax highlighting
  - [ ] Remove duplicates
  - [ ] Remove tests aimed at interpretation rather than representation (for instance, uppercase vs lowercase testing, or logical dependencies)

### Grammar, specs and issues

- [x] Add spec for gfm task-lists (#29)
- [x] HTML doesn't work in list-items (#33)
- [x] Add extended dashes to punctuation part of comment (#34)
- [ ] Support advanced gfm references (#35)

### Community

- [ ] import additional specs from [language-gfm]
- [ ] import/check issues from [language-gfm]

[language-gfm]: /atom/language-gfm

---

## Future

### Interface

- [ ] Add new link-items automatically when pressing [ENTER]

### Maintenance

- [ ] Create an abstracted function to recursively index files inside a directory with a certain extension, while retaining a relative path; method is currently used to load fixtures in spec, but can also be used to load all cson files when compiling the grammar file.
