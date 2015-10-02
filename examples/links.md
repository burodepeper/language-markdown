<!-- http://spec.commonmark.org/0.22/#links -->

<!-- http://spec.commonmark.org/0.22/#example-442 -->
[link](/uri "title")

<!-- http://spec.commonmark.org/0.22/#example-443 -->
[link](/uri)

<!-- http://spec.commonmark.org/0.22/#example-444 -->
[link]()

<!-- http://spec.commonmark.org/0.22/#example-445 -->
[link](<>)

<!-- http://spec.commonmark.org/0.22/#example-446 -->
[link](/my uri)

<!-- http://spec.commonmark.org/0.22/#example-447 -->
[link](</my uri>)

<!-- http://spec.commonmark.org/0.22/#example-448 -->
[link](foo
bar)

<!-- http://spec.commonmark.org/0.22/#example-449 -->
[link](<foo
bar>)

<!-- http://spec.commonmark.org/0.22/#example-450 -->
[link]((foo)and(bar))

<!-- http://spec.commonmark.org/0.22/#example-451 -->
[link](foo(and(bar)))

<!-- http://spec.commonmark.org/0.22/#example-452 -->
[link](foo(and\(bar\)))

<!-- http://spec.commonmark.org/0.22/#example-453 -->
[link](<foo(and(bar))>)

<!-- http://spec.commonmark.org/0.22/#example-454 -->
[link](foo\)\:)

