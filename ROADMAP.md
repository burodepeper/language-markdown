# Roadmap

## Current focus

- [ ] Improve syntax-highlighting in combination with default syntax-themes
- [ ] Check if `language-gfm` is activated and notify user of possible conflicts
- [ ] Keybinding for toggling task-list-items

## Ideas for a brighter future

- [ ] Keybindings for (strong) emphasis; see [language-gfm/issues/94]
- [ ] Create an abstracted function to recursively index files inside a directory with a certain extension, while retaining a relative path; method is currently used to load fixtures in spec, but can also be used to load all cson files when compiling the grammar file.
- [ ] Show an index of headings found in the current document, possibility in a side panel
- [ ] `linter-markdown`
  - [ ] Check if link-labels have a matching reference
- [ ] Add support for `erb` to fenced-code-blocks (#43)
- [ ] Add support for `php` to fenced-code-blocks (#22)
