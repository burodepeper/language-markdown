---
title:
- type: main
  text: My Book
- type: subtitle
  text: An investigation of metadata
creator:
- role: author
  text: John Smith
- role: editor
  text: Sarah Jones
identifier:
- scheme: DOI
  text: doi:10.234234.234/33
publisher:  My Press
rights: © 2007 John Smith, CC BY-NC
...

The above text should be rendered as a `yaml` `front-matter` block, but this bit is regular `Markdown` again. Below is the same `yaml`, but this time as a fenced code block.

```yaml
title:
- type: main
  text: My Book
- type: subtitle
  text: An investigation of metadata
creator:
- role: author
  text: John Smith
- role: editor
  text: Sarah Jones
identifier:
- scheme: DOI
  text: doi:10.234234.234/33
publisher:  My Press
rights: © 2007 John Smith, CC BY-NC
```
