# Roadmap

## Current focus

- [ ] Improve syntax-highlighting in combination with default syntax-themes
  - **Atom Dark/Light**
    - [ ] # Heading
    - [ ] _italic_
    - [ ] `inline-code`
    - [ ] [label](link)
    - [ ] [label]: /url "title"
    - [ ] ---
    - [ ] any list-item (or at least the punctuation)
    - [ ] > Quote
    - [ ] **bold**
    - [ ] <http://www.autolink.com> (outside of list-item)
    - [ ] ~~strike~~
    - [ ] Criticmark: everything except comments
    - [ ] .class and #id in special-attributes
  - **One Dark**
    - [ ] ---
    - [ ] any list-item (or at least the punctuation)
    - [ ] ~~strike~~
  - **One Light**
    - [ ] # Heading
    - [ ] [label](link)
    - [ ] [label]: /url "title"
    - [ ] ---
    - [ ] <http://www.autolink.com> (outside of list-item)
    - [ ] ~~strike~~
  - **base16 tomorrow (dark)**
  - **base16 tomorrow (light)**
  - **Solarized (dark)**
  - **Solarized (light)**
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
