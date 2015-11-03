# Roadmap

## v0.2

### Maintenance

- [x] Use a `dev` branch from now on
- [x] Automatically load all `.ass` files in [/spec/fixtures] when `fixtures` is not defined.
  - [ ] Split up `github` spec to test the automatic loading of the fixtures.
- [ ] Clean up the main grammar file; are sub-repositories possible for the `link-` patterns?
- [ ] Perhaps remove the `/examples` directory; requires a lot of upkeep
- [ ] Proper examples in [EXAMPLE.md]
- [ ] Thin out the specs:
  - [ ] Remove unneccessary repeated elements that provide context unimportant to syntax highlighting
  - [ ] Remove duplicates
  - [ ] Remove tests aimed at interpretation rather than representation (for instance, uppercase vs lowercase testing, or logical dependencies)

### Grammar and specs

- [ ] Add spec for gfm task-lists (#29)

### Community

- [ ] import additional specs from [language-gfm]
- [ ] import/check issues from [language-gfm]

[language-gfm]: /atom/language-gfm

---

## Future

### Interface

- [ ] Add new link-items automatically when pressing [ENTER]
