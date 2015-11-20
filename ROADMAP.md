# Roadmap

## Next version (v0.4)

- [ ] Add new link-items automatically when pressing `ENTER` (#45)
- [x] Upgrade links to allow linked-images (#40)
- [ ] Spec for gfm-references
- [ ] Review spec [/blocks/lists/262]
- [ ] Add support for `mermaid` to fenced-code-blocks

---

## Future

- [ ] Commands for (strong) emphasis; see [language-gfm/issues/94]
- [ ] Create an abstracted function to recursively index files inside a directory with a certain extension, while retaining a relative path; method is currently used to load fixtures in spec, but can also be used to load all cson files when compiling the grammar file.
- [ ] Show an index of headings found in the current document, possibility in a side panel
- [ ] Linter: check if link-labels have a matching reference
- [ ] Add support for `erb` to fenced-code-blocks (#43)
- [ ] Add support for `php` to fenced-code-blocks (#22)
