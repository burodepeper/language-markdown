# language-markdown

## Status

| Flavor      | Section                     | Specs     | Status |
| ----------- | --------------------------- | --------: | ------ |
| CM: blocks  | Horizontal rules            |  27 of 27 | Good   |
| CM: blocks  | ATX Headings                |  23 of 23 | Good   |
| CM: blocks  | Fenced code blocks          |  25 of 27 | Good   |
| CM: blocks  | Links reference definitions |  21 of 23 | Good   |
| CM: blocks  | Block quotes                |  25 of 25 | Good   |
| CM: blocks  | Lists                       |  33 of 34 | Good   |
| CM: inlines | Backslash escapes           |   5 of 13 | OK     |
| CM: inlines | Entities                    |   7 of 12 | Good   |
| CM: inlines | Code spans                  |  12 of 15 | Good   |
| CM: inlines | Emphasis                    | 77 of 130 | OK     |
| CM: inlines | Links                       |  51 of 85 | OK     |
| CM: inlines | Images                      |  14 of 22 | OK     |
| CM: inlines | Autolinks                   |  16 of 16 | Good   |
| CM: inlines | Line-breaks                 |  17 of 17 | Good   |
| Github      | Mentions                    |  22 of 22 | Good   |
| Github      | Issues                      |  21 of 22 | Good   |
| Github      | Emojis                      |    6 of 6 | Good   |
| Github      | Strikethrough               |    3 of 3 | Good   |
| Github      | Tables                      |      TODO | Good   |
| CriticMark  | Annotation                  |      TODO | Good   |
| YAML        | Front matter                |    3 of 3 | Good   |

Total number of tests: **454**

### Notes

- Raw `html` is included when you have `language-html` installed.
- The Github `task-lists` are implemented as a part of unordered-lists.
- Setext-headers (underlined-headers) are not supported.
- Indented-code-blocks have been disabled to prevent false-positives.
- Github tables require pipes at the start of each line.

### References

- http://spec.commonmark.org/0.22/
- https://help.github.com/articles/github-flavored-markdown/
- https://github.com/CriticMarkup/CriticMarkup-toolkit/
- http://jekyllrb.com/docs/frontmatter/
- http://pandoc.org/README.html#epub-metadata
