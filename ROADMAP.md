# Roadmap

## v0.3

- [ ] **Thin out the specs**:
  - [ ] Remove unneccessary repeated elements that provide context unimportant to syntax highlighting
  - [ ] Remove duplicates
  - [ ] Remove tests aimed at interpretation rather than representation (for instance, uppercase vs lowercase testing, or logical dependencies)
- [ ] Support advanced gfm references (#35)
- [ ] Add support for TOML front matter (#36)
- [ ] Add Markdown Extra flavor (#37)
- [ ] language-gfm/issues/40

---

## Future

### Interface

- [ ] Add new link-items automatically when pressing `ENTER`
- [ ] Commands for (strong) emphasis; see [language-gfm/issues/94]
- [ ] Show an index of headings found in the current document, possibility in a side panel

### Maintenance

- [ ] Create an abstracted function to recursively index files inside a directory with a certain extension, while retaining a relative path; method is currently used to load fixtures in spec, but can also be used to load all cson files when compiling the grammar file.
