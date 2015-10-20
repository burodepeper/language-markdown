<!-- http://spec.commonmark.org/0.22/#images -->

<!-- @521 -->
![foo](/url "title")

<!-- @522 -->
![foo *bar*]

[foo *bar*]: train.jpg "train & tracks"

<!-- @523 -->
![foo ![bar](/url)](/url2)

<!-- @524 -->
![foo [bar](/url)](/url2)

<!-- @525 -->
![foo *bar*][]

[foo *bar*]: train.jpg "train & tracks"

<!-- @526 -->
![foo *bar*][foobar]

[FOOBAR]: train.jpg "train & tracks"

<!-- @527 -->
![foo](train.jpg)

<!-- @528 -->
My ![foo bar](/path/to/train.jpg  "title"   )

<!-- @529 -->
![foo](<url>)

<!-- @530 -->
![](/url)

<!-- @531 -->
![foo] [bar]

[bar]: /url

<!-- @532 -->
![foo] [bar]

[BAR]: /url

<!-- @533 -->
![foo][]

[foo]: /url "title"

<!-- @534 -->
![*foo* bar][]

[*foo* bar]: /url "title"

<!-- @535 -->
![Foo][]

[foo]: /url "title"

<!-- @536 -->
![foo]
[]

[foo]: /url "title"

<!-- @537 -->
![foo]

[foo]: /url "title"

<!-- @538 -->
![*foo* bar]

[*foo* bar]: /url "title"

<!-- @539 -->
![[foo]]

[[foo]]: /url "title"

<!-- @540 -->
![Foo]

[foo]: /url "title"

<!-- @541 -->
\!\[foo]

[foo]: /url "title"

<!-- @542 -->
\![foo]

[foo]: /url "title"
