describe 'Markdown grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-markdown')

    runs ->
      grammar = atom.grammars.grammarForScopeName('text.md')

  # http://spec.commonmark.org/0.22/#horizontal-rule
  it 'tokenizes horitontal rules', ->

    # http://spec.commonmark.org/0.22/#example-8
    {tokens} = grammar.tokenizeLine('***')
    expect(tokens[0]).toEqual value: '***', scopes: ['text.md', 'hr.md']

    {tokens} = grammar.tokenizeLine('---')
    expect(tokens[0]).toEqual value: '---', scopes: ['text.md', 'hr.md']

    {tokens} = grammar.tokenizeLine('___')
    expect(tokens[0]).toEqual value: '___', scopes: ['text.md', 'hr.md']

    # http://spec.commonmark.org/0.22/#example-9
    {tokens} = grammar.tokenizeLine('+++')
    expect(tokens[0]).toEqual value: '+++', scopes: ['text.md']

    # http://spec.commonmark.org/0.22/#example-10
    {tokens} = grammar.tokenizeLine('===')
    expect(tokens[0]).toEqual value: '===', scopes: ['text.md']

    # http://spec.commonmark.org/0.22/#example-11
    {tokens} = grammar.tokenizeLine('--')
    expect(tokens[0]).toEqual value: '--', scopes: ['text.md']

    {tokens} = grammar.tokenizeLine('**')
    expect(tokens[0]).toEqual value: '**', scopes: ['text.md']

    {tokens} = grammar.tokenizeLine('__')
    expect(tokens[0]).toEqual value: '__', scopes: ['text.md']

    # http://spec.commonmark.org/0.22/#example-12
    {tokens} = grammar.tokenizeLine('  ***')
    expect(tokens[0]).toEqual value: '  ***', scopes: ['text.md', 'hr.md']

    # http://spec.commonmark.org/0.22/#example-13
    {tokens} = grammar.tokenizeLine('    ***')
    expect(tokens[0]).toEqual value: '    ', scopes: ['text.md', 'indented-code.md']
    expect(tokens[1]).toEqual value: '***', scopes: ['text.md', 'indented-code.md', 'code.md']

    # http://spec.commonmark.org/0.22/#example-14
    [firstLineTokens, secondLineTokens] = grammar.tokenizeLines("Foo\n    ***")
    expect(firstLineTokens[0]).toEqual value: 'Foo', scopes: ['text.md']
    expect(secondLineTokens[0]).toEqual value: '    ', scopes: ['text.md', 'indented-code.md']
    expect(secondLineTokens[1]).toEqual value: '***', scopes: ['text.md', 'indented-code.md', 'code.md']

    # http://spec.commonmark.org/0.22/#example-15
    {tokens} = grammar.tokenizeLine('_____________________________________')
    expect(tokens[0]).toEqual value: '_____________________________________', scopes: ['text.md', 'hr.md']

    # http://spec.commonmark.org/0.22/#example-16
    {tokens} = grammar.tokenizeLine(' - - -')
    expect(tokens[0]).toEqual value: ' - - -', scopes: ['text.md', 'hr.md']

    # http://spec.commonmark.org/0.22/#example-17
    {tokens} = grammar.tokenizeLine(' **  * ** * ** * **')
    expect(tokens[0]).toEqual value: ' **  * ** * ** * **', scopes: ['text.md', 'hr.md']

    # http://spec.commonmark.org/0.22/#example-18
    {tokens} = grammar.tokenizeLine('-     -      -      -')
    expect(tokens[0]).toEqual value: '-     -      -      -', scopes: ['text.md', 'hr.md']

    # http://spec.commonmark.org/0.22/#example-19
    {tokens} = grammar.tokenizeLine('- - - -    ')
    expect(tokens[0]).toEqual value: '- - - -    ', scopes: ['text.md', 'hr.md']

    # http://spec.commonmark.org/0.22/#example-20
    {tokens} = grammar.tokenizeLine('_ _ _ _ a')
    expect(tokens[0]).toEqual value: '_ _ _ _ a', scopes: ['text.md']

    {tokens} = grammar.tokenizeLine('a------')
    expect(tokens[0]).toEqual value: 'a------', scopes: ['text.md']

    {tokens} = grammar.tokenizeLine('---a---')
    expect(tokens[0]).toEqual value: '---a---', scopes: ['text.md']

    # FIXME naming in 'emphasis'
    # http://spec.commonmark.org/0.22/#example-21
    {tokens} = grammar.tokenizeLine(' *-*')
    # expect(tokens[0]).toEqual value: ' ', scopes: ['text.md']
    # expect(tokens[1]).toEqual value: '*', scopes: ['text.md', 'emphasis.md']
    # expect(tokens[2]).toEqual value: '-', scopes: ['text.md', 'emphasis.md']
    # expect(tokens[3]).toEqual value: '*', scopes: ['text.md', 'emphasis.md']

    # http://spec.commonmark.org/0.22/#example-22
    tokens = grammar.tokenizeLines("- foo\n***\n- bar")
    expect(tokens[0][0]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[0][2]).toEqual value: 'foo', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[1][0]).toEqual value: '***', scopes: ['text.md', 'hr.md']
    expect(tokens[2][0]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[2][1]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[2][2]).toEqual value: 'bar', scopes: ['text.md', 'unordered.list.md']

    # http://spec.commonmark.org/0.22/#example-23
    [firstLineTokens, secondLineTokens, thirdLineTokens] = grammar.tokenizeLines("Foo\n***\nbar")
    expect(firstLineTokens[0]).toEqual value: 'Foo', scopes: ['text.md']
    expect(secondLineTokens[0]).toEqual value: '***', scopes: ['text.md', 'hr.md']
    expect(thirdLineTokens[0]).toEqual value: 'bar', scopes: ['text.md']

    # TODO 'setext header'
    # http://spec.commonmark.org/0.22/#example-24
    {tokens} = grammar.tokenizeLine('Foo\n---\nbar')

    # http://spec.commonmark.org/0.22/#example-25
    tokens = grammar.tokenizeLines("* foo\n* * *\n* bar")
    expect(tokens[0][0]).toEqual value: '*', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[0][2]).toEqual value: 'foo', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[1][0]).toEqual value: '* * *', scopes: ['text.md', 'hr.md']
    expect(tokens[2][0]).toEqual value: '*', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[2][1]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[2][2]).toEqual value: 'bar', scopes: ['text.md', 'unordered.list.md']

    # http://spec.commonmark.org/0.22/#example-26
    tokens = grammar.tokenizeLines("- Foo\n- * * *")
    expect(tokens[0][0]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[0][2]).toEqual value: 'Foo', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[1][0]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[1][1]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[1][2]).toEqual value: '* * *', scopes: ['text.md', 'unordered.list.md', 'hr.md']