<!-- http://spec.commonmark.org/0.22/#example-455 -->
[link](#fragment)

[link](http://example.com#fragment)

[link](http://example.com?foo=bar&baz#fragment)

<!-- http://spec.commonmark.org/0.22/#example-456 -->
[link](foo\bar)

<!-- http://spec.commonmark.org/0.22/#example-457 -->
[link](foo%20b&auml;)

<!-- http://spec.commonmark.org/0.22/#example-458 -->
[link](foo%20b&auml;)

<!-- http://spec.commonmark.org/0.22/#example-459 -->
[link](/url "title")
[link](/url 'title')
[link](/url (title))

<!-- http://spec.commonmark.org/0.22/#example-460 -->
[link](/url "title \"&quot;")

<!-- http://spec.commonmark.org/0.22/#example-461 -->
[link](/url "title "and" title")

<!-- http://spec.commonmark.org/0.22/#example-462 -->
[link](/url 'title "and" title')

<!-- http://spec.commonmark.org/0.22/#example-463 -->
[link](   /uri
  "title"  )

<!-- http://spec.commonmark.org/0.22/#example-464 -->
[link] (/uri)

<!-- http://spec.commonmark.org/0.22/#example-465 -->
[link [foo [bar]]](/uri)

<!-- http://spec.commonmark.org/0.22/#example-466 -->
[link] bar](/uri)

<!-- http://spec.commonmark.org/0.22/#example-467 -->
[link [bar](/uri)

<!-- http://spec.commonmark.org/0.22/#example-468 -->
[link \[bar](/uri)

<!-- http://spec.commonmark.org/0.22/#example-469 -->
[link *foo **bar** `#`*](/uri)

# ----- BOOKMARK ----- #

<!-- http://spec.commonmark.org/0.22/#example-470 -->
[![moon](moon.jpg)](/uri)

<!-- http://spec.commonmark.org/0.22/#example-471 -->
[foo [bar](/uri)](/uri)

<!-- http://spec.commonmark.org/0.22/#example-472 -->
[foo *[bar [baz](/uri)](/uri)*](/uri)

<!-- http://spec.commonmark.org/0.22/#example-473 -->
![[[foo](uri1)](uri2)](uri3)

<!-- http://spec.commonmark.org/0.22/#example-474 -->
*[foo*](/uri)

<!-- http://spec.commonmark.org/0.22/#example-475 -->
[foo *bar](baz*)

<!-- http://spec.commonmark.org/0.22/#example-476 -->
*foo [bar* baz]

<!-- http://spec.commonmark.org/0.22/#example-477 -->
[foo <bar attr="](baz)">

<!-- http://spec.commonmark.org/0.22/#example-478 -->
[foo`](/uri)`

<!-- http://spec.commonmark.org/0.22/#example-479 -->
[foo<http://example.com/?search=](uri)>

<!-- http://spec.commonmark.org/0.22/#example-480 -->
[foo][bar]

[bar]: /url "title"

<!-- http://spec.commonmark.org/0.22/#example-481 -->
[link [foo [bar]]][ref]

[ref]: /uri

<!-- http://spec.commonmark.org/0.22/#example-482 -->
[link \[bar][ref]

[ref]: /uri

<!-- http://spec.commonmark.org/0.22/#example-483 -->
[link *foo **bar** `#`*][ref]

[ref]: /uri

<!-- http://spec.commonmark.org/0.22/#example-484 -->
[![moon](moon.jpg)][ref]

[ref]: /uri

<!-- http://spec.commonmark.org/0.22/#example-485 -->
[foo [bar](/uri)][ref]

[ref]: /uri

<!-- http://spec.commonmark.org/0.22/#example-486 -->
[foo *bar [baz][ref]*][ref]

[ref]: /uri

<!-- http://spec.commonmark.org/0.22/#example-487 -->
*[foo*][ref]

[ref]: /uri

<!-- http://spec.commonmark.org/0.22/#example-488 -->
[foo *bar][ref]

[ref]: /uri

<!-- http://spec.commonmark.org/0.22/#example-489 -->
[foo <bar attr="][ref]">

[ref]: /uri

<!-- http://spec.commonmark.org/0.22/#example-490 -->
[foo`][ref]`

[ref]: /uri

<!-- http://spec.commonmark.org/0.22/#example-491 -->
[foo<http://example.com/?search=][ref]>

[ref]: /uri

<!-- http://spec.commonmark.org/0.22/#example-492 -->
[foo][BaR]

[bar]: /url "title"

<!-- http://spec.commonmark.org/0.22/#example-493 -->
[Толпой][Толпой] is a Russian word.

[ТОЛПОЙ]: /url

<!-- http://spec.commonmark.org/0.22/#example-494 -->
[Foo
  bar]: /url

[Baz][Foo bar]

<!-- http://spec.commonmark.org/0.22/#example-495 -->
[foo] [bar]

[bar]: /url "title"

<!-- http://spec.commonmark.org/0.22/#example-496 -->
[foo]
[bar]

[bar]: /url "title"

<!-- http://spec.commonmark.org/0.22/#example-497 -->
[foo]: /url1

[foo]: /url2

[bar][foo]

<!-- http://spec.commonmark.org/0.22/#example-498 -->
[bar][foo\!]

[foo!]: /url

<!-- http://spec.commonmark.org/0.22/#example-499 -->
[foo][ref[]

[ref[]: /uri

<!-- http://spec.commonmark.org/0.22/#example-500 -->
[foo][ref[bar]]

[ref[bar]]: /uri

<!-- http://spec.commonmark.org/0.22/#example-501 -->
[[[foo]]]

[[[foo]]]: /url

<!-- http://spec.commonmark.org/0.22/#example-502 -->
[foo][ref\[]

[ref\[]: /uri

<!-- http://spec.commonmark.org/0.22/#example-503 -->
[]

[]: /uri

<!-- http://spec.commonmark.org/0.22/#example-504 -->
[
 ]

[
 ]: /uri

<!-- http://spec.commonmark.org/0.22/#example-505 -->
[foo][]

[foo]: /url "title"

<!-- http://spec.commonmark.org/0.22/#example-506 -->
[*foo* bar][]

[*foo* bar]: /url "title"

<!-- http://spec.commonmark.org/0.22/#example-507 -->
[Foo][]

[foo]: /url "title"

<!-- http://spec.commonmark.org/0.22/#example-508 -->
[foo]
[]

[foo]: /url "title"

<!-- http://spec.commonmark.org/0.22/#example-509 -->
[foo]

[foo]: /url "title"

<!-- http://spec.commonmark.org/0.22/#example-510 -->
[*foo* bar]

[*foo* bar]: /url "title"

<!-- http://spec.commonmark.org/0.22/#example-511 -->
[[*foo* bar]]

[*foo* bar]: /url "title"

<!-- http://spec.commonmark.org/0.22/#example-512 -->
[[bar [foo]

[foo]: /url

<!-- http://spec.commonmark.org/0.22/#example-513 -->
[Foo]

[foo]: /url "title"

<!-- http://spec.commonmark.org/0.22/#example-514 -->
[foo] bar

[foo]: /url

<!-- http://spec.commonmark.org/0.22/#example-515 -->
\[foo]

[foo]: /url "title"

<!-- http://spec.commonmark.org/0.22/#example-516 -->
[foo*]: /url

*[foo*]

<!-- http://spec.commonmark.org/0.22/#example-517 -->
[foo][bar]

[foo]: /url1
[bar]: /url2

<!-- http://spec.commonmark.org/0.22/#example-518 -->
[foo][bar][baz]

[baz]: /url

<!-- http://spec.commonmark.org/0.22/#example-519 -->
[foo][bar][baz]

[baz]: /url1
[bar]: /url2

<!-- http://spec.commonmark.org/0.22/#example-520 -->
[foo][bar][baz]

[baz]: /url1
[foo]: /url2
