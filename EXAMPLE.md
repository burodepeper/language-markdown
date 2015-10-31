# Markdown examples

This document will showcase the various elements of Markdown (and some of its flavors) this package supports. It is both a guide to you, the user, to be educated. And for us, the developer, to see if things still behave as they are supposed to. This is not a complete reference though.

TODO optimum results with [minimal-syntax] and [maximal-ui]

[minimal-syntax]: https://github.com/burodepeper/minimal-syntax/
[maximal-ui]: https://github.com/burodepeper/maximal-ui/

----------------

## Blocks

- Headings
- Horizontal rules
- Fenced code blocks
- Lists
- Quotes
- HTML (and comments)

### TODO Headings

### Horizontal rules

You can use horizontal rules (the equivalent of the html `<hr>`) to add a horizontal separator to your document. A horizontal rule is made up of three or more dashes `-`. It is also possible to use underscores `_` or asterisks `*` for this purpose, but I prefer dashes.

---

***

___

### TODO Fenced code blocks

### TODO Lists

### TODO Quotes

### HTML (and comments)

The [language-html] package is included by default (if you have it installed) so that gives you the opportunity to add <!-- comments to Markdown documents -->, which are actually just HTML comments. And it also allows to just put HTML-tags just about anywhere. You can even mix in inline styles with your HTML. Let's try some:

<article id='document-123' class='article news'>
  <header>
    <h1>Embedded HTML in Markdown documents</h1>
    <p class='intro'>This revolution in something proves to be _something completely different_ and is not special at all!</p>
  </header>
  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. _Duis aute irure dolor in reprehenderit in voluptate velit esse **cillum dolore** eu fugiat nulla pariatur._ Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. [read more](/link-to-someplace)</p>
</article>

I believe it will even support inline _CSS_ and _Javascript_. Let's give that a try:

<style type='text/css'>
article.article {
  color: red;
}
</style>

<script>
document.getElementById("document-123").setAttribute("awesome", true);
</script>

----------------

## TODO Inlines

----------------

## Flavors

### TODO Github

### TODO CriticMark

### TODO YAML front-matter
