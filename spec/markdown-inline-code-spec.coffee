describe 'Markdown grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-markdown')

    runs ->
      grammar = atom.grammars.grammarForScopeName('text.md')

  # http://spec.commonmark.org/0.22/#code-spans
  it 'tokenizes code spans', ->

    # http://spec.commonmark.org/0.22/#example-298
    {tokens} = grammar.tokenizeLine('`foo`')
    expect(tokens[0]).toEqual value: '`', scopes: ['text.md', 'code.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: 'foo', scopes: ['text.md', 'code.md']
    expect(tokens[2]).toEqual value: '`', scopes: ['text.md', 'code.md', 'punctuation.md']

    # http://spec.commonmark.org/0.22/#example-299
    {tokens} = grammar.tokenizeLine('`` foo ` bar  ``')
    expect(tokens[0]).toEqual value: '``', scopes: ['text.md', 'code.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' foo ` bar  ', scopes: ['text.md', 'code.md']
    expect(tokens[2]).toEqual value: '``', scopes: ['text.md', 'code.md', 'punctuation.md']

    # http://spec.commonmark.org/0.22/#example-300
    {tokens} = grammar.tokenizeLine('` `` `')
    expect(tokens[0]).toEqual value: '`', scopes: ['text.md', 'code.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' `` ', scopes: ['text.md', 'code.md']
    expect(tokens[2]).toEqual value: '`', scopes: ['text.md', 'code.md', 'punctuation.md']

    # FIXME
    # http://spec.commonmark.org/0.22/#example-301
    tokens = grammar.tokenizeLines('``\nfoo\n``')
    # expect(tokens[0][0]).toEqual value: '``', scopes: ['text.md', 'code.md', 'punctuation.md']
    # expect(tokens[1][0]).toEqual value: 'foo', scopes: ['text.md', 'code.md']
    # expect(tokens[2][0]).toEqual value: '``', scopes: ['text.md', 'code.md', 'punctuation.md']

    # http://spec.commonmark.org/0.22/#example-302
    tokens = grammar.tokenizeLines('`foo   bar\n  baz`')
    expect(tokens[0][0]).toEqual value: '`', scopes: ['text.md', 'code.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: 'foo   bar', scopes: ['text.md', 'code.md']
    expect(tokens[1][0]).toEqual value: '  baz', scopes: ['text.md', 'code.md']
    expect(tokens[1][1]).toEqual value: '`', scopes: ['text.md', 'code.md', 'punctuation.md']

    # http://spec.commonmark.org/0.22/#example-303
    {tokens} = grammar.tokenizeLine('`foo `` bar`')
    expect(tokens[0]).toEqual value: '`', scopes: ['text.md', 'code.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: 'foo `` bar', scopes: ['text.md', 'code.md']
    expect(tokens[2]).toEqual value: '`', scopes: ['text.md', 'code.md', 'punctuation.md']

    # http://spec.commonmark.org/0.22/#example-304
    {tokens} = grammar.tokenizeLine('`foo\\`bar`')
    expect(tokens[0]).toEqual value: '`', scopes: ['text.md', 'code.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: 'foo\\', scopes: ['text.md', 'code.md']
    expect(tokens[2]).toEqual value: '`', scopes: ['text.md', 'code.md', 'punctuation.md']
    expect(tokens[3]).toEqual value: 'bar`', scopes: ['text.md']

    # TODO
    # http://spec.commonmark.org/0.22/#example-305
    {tokens} = grammar.tokenizeLine('*foo`*`')

    # TODO
    # http://spec.commonmark.org/0.22/#example-306
    {tokens} = grammar.tokenizeLine('[not a `link](/foo`)')

    # TODO
    # http://spec.commonmark.org/0.22/#example-307
    {tokens} = grammar.tokenizeLine('`<a href="`">`')

    # TODO
    # http://spec.commonmark.org/0.22/#example-308
    {tokens} = grammar.tokenizeLine('<a href="`">`')

    # TODO
    # http://spec.commonmark.org/0.22/#example-309
    {tokens} = grammar.tokenizeLine('`<http://foo.bar.`baz>`')

    # TODO
    # http://spec.commonmark.org/0.22/#example-310
    {tokens} = grammar.tokenizeLine('<http://foo.bar.`baz>`')

    # TODO
    # http://spec.commonmark.org/0.22/#example-311
    {tokens} = grammar.tokenizeLine('```foo``')

    # TODO
    # http://spec.commonmark.org/0.22/#example-312
    {tokens} = grammar.tokenizeLine('`foo')
