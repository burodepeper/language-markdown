<!-- http://spec.commonmark.org/0.22/#fenced-code-blocks -->

@77
```
<
 >
```

@78
~~~
<
 >
~~~

@79
```
aaa
~~~
```

@80
~~~
aaa
```
~~~

@81
````
aaa
```
``````

````
<!-- negate -->

@82
~~~~
aaa
~~~
~~~~

@83
```

```
<!-- negate -->

@84
`````

```
aaa

`````
<!-- negate -->

@85
> ```
> aaa

bbb

@86
```


```

@87
```
```

@88
 ```
 aaa
aaa
```

@89
  ```
aaa
  aaa
aaa
  ```

@90
   ```
   aaa
    aaa
  aaa
   ```

@91
    ```
    aaa
    ```

@92
```
aaa
  ```

@93
   ```
aaa
  ```

@94
```
aaa
    ```

```
<!-- negate -->

@95
``` ```
aaa

@96
~~~~~~
aaa
~~~ ~~

~~~~~~
<!-- negate -->

@97
foo
```
bar
```
baz

@98
foo
---
~~~
bar
~~~
# baz

@99
```ruby
def foo(x)
  return 3
end
```

@100
~~~~    ruby startline=3 $%@#$
def foo(x)
  return 3
end
~~~~~~~

~~~~~~~
<!-- negate -->

~~~~    ruby startline=3 $%@#$
def foo(x)
  return 3
end
~~~~

~~~~
<!-- negate -->

@101
````;
````

````
<!-- negate -->

@102
``` aa ```
foo

@103
```
``` aaa
```
