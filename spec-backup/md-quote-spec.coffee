describe 'Markdown grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-markdown')

    runs ->
      grammar = atom.grammars.grammarForScopeName('text.md')

  # http://spec.commonmark.org/0.22/#block-quotes
  it 'tokenizes quotes', ->

    # http://spec.commonmark.org/0.22/#example-178
    tokens = grammar.tokenizeLines('> # Foo\n> bar\n> baz')
    expect(tokens[0][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[0][2]).toEqual value: '#', scopes: ['text.md', 'quote.md', 'heading.md', 'heading-1.md', 'punctuation.md']
    expect(tokens[0][3]).toEqual value: ' ', scopes: ['text.md', 'quote.md', 'heading.md', 'heading-1.md']
    expect(tokens[0][4]).toEqual value: 'Foo', scopes: ['text.md', 'quote.md', 'heading.md', 'heading-1.md']
    expect(tokens[1][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[1][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[1][2]).toEqual value: 'bar', scopes: ['text.md', 'quote.md']
    expect(tokens[2][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[2][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[2][2]).toEqual value: 'baz', scopes: ['text.md', 'quote.md']

    # http://spec.commonmark.org/0.22/#example-179
    tokens = grammar.tokenizeLines('># Foo\n>bar\n> baz')
    expect(tokens[0][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: '#', scopes: ['text.md', 'quote.md', 'heading.md', 'heading-1.md', 'punctuation.md']
    expect(tokens[0][2]).toEqual value: ' ', scopes: ['text.md', 'quote.md', 'heading.md', 'heading-1.md']
    expect(tokens[0][3]).toEqual value: 'Foo', scopes: ['text.md', 'quote.md', 'heading.md', 'heading-1.md']
    expect(tokens[1][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[1][1]).toEqual value: 'bar', scopes: ['text.md', 'quote.md']
    expect(tokens[2][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[2][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[2][2]).toEqual value: 'baz', scopes: ['text.md', 'quote.md']

    # http://spec.commonmark.org/0.22/#example-180
    tokens = grammar.tokenizeLines('   > # Foo\n   > bar\n > baz')
    expect(tokens[0][0]).toEqual value: '   ', scopes: ['text.md', 'quote.md']
    expect(tokens[0][1]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][2]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[0][3]).toEqual value: '#', scopes: ['text.md', 'quote.md', 'heading.md', 'heading-1.md', 'punctuation.md']
    expect(tokens[0][4]).toEqual value: ' ', scopes: ['text.md', 'quote.md', 'heading.md', 'heading-1.md']
    expect(tokens[0][5]).toEqual value: 'Foo', scopes: ['text.md', 'quote.md', 'heading.md', 'heading-1.md']
    expect(tokens[1][0]).toEqual value: '   ', scopes: ['text.md', 'quote.md']
    expect(tokens[1][1]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[1][2]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[1][3]).toEqual value: 'bar', scopes: ['text.md', 'quote.md']
    expect(tokens[2][0]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[2][1]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[2][2]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[2][3]).toEqual value: 'baz', scopes: ['text.md', 'quote.md']

    # http://spec.commonmark.org/0.22/#example-181
    tokens = grammar.tokenizeLines('    > # Foo\n    > bar\n    > baz')
    expect(tokens[0][0]).toEqual value: '    > # Foo', scopes: ['text.md']
    expect(tokens[1][0]).toEqual value: '    > bar', scopes: ['text.md']
    expect(tokens[2][0]).toEqual value: '    > baz', scopes: ['text.md']

    # http://spec.commonmark.org/0.22/#example-182
    tokens = grammar.tokenizeLines('> # Foo\n> bar\nbaz')
    expect(tokens[0][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[0][2]).toEqual value: '#', scopes: ['text.md', 'quote.md', 'heading.md', 'heading-1.md', 'punctuation.md']
    expect(tokens[0][3]).toEqual value: ' ', scopes: ['text.md', 'quote.md', 'heading.md', 'heading-1.md']
    expect(tokens[0][4]).toEqual value: 'Foo', scopes: ['text.md', 'quote.md', 'heading.md', 'heading-1.md']
    expect(tokens[1][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[1][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[1][2]).toEqual value: 'bar', scopes: ['text.md', 'quote.md']
    expect(tokens[2][0]).toEqual value: 'baz', scopes: ['text.md']

    # http://spec.commonmark.org/0.22/#example-183
    tokens = grammar.tokenizeLines('> bar\nbaz\n> foo')
    expect(tokens[0][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[0][2]).toEqual value: 'bar', scopes: ['text.md', 'quote.md']
    expect(tokens[1][0]).toEqual value: 'baz', scopes: ['text.md']
    expect(tokens[2][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[2][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[2][2]).toEqual value: 'foo', scopes: ['text.md', 'quote.md']

    # http://spec.commonmark.org/0.22/#example-184
    tokens = grammar.tokenizeLines('> foo\n---')
    expect(tokens[0][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[0][2]).toEqual value: 'foo', scopes: ['text.md', 'quote.md']
    expect(tokens[1][0]).toEqual value: '---', scopes: ['text.md', 'hr.md']

    # http://spec.commonmark.org/0.22/#example-185
    tokens = grammar.tokenizeLines('> - foo\n- bar')
    expect(tokens[0][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[0][2]).toEqual value: '-', scopes: ['text.md', 'quote.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[0][3]).toEqual value: ' ', scopes: ['text.md', 'quote.md', 'unordered.list.md']
    expect(tokens[0][4]).toEqual value: 'foo', scopes: ['text.md', 'quote.md', 'unordered.list.md']
    expect(tokens[1][0]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[1][1]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[1][2]).toEqual value: 'bar', scopes: ['text.md', 'unordered.list.md']

    # http://spec.commonmark.org/0.22/#example-186
    tokens = grammar.tokenizeLines('>    foo\n    bar')
    expect(tokens[0][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[0][2]).toEqual value: '   foo', scopes: ['text.md', 'quote.md']
    expect(tokens[1][0]).toEqual value: '    bar', scopes: ['text.md']

    # http://spec.commonmark.org/0.22/#example-187
    tokens = grammar.tokenizeLines('> ```\nfoo\n```')
    expect(tokens[0][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[0][2]).toEqual value: '```', scopes: ['text.md', 'quote.md', 'fenced.code.md', 'punctuation.md']
    expect(tokens[1][0]).toEqual value: 'foo', scopes: ['text.md']
    expect(tokens[2][0]).toEqual value: '```', scopes: ['text.md', 'fenced.code.md', 'punctuation.md']

    # http://spec.commonmark.org/0.22/#example-188
    tokens = grammar.tokenizeLines('> foo\n    - bar')
    expect(tokens[0][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[0][2]).toEqual value: 'foo', scopes: ['text.md', 'quote.md']
    expect(tokens[1][0]).toEqual value: '    ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[1][1]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[1][2]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[1][3]).toEqual value: 'bar', scopes: ['text.md', 'unordered.list.md']

    # http://spec.commonmark.org/0.22/#example-189
    {tokens} = grammar.tokenizeLine('>')
    expect(tokens[0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']

    # http://spec.commonmark.org/0.22/#example-190
    tokens = grammar.tokenizeLines('>\n>\n>')
    expect(tokens[0][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[1][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[2][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']

    # http://spec.commonmark.org/0.22/#example-191
    tokens = grammar.tokenizeLines('>\n> foo\n>')
    expect(tokens[0][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[1][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[1][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[1][2]).toEqual value: 'foo', scopes: ['text.md', 'quote.md']
    expect(tokens[2][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']

    # http://spec.commonmark.org/0.22/#example-192
    tokens = grammar.tokenizeLines('> foo\n\n> bar')
    expect(tokens[0][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[0][2]).toEqual value: 'foo', scopes: ['text.md', 'quote.md']
    expect(tokens[1][0]).toEqual value: '', scopes: ['text.md']
    expect(tokens[2][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[2][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[2][2]).toEqual value: 'bar', scopes: ['text.md', 'quote.md']

    # http://spec.commonmark.org/0.22/#example-193
    tokens = grammar.tokenizeLines('> foo\n> bar')
    expect(tokens[0][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[0][2]).toEqual value: 'foo', scopes: ['text.md', 'quote.md']
    expect(tokens[1][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[1][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[1][2]).toEqual value: 'bar', scopes: ['text.md', 'quote.md']

    # http://spec.commonmark.org/0.22/#example-194
    tokens = grammar.tokenizeLines('> foo\n>\n> bar')
    expect(tokens[0][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[0][2]).toEqual value: 'foo', scopes: ['text.md', 'quote.md']
    expect(tokens[1][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[2][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[2][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[2][2]).toEqual value: 'bar', scopes: ['text.md', 'quote.md']

    # http://spec.commonmark.org/0.22/#example-195
    tokens = grammar.tokenizeLines('foo\n> bar')
    expect(tokens[0][0]).toEqual value: 'foo', scopes: ['text.md']
    expect(tokens[1][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[1][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[1][2]).toEqual value: 'bar', scopes: ['text.md', 'quote.md']

    # http://spec.commonmark.org/0.22/#example-196
    tokens = grammar.tokenizeLines('> aaa\n***\n> bbb')
    expect(tokens[0][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[0][2]).toEqual value: 'aaa', scopes: ['text.md', 'quote.md']
    expect(tokens[1][0]).toEqual value: '***', scopes: ['text.md', 'hr.md']
    expect(tokens[2][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[2][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[2][2]).toEqual value: 'bbb', scopes: ['text.md', 'quote.md']

    # http://spec.commonmark.org/0.22/#example-197
    tokens = grammar.tokenizeLines('> bar\nbaz')
    expect(tokens[0][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[0][2]).toEqual value: 'bar', scopes: ['text.md', 'quote.md']
    expect(tokens[1][0]).toEqual value: 'baz', scopes: ['text.md']

    # http://spec.commonmark.org/0.22/#example-198
    tokens = grammar.tokenizeLines('> bar\n\nbaz')
    expect(tokens[0][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[0][2]).toEqual value: 'bar', scopes: ['text.md', 'quote.md']
    expect(tokens[1][0]).toEqual value: '', scopes: ['text.md']
    expect(tokens[2][0]).toEqual value: 'baz', scopes: ['text.md']

    # http://spec.commonmark.org/0.22/#example-199
    tokens = grammar.tokenizeLines('> bar\n>\nbaz')
    expect(tokens[0][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[0][2]).toEqual value: 'bar', scopes: ['text.md', 'quote.md']
    expect(tokens[1][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[2][0]).toEqual value: 'baz', scopes: ['text.md']

    # http://spec.commonmark.org/0.22/#example-200
    tokens = grammar.tokenizeLines('> > > foo\nbar')
    expect(tokens[0][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[0][2]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][3]).toEqual value: ' ', scopes: ['text.md', 'quote.md', 'quote.md']
    expect(tokens[0][4]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'quote.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][5]).toEqual value: ' ', scopes: ['text.md', 'quote.md', 'quote.md', 'quote.md']
    expect(tokens[0][6]).toEqual value: 'foo', scopes: ['text.md', 'quote.md', 'quote.md', 'quote.md']
    expect(tokens[1][0]).toEqual value: 'bar', scopes: ['text.md']

    # http://spec.commonmark.org/0.22/#example-201
    tokens = grammar.tokenizeLines('>>> foo\n> bar\n>>baz')
    expect(tokens[0][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][2]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'quote.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][3]).toEqual value: ' ', scopes: ['text.md', 'quote.md', 'quote.md', 'quote.md']
    expect(tokens[0][4]).toEqual value: 'foo', scopes: ['text.md', 'quote.md', 'quote.md', 'quote.md']
    expect(tokens[1][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[1][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[1][2]).toEqual value: 'bar', scopes: ['text.md', 'quote.md']
    expect(tokens[2][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[2][1]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'quote.md', 'punctuation.md']
    expect(tokens[2][2]).toEqual value: 'baz', scopes: ['text.md', 'quote.md', 'quote.md']

    # http://spec.commonmark.org/0.22/#example-202
    tokens = grammar.tokenizeLines('>     code\n\n>    not code')
    expect(tokens[0][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[0][2]).toEqual value: '    code', scopes: ['text.md', 'quote.md']
    expect(tokens[1][0]).toEqual value: '', scopes: ['text.md']
    expect(tokens[2][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[2][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[2][2]).toEqual value: '   not code', scopes: ['text.md', 'quote.md']
