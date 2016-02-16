# language-markdown

**Note**: this file is not up-to-date, but kept around for whatever reasons

## Status

| Flavor      | Section                     | Specs     | Status |
| ----------- | --------------------------- | --------: | ------ |
| CM: blocks  | Horizontal rules            |  20 of 20 | Good   |
| CM: blocks  | ATX Headings                |  19 of 19 | Good   |
| CM: blocks  | Fenced code blocks          |  17 of 18 | Good   |
| CM: blocks  | Links reference definitions |  19 of 21 | Good   |
| CM: blocks  | Block quotes                |  13 of 13 | Good   |
| CM: blocks  | Lists                       |  15 of 16 | Good   |
| CM: inlines | Backslash escapes           |   5 of 13 | OK     |
| CM: inlines | Entities                    |   7 of 12 | Good   |
| CM: inlines | Code spans                  |  13 of 17 | Good   |
| CM: inlines | Emphasis                    | 78 of 130 | OK     |
| CM: inlines | Links                       |  38 of 72 | OK     |
| CM: inlines | Images                      |   7 of 15 | OK     |
| CM: inlines | Autolinks                   |  16 of 16 | Good   |
| CM: inlines | Line-breaks                 |  15 of 15 | Good   |
| Github      | Mentions                    |  22 of 22 | Good   |
| Github      | Issues                      |  21 of 22 | Good   |
| Github      | References                  |    5 of 5 | Good   |
| Github      | Emojis                      |    6 of 6 | Good   |
| Github      | Strikethrough               |    3 of 3 | Good   |
| Github      | Tables                      |  12 of 12 | Good   |
| Github      | Task lists                  |  10 of 10 | Good   |
| CriticMark  | Annotation                  |    7 of 7 | Good   |
| YAML/TOML   | Front matter                |    3 of 3 | Good   |
| MD Extra    | -                           |  12 of 12 | Good   |

Total number of tests: **452**

### Notes

- Raw `html` is included when you have `language-html` installed.
- The Github `task-lists` are implemented as a part of unordered-lists.
- Setext-headers (underlined-headers) are not supported.
- Indented-code-blocks have been disabled to prevent false-positives.
- Github tables require pipes at the start of each line, and cells need a padding of at least one space.

### References

- http://spec.commonmark.org/0.22/
- https://help.github.com/articles/github-flavored-markdown/
- https://github.com/CriticMarkup/CriticMarkup-toolkit/
- http://jekyllrb.com/docs/frontmatter/
- http://pandoc.org/README.html#epub-metadata
- http://pandoc.org/demo/example9/pandocs-markdown.html
