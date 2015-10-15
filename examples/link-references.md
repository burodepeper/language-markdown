<!-- http://spec.commonmark.org/0.22/#link-reference-definitions -->

<!-- http://spec.commonmark.org/0.22/#example-146 -->
[foo]: /url "title"

[foo]

<!-- http://spec.commonmark.org/0.22/#example-147 -->
[foo]:
   /url
        'the title'

[foo]

<!-- http://spec.commonmark.org/0.22/#example-148 -->
[Foo*bar\]]:my_(url) 'title (with parens)'

[Foo*bar\]]

<!-- http://spec.commonmark.org/0.22/#example-149 -->
[Foo bar]:
<my url>
'title'

[Foo bar]

<!-- http://spec.commonmark.org/0.22/#example-150 -->
[foo]: /url '
title
line1
line2
'

[foo]

<!-- http://spec.commonmark.org/0.22/#example-151 -->
[foo]: /url 'title

with blank line'

[foo]

<!-- http://spec.commonmark.org/0.22/#example-152 -->
[foo]:
/url

[foo]

<!-- http://spec.commonmark.org/0.22/#example-153 -->
[foo]:

[foo]

<!-- http://spec.commonmark.org/0.22/#example-154 -->
[foo]: /url\bar\*baz "foo\"bar\baz"

[foo]

<!-- http://spec.commonmark.org/0.22/#example-155 -->
[foo]

[foo]: url

<!-- http://spec.commonmark.org/0.22/#example-156 -->
[foo]

[foo]: first
[foo]: second

<!-- http://spec.commonmark.org/0.22/#example-157 -->
[FOO]: /url

[Foo]

<!-- http://spec.commonmark.org/0.22/#example-158 -->
[ΑΓΩ]: /φου

[αγω]

<!-- http://spec.commonmark.org/0.22/#example-159 -->
[foo]: /url

<!-- http://spec.commonmark.org/0.22/#example-160 -->
[
foo
]: /url
bar

<!-- http://spec.commonmark.org/0.22/#example-161 -->
[foo]: /url "title" ok

<!-- http://spec.commonmark.org/0.22/#example-162 -->
[foo]: /url
"title" ok

<!-- http://spec.commonmark.org/0.22/#example-163 -->
    [foo]: /url "title"

[foo]

<!-- http://spec.commonmark.org/0.22/#example-164 -->
```
[foo]: /url
```

[foo]

<!-- http://spec.commonmark.org/0.22/#example-165 -->
Foo
[bar]: /baz

[bar]

<!-- http://spec.commonmark.org/0.22/#example-166 -->
# [Foo]
[foo]: /url
> bar

<!-- http://spec.commonmark.org/0.22/#example-167 -->
[foo]: /foo-url "foo"
[bar]: /bar-url
  "bar"
[baz]: /baz-url

[foo],
[bar],
[baz]

<!-- http://spec.commonmark.org/0.22/#example-168 -->
[foo]

> [foo]: /url
