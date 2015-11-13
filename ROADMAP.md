# Roadmap

## v0.3

- [x] **Thin out the specs**:
  - [x] Remove unneccessary repeated elements that provide context unimportant to syntax highlighting
  - [x] Remove duplicately items
  - [x] Remove tests aimed at interpretation rather than representation (for instance, uppercase vs lowercase testing, or logical dependencies)
- [ ] Support advanced gfm references (#35)
- [x] Add support for TOML front matter (#36)
- [x] Add Markdown Extra flavor (#37)
  - [x] Add special-attributes (`{#id .class key=value}`) to
    - [x] Headings
    - [x] Fenced code blocks
      - [x] Separate `special-attribute-elements` from `special-attributes`
      - [x] Use `special-attribute-elements` to replace `fenced-code-info`
      - [x] Combine the two types of generated `fenced-code-blocks` in a single match
    - [x] Links
    - [x] Images
  - [x] Defintion lists
  - [x] Footnotes
  - [x] Abbreviations
  - [x] specs and examples
  - [x] Test with default syntax-themes
- [ ] language-gfm/issues/40
- [ ] Review existing specs
  - [x] /blocks/fenced-code/100
  - [ ] /blocks/lists/262

---

## Future

### Interface

- [ ] Add new link-items automatically when pressing `ENTER`
- [ ] Commands for (strong) emphasis; see [language-gfm/issues/94]
- [ ] Show an index of headings found in the current document, possibility in a side panel
- [ ] Linter: check if link-labels have a matching reference

### Maintenance

- [ ] Create an abstracted function to recursively index files inside a directory with a certain extension, while retaining a relative path; method is currently used to load fixtures in spec, but can also be used to load all cson files when compiling the grammar file.
