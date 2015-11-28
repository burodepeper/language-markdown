---
title: "Markdown examples"
---

# Markdown examples, _italic_, [label], @reference #

To see all that `language-markdown` has to offer, use either [minimal-syntax](https://github.com/burodepeper/minimal-syntax/).

<!---------- Examples --------------------------------------------------------->

#219: a reference
\## Not a heading
---
**  * ** * ** * **

``````
$something = true;
``````

~~~ ruby param=4
def something(x)
  print "I don't know any ruby..."
  return 3
end
~~~

123456789. ok
1. ok
007. James Bond
12) twelve
13)

- [ ] > Quote
- [ ] <html>
- [ ] # header
- [x] Completed task

> # Heading inside a quote
> And some regular&nbsp;text. Some things are _italic_ or **bold**, or even [links](/to/somewhere/else)

<article id='document-123' class='article news'>
  <header>
    <h1>Embedded **HTML** in _Markdown_ documents</h1>
  </header>
</article>

<style type='text/css'>
div.class { color:red; }
</style>

<script>
document.getElementById("document-123").setAttribute("awesome", true);
</script>

<http://www.autolink.com>
<person@email.com>

`foo`
`` foo ` bar  ``

A line with *italics* and **bold** fails.
Even _mixing_ the **type** of *markers* is __not enough__.
*foo [bar](/url)*
foo *\**
_____foo_____

<a href="&ouml;&ouml;.html">

&nbsp

[link](/uri "title")
[link](</my uri>)
[link](</my uri> "title")
[link _foo **bar** `#`_](/uri)
[foo][bar]
[foo][bar][baz]
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

@username
@username: something, something
@one, @two, @three
"@username"

#123
#123: something, something
"#123"
#123, #456, #789

a5c3785ed8d6a35868bc169f07e40e889087fd2e
jlord/sheetsee.js@a5c3785ed8d6a35868bc169f07e40e889087fd2e
GH-26
jlord/sheetsee.js#26

:+1:
david :+1:
~~bad~~ word

| one | two | three |
|one|two|three|
| --- | --- | --- |
--- | --- | --- |
|:--- |:---:| ---:|
| _one_ | **two** | [three] |

Lorem ipsum dolor{++ sit++} amet...
Lorem{-- ipsum--} dolor sit amet...
Lorem {~~hipsum~>ipsum~~} dolor sit amet...
Lorem ipsum dolor sit amet.{>>This is a comment; by @author<<}
Lorem ipsum dolor sit amet, consectetur adipiscing elit. {==Vestibulum at orci magna. Phasellus augue justo, sodales eu pulvinar ac, vulputate eget nulla.==}{>>confusing<<} Mauris massa sem, tempor sed cursus et, semper tincidunt lacus.
I really love {~~_italic_ letters~>**bold** text~~}.

That's some text with a footnote.[^1]
[^1]: And that's the footnote.

Orange
: The fruit of an evergreen tree of the genus Citrus.

*[HTML]: Hyper Text Markup Language

### Header ### {.class #id key=value}
![img](url){#id .class lang=fr}
[label](http://www.url.com){.external-link target=_blank}
[![alt](/image.jpg "title"){.class key=value}](/url "title"){.class key=value}

~~~~~~~~~~~~~~~~~~~~~~~~~~~~ {.js #id .class key=value}
alert("Hello world");
~~~~~~~~~~~~~~~~~~~~~~~~~~~~
