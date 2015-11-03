# Markdown examples

This document will showcase the various elements of Markdown (and some of its flavors) this package supports. It is both a guide to you, the user, to be educated. And for us, the developer, to see if things still behave as they are supposed to. This is not a complete reference though.

TODO optimum results with [minimal-syntax] and [maximal-ui]

[minimal-syntax]: https://github.com/burodepeper/minimal-syntax/
[maximal-ui]: https://github.com/burodepeper/maximal-ui/



<!---------- Headings --------------------------------------------------------->

#Not a heading
# Heading 1
## Heading 2 ##
### Heading _three_ ###
#### Heading **four**
##### Heading 5 ##########
###### Heading [six] ###
 ##### Heading 5
  #### Heading 4 ## something, something ####
   ### Heading 3
    ## Not a heading



<!---------- Horizontal rules ------------------------------------------------->

---
*****
___ ___ ___
- - - - - - -

Combinations are not valid:
-*__-


<!---------- Fenced code blocks ----------------------------------------------->

``````
$something = true;
``````

``` javascript
var object = {
  init: function () {
    alert("Hello world!");
  }
}
```

~~~ ruby version=4
def something:
  print "I don't know any ruby..."
~~~



<!---------- Lists ------------------------------------------------------------>

1. An ordered list item; empty ones look a little different
2.
3. 1. Nested list items
3. > Or with a quote inside
- An unordered list item, and an empty one
-
- Inline elements are _not a problem_
-Not a list item
1.This one neither
123) But this one is.
- [ ] This is a task
- [x] This is a completed task



<!---------- Quotes ----------------------------------------------------------->

> This revolution in something&nbsp;proves to be _something completely different_ and is not **special** at all!
>The space at the start is optional. But [other](/inline_stuff) is not a problem.



<!---------- HTML (and comments) ---------------------------------------------->

The [language-html] package is included by default (if you have it installed) so that gives you the opportunity to add <!-- comments to Markdown documents -->, which are actually just HTML comments. And it also allows to just put HTML-tags just about anywhere. You can even mix in inline styles with your HTML. Let's try some:

<article id='document-123' class='article news'>
  <header>
    <h1>Embedded HTML in Markdown documents</h1>
    <p class='intro'>This revolution in something proves to be _something completely different_ and is not special at all!</p>
  </header>
  <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. _Duis aute irure dolor in reprehenderit in voluptate velit esse **cillum dolore** eu fugiat nulla pariatur._ Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. [read more](/link-to-someplace)</p>
</article>

<style type='text/css'>
article.article { color:red; }
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
