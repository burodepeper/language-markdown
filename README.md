# Markdown grammar [![Build Status](https://travis-ci.org/burodepeper/language-markdown.svg?branch=master)](https://travis-ci.org/burodepeper/language-markdown)

The intention of this package is to provide an alternative to [language-gfm]() by providing an implementation that intends to follow the [CommonMark](http://www.commonmark.org/) specifications as reasonable as possible.

An additional aim is to provide support for _additional flavors_ (such as Github, Pandoc, CriticMark, etc.) and to allow the user to dynamically select which to use, and which not.

---

### Limitations

Unfortunately however, because of the way Atom handles/parses grammar, it is impossible or simply unrealistic to fully and consistently implement the specs as provided. This has forced us to make a few decisions in certain areas. Our _focus_ is to support **actual real-life use-cases** instead of blindly following overly specific rules. The _aim_ of this language-pack therefor is to support the user in writing Markdown files, and _not_ to be a perfect representation of them.

Following is list of areas that are limited in their implementation/support. A more detailed explanation can be found further down in this document.

- **Setext headers** are not implemented.
- **Indented code blocks** are implemented, but disabled in favor of fenced-code-blocks.
- **Complex nested emphasis** is a female dog.
- **Multiline inlines** have been partially disabled.
- **Fenced code blocks** require matching opening and closing markers.

If you experience any issue that is above a reasonable/tolerable level of annoyancy, don't hesitate to [create an issue](issues/new/) or contact us directly.

---

### Current status

**Usable**, but with some caveats.

Our scope-names are still purely semantic, so there's a good chance that your syntax theme won't fully support this package. If you don't mind a light syntax theme, give [minimal-syntax](https://atom.io/packages/minimal-syntax) a try. It is updated parallel to development to support all of our development scopes.

#### Detailed status

| Flavor | Section | Grammar | Specs | Usable? |
| ------ | ------- | ------- | ----- | ------- |
| Core (blocks) | Horizontal rules | complete | 27 of 27 | Good |
| Core (blocks) | (ATX) Headings | complete | 23 of 23 | Good |
| Core (blocks) | Fenced code blocks | _beta_ | 25 of 27 | Okay |
| Core (blocks) | Links reference definitions | _beta_ | 21 of 23 | Good |
| Core (blocks) | Block quotes | complete | 25 of 25 | Good |
| Core (blocks) | Lists | complete | 33 of 34 | Good |
| Core (inlines) | Backslash escapes | _alpha_ | 5 of 13 | Okay |
| Core (inlines) | Entities | _alpha_ | 7 of 12 | Good |
| Core (inlines) | Code spans | _beta_ | 12 of 15 | Good |
| Core (inlines) | Emphasis | _alpha_ | 77 of 130 | Limited |
| Core (inlines) | Links | _alpha_ | 26 of 43 | Okay |
| Core (inlines) | Images | _beta_ | - | Okay |
| Core (inlines) | Autolinks | complete | 16 of 16 | Good |
| Core (inlines) | Raw HTML | included | - | Good |
| Core (inlines) | Line-breaks | _alpha_ | - | Okay |
| Github | Mentions | _beta_ | - | Good |
| Github | Issues | _beta_ | - | Good |
| Github | Emojis | - | - | - |
| Github | Strikethrough | - | - | - |
| Github | Tables | _beta_ | - | Good |
| CriticMark | Annotation | _beta_ | - | Good |

##### Notes

- The Github task-lists are implemented as an extention of unordered lists

##### References

- http://spec.commonmark.org/0.22/
- https://help.github.com/articles/github-flavored-markdown/
- https://github.com/CriticMarkup/CriticMarkup-toolkit/

#### Additional features

| Feature | Status |
| ------- | ------ |
| Dynamic grammar selection | _on hold_ |
| Less verbose specs | _in beta_ |
| Improved fenced code blocks | _on hold_ |

---

### Reasoning behind limitations

This language-pack is merely a tool. Its function is to add semantic markup to text, so that a syntax-theme is able to style it. Unfortunately, as mentioned earlier, we have to do this in an environment and with tools that aren't completely in our control. So the best we can achieve is a representation that is as close to _the real thing_ as possible.

Markdown is a tool to add semantics to text (without having to code) and not to design that text. It is a productivity tool, and as such, the tool itself _shouldn't be in the way_ of what you want to do with it. As an example, you don't want a single * in a line of text to mark the entire document after it as emphasized, until it finds a matching partner. That would be a bit silly, wouldn't it?

**Setext headers** are simply impossible to detect. But a heading followed by a horizontal rule is a good alternative. At least it doesn't break anything.

**Indented code blocks** are implemented, but have been disabled. The CommonMark specs define certain kinds of blocks, or groups of lines. Atom allows us to parse the content line by line, and as such, we don't know whether two list-items are part of the same list. Because of that, we can't separate text that just happens to be indented by four spaces (as part of a nested list) from text that is intentionally indented to represent a code block. The good thing is that there is an excellent alternative in _fenced code blocks_ so we don't feel bad about disabling indented code blocks.

**Complex nested emphasis** is amongst the worst things in existence. On one hand the regular expressions together to make it work, but on the other hand, the idea that anybody would want to use nested emphasis. In my more than ten thousands days I've lived on this planet, I have never come across something that needed nested emphasis. Prove me wrong, but I think that when you are nesting emphasis, you are designing your document. Please leave that to a designer, and limit your emphasis to _emphasis_ and **strong emphasis**.

**Multiline inlines** are another interesting paradox, and it partly overlaps with nested emphasis. Why? If you have five paragraphs of text, and you want to strike through from halfway the first to halfway the fifth, perhaps striking through isn't the solution. The _CriticMark_ styles have been allowed to be weird like this btw, because they have such a specific purpose.

If you don't agree with any of the reasoning above, feel free to convince us of your obviously better perspective. ;)
