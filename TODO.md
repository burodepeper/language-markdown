# david-splits-grammar

- [x] Restructure `/lib/main.coffee` to make room for combining grammar subrepositories.
- [ ] Move and split parts of main grammar repository in to `/grammars/repositories/blocks/*.cson` and `/grammars/repositories/inlines/*.cson`
- [ ] Move the basic structure to `/grammars/repositories/markdown.cson`
- [ ] Implement `combineGrammarRepositories()`
  - [ ] Load basic grammar structure
  - [ ] Load all grammar repositories (via GLOB?)
  - [ ] Append grammar repositories to the main repository
  - [ ] Write combined grammar to disk
- [ ] Remove original `markdown.cson` and hope that everything works...
