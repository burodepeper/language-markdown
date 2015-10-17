# language-markdown

## Status

| Flavor         | Section                     |     Specs | Status |
| -------------- | --------------------------- | --------: | ------ |
| Core: blocks   | Horizontal rules            |  27 of 27 | Good   |
| Core: blocks   | ATX Headings                |  23 of 23 | Good   |
| Core: blocks   | Fenced code blocks          |  25 of 27 | Good   |
| Core: blocks   | Links reference definitions |  21 of 23 | Good   |
| Core: blocks   | Block quotes                |  25 of 25 | Good   |
| Core: blocks   | Lists                       |  33 of 34 | Good   |
| Core: inlines  | Backslash escapes           |   5 of 13 | OK     |
| Core: inlines  | Entities                    |   7 of 12 | Good   |
| Core: inlines  | Code spans                  |  12 of 15 | Good   |
| Core: inlines  | Emphasis                    | 77 of 130 | OK     |
| Core: inlines  | Links                       |  26 of 43 | OK     |
| Core: inlines  | Images                      |      TODO | OK     |
| Core: inlines  | Autolinks                   |  16 of 16 | Good   |
| Core: inlines  | Line-breaks                 |      TODO | Good   |
| Github         | Mentions                    |  22 of 22 | Good   |
| Github         | Issues                      |  21 of 22 | Good   |
| Github         | Emojis                      |      TODO | Good   |
| Github         | Strikethrough               |      TODO | Good   |
| Github         | Tables                      |      TODO | Good   |
| CriticMark     | Annotation                  |      TODO | Good   |
| YAML           | Front matter                |    3 of 3 | Good   |

Number of tests: **382** (1712 assertions)

### Notes

- Raw `html` is included when you have `language-html` installed.
- The Github `task-lists` are implemented as a part of unordered-lists.
- Setext-headers (underlined-headers) are not supported.
- Indented-code-blocks have been disabled to prevent false-positives.
- Github tables require pipes at the start of each line

### References

- http://spec.commonmark.org/0.22/
- https://help.github.com/articles/github-flavored-markdown/
- https://github.com/CriticMarkup/CriticMarkup-toolkit/
- http://jekyllrb.com/docs/frontmatter/
- http://pandoc.org/README.html#epub-metadata
