---
title: "Markdown examples"
description: "This is a collection of samples to display the various Markdown elements that are supported by this package."
tags: [ "markdown", "package", "atom", "front-matter" ]
categories:
  - "Grammar"
  - "Markdown"
---



# Markdown examples

To see all that `language-markdown` has to offer, use either [minimal-syntax] or [minimal-syntax-dark]. Your syntax-theme might not support all features.

[minimal-syntax]: https://github.com/burodepeper/minimal-syntax/
[minimal-syntax-dark]: https://github.com/burodepeper/minimal-syntax/



<!---------- Headings --------------------------------------------------------->

#
# Heading 1
## Heading 2 ##
### Heading _three_ ###
#### Heading **four**
##### Heading 5 ##########
###### Heading [six] ###
 ##### Heading 5
  #### Heading 4 ## something, something ####
   ### Heading 3 with a #123 reference inside



<!-- Invalid headings -->

    ## Not a heading
####### Not a heading
#219: a reference
#not-a-heading
\## Not a heading



<!---------- Horizontal rules ------------------------------------------------->

---
*****
* * *
___ ___ ___
- - - - - - -
**  * ** * ** * **
-     -      -      -
_____________________________________



<!-- Invalid horizontal rules -->
--**__--
_ _ _ _ a
a------
---a---
*-*



<!---------- Fenced code blocks ----------------------------------------------->

``````
$something = true;
``````

``` php
<html <?php echo "I am in an HTML tag!"; ?> />

<?php
class Hello {
  function world() {
    echo "Do some stuff and things in PHP...";
  }
}
?>
```

``` javascript
var object = {
  init: function () {
    alert("Hello world!");
  }
}
```

~~~ ruby param=4
def something(x)
  print "I don't know any ruby..."
  return 3
end
~~~

~~~~~~~ ruby startline=3 $%@#$
def foo(x)
  return 3
end
~~~~~~~

~~~ erb
<% wrap_layout :layout do %>
  <article>
    <%= yield %>
  </article>
<% end %>
~~~



<!---------- Lists ------------------------------------------------------------>

123456789. ok
0. ok
003. ok

1. An ordered list item; empty ones look a little different
2.
3. 1. Nested list items
3. 2. > With a quote inside
   3. Or a <html> tag
- An unordered list item, and an empty one
-
- Inline elements are _not a problem_
- # Neither are blocks, such as headings
123) But this one is.
- [ ] This is a task
- [x] This is a completed task
* Asterisk and
+ Plus-sign are also valid
  + [ ] And can be tasks too!
  + [X] And completed ones can have a capital X
1. - 2. foo
3. [ ] A numbered task
4. [x] Another one, but this one is completed



<!-- Invalid list-items -->
-one
2.two
1234567890. not ok
-1. not ok



<!---------- Quotes ----------------------------------------------------------->

> This revolution in something&nbsp;proves to be _something completely different_ and is _not_ **special** _at all!_
>The space at the start is optional; [other](/inline_stuff) is not a problem.
> # Headings can be part of a quote
> > > Nested quotes are possible too



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



<!---------- Autolinks -------------------------------------------------------->

<http://foo.bar.baz>
<http://foo.bar.baz/test?q=hello&id=22&boolean>
<irc://foo.bar:2233/baz>
<MAILTO:FOO@BAR.BAZ>
<http://example.com/\[\>
<foo@bar.example.com>
<foo+special@Bar.baz-bar0.com>



<!-- Invalid auto-links, but possibly parsed by language-html -->
<http://foo.bar/baz bim>
<foo\+@bar.example.com>
<>
<heck://bing.bong>
< http://foo.bar >
<foo.bar.baz>
<localhost:5001/foo>
http://example.com
foo@bar.example.com



<!---------- Inline raw code -------------------------------------------------->
`foo`
`` foo ` bar  ``
` `` `
before`during`after



<!---------- Emphasis --------------------------------------------------------->

A line with *italics* and **bold** fails.
Even _mixing_ the **type** of *markers* is __not enough__.
*f*oo *b*ar baz
**f**oo **b**ar baz
Blah blah _ blah
a * foo bar*
a*"foo"*
5*6*78
5_6_78
**Gomphocarpus (_Gomphocarpus physocarpus_, syn. _Asclepias physocarpa_)**
**foo "*bar*" foo**
*foo [bar](/url)*
foo *\**
_____foo_____
**Github Flavored stuff like @burodepeper and #123 is still highlighted, or :+1: and &amp;**



<!---------- Entities --------------------------------------------------------->

&nbsp; &amp; &copy; &AElig; &Dcaron;
&frac34; &HilbertSpace; &DifferentialD;
&ClockwiseContourIntegral; &ngE;
&#35; &#1234; &#992; &#98765432; &#0;
&#X22; &#XD06; &#xcab;
<a href="&ouml;&ouml;.html">



<!-- Invalid entities, possibly parsed by language-html -->
&nbsp &x; &#; &#x; &ThisIsWayTooLongToBeAnEntityIsntIt; &hi?;
&copy
&MadeUpEntity;



<!---------- Escapes ---------------------------------------------------------->

\!\"\#\$\%\&\'\(\)\*\+\,\-\.\/\:\;\<\=\>\?\@\[\\\]\^\_\`\{\|\}\~
\→\A\a\ \3\φ\«
\*not emphasized*
\<br/> not a tag
\[not a link](/foo)
\`not code`
1\. not a list
\* not a list
\# not a header
\[foo]: /url "not a reference"


