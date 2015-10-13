# david-splits-grammar

- [x] Restructure `/lib/main.coffee` to make room for combining grammar subrepositories.
- [x] Move and split parts of main grammar repository in to `/grammars/repositories/blocks/*.cson` and `/grammars/repositories/inlines/*.cson`
- [x] Move the basic structure to `/grammars/repositories/markdown.cson`
- [x] Implement `combineGrammarRepositories()`
  - [x] Load basic grammar structure
  - [x] Load all grammar repositories
  - [x] Append grammar repositories to the main repository
  - [x] Write combined grammar to disk
- [ ] Compile grammar when activated by a command that is only available in dev-mode
- [x] Include fenced code blocks as `fenced-code-blocks`, and don't forget its repository