foo\
bar

`` \[\` ``
    \[\]
<http://example.com?find=\*>
<a href="/bar\/)">
[foo](/bar\* "ti\*tle")



<!---------- Links, references and images ------------------------------------->

[link](/uri "title")
[link](/uri)
[link]()
[link](<>)
[link](/my uri)
[link](</my uri>)
[link](</my uri> "title")
[link]((foo)and(bar))
[link](<foo(and(bar))>)
[link](#fragment)
[link](http://example.com#fragment)
[link](http://example.com?foo=bar&baz#fragment)
[link](/url "title")
[link](/url 'title')
[link](/url (title))
[link](/url "title "and" title")
[link](/url 'title "and" title')
[link _foo **bar** `#`_](/uri)

At the base is the old friend, Wordpress [update: this is old news, it's running [Statamic](http://www.statamic.com) now. But this still should be interesting].

[foo][bar]
[link _foo **bar** `#`_][ref]
[foo][bar][baz]
![foo *bar*]
![foo *bar*][foobar]
My ![foo bar](/path/to/train.jpg  "title"   )
![foo][]
[![](/image.jpg)](/url)
[![alt](/image.jpg "title")](/url "title")

[bar]: /url "title"
[ref]: /uri
[foo]: /url 'not a title
![foo](/url "title")
![](/url)

\!\[foo]
\![foo]



<!---------- Github flavored markdown ----------------------------------------->

<!-- Mentions -->
@username
@user name
user@name
@username: something, something
@userName123
@user_name
@user-name
@:user:name
@user:name
"@username"
'@username'
(@username)
[@username]
(@username]
>@username
@one, @two, @three
@username=cool
@username.
-@username
- @username
@atom/feedback
@username-

<!-- Issues -->
#123
#12.3
123#456
#123: something, something
#123_456
#123-456
#123-#456
#123:456
"#123"
'#123'
(#123)
[#123]
(#123]
>#123
#123, #456, #789
#123=done
#123.
-#123
#-123
- #123
#123-

<!-- References -->
SHA: a5c3785ed8d6a35868bc169f07e40e889087fd2e
User@SHA: jlord@a5c3785ed8d6a35868bc169f07e40e889087fd2e
User/Repository@SHA: jlord/sheetsee.js@a5c3785ed8d6a35868bc169f07e40e889087fd2e
#Num: #26
GH-Num: GH-26
User#Num: jlord#26 <!-- not supported (yet), too much false positives -->
User/Repository#Num: jlord/sheetsee.js#26

<!-- Emojis -->
:+1:
:david:
:david is awesome:
:arrow_UP:
david:+1:
david :+1:

<!-- Strikethrough -->
~~bad~~ word
~~not-bad~~word
good~~not-bad~~

<!-- Tables -->
| one | two | three |
one | two | three |
| one | two | three
|one|two|three|
| --- | --- | --- |
--- | --- | --- |
| --- | --- | ---
|---|---|---|
|:--- |:---:| ---:|
| :-- | :-: | --: |
| _one_ | **two** | [three] |
| --- | --- | three |



<!---------- CriticMark ------------------------------------------------------>

Lorem ipsum dolor{++ sit++} amet...
Lorem{-- ipsum--} dolor sit amet...
Lorem {~~hipsum~>ipsum~~} dolor sit amet...
Lorem ipsum dolor sit amet.{>>This is a comment<<}
Lorem ipsum dolor sit amet.{>>This is a comment; by @author<<}
Lorem ipsum dolor sit amet, consectetur adipiscing elit. {==Vestibulum at orci magna. Phasellus augue justo, sodales eu pulvinar ac, vulputate eget nulla.==}{>>confusing<<} Mauris massa sem, tempor sed cursus et, semper tincidunt lacus.
I really love {~~_italic_ letters~>**bold** text~~}.



<!---------- Markdown Extra --------------------------------------------------->

That's some text with a footnote.[^1]
[^1]: And that's the footnote.

Apple
:   Pomaceous fruit of plants of the genus Malus in the family Rosaceae.

Orange
: The fruit of an evergreen tree of the genus Citrus.
: Optional second line of definition-list-item

*[NOT]:Not an abbreviation
*[HTML]: Hyper Text Markup Language
*[W3C]:  World Wide Web Consortium

## Header 2, with _emphasis_ ##      {#header2 .main}
## The Site {these=are #not .special} ##
## Even when header is not closed {.class lang=fr}
### Le Site ####{.main .shine #the-site lang=fr}
[link]{.class}
[link](</test url>){.class}
![link]{.class}
[label][reference]{.class}
![label][reference]{.class}
[link](url){#id .class}
![img](url){#id .class lang=fr}
[link](url "title"){#id .class}
[linkref]: url "optional title" {#id .class}
[label](http://www.url.com){.external-link target=_blank}
[linkref]: /url {#id .class}
[![alt](/image.jpg "title"){.class key=value}](/url "title"){.class key=value}

~~~~~~~~~~~~~~~~~~~~~~~~~~~~ .js
alert("Hello world");
~~~~~~~~~~~~~~~~~~~~~~~~~~~~

~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {.js #id .class key=value}
alert("Hello world");
~~~~~~~~~~~~~~~~~~~~~~~~~~~~



<!---------- R Markdown ---------->
```{r label, include=FALSE invalid='abc', results='asis', dev.args=list(bg='yellow', pointsize=10), echo=2:3:-4}
print('hello world')
```
