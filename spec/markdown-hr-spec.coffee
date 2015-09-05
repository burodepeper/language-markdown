describe 'Markdown grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-markdown')

    runs ->
      grammar = atom.grammars.grammarForScopeName('source.md')

  # http://spec.commonmark.org/0.22/#horizontal-rule
  it 'tokenizes horitontal rules', ->

    # http://spec.commonmark.org/0.22/#example-8
    {tokens} = grammar.tokenizeLine('***')
    expect(tokens[0]).toEqual value: '***', scopes: ['source.md', 'hr.md']

    {tokens} = grammar.tokenizeLine('---')
    expect(tokens[0]).toEqual value: '---', scopes: ['source.md', 'hr.md']

    {tokens} = grammar.tokenizeLine('___')
    expect(tokens[0]).toEqual value: '___', scopes: ['source.md', 'hr.md']

    # http://spec.commonmark.org/0.22/#example-9
    {tokens} = grammar.tokenizeLine('+++')
    expect(tokens[0]).toEqual value: '+++', scopes: ['source.md']

    # http://spec.commonmark.org/0.22/#example-10
    {tokens} = grammar.tokenizeLine('===')
    expect(tokens[0]).toEqual value: '===', scopes: ['source.md']

    # http://spec.commonmark.org/0.22/#example-11
    {tokens} = grammar.tokenizeLine('--')
    expect(tokens[0]).toEqual value: '--', scopes: ['source.md']

    {tokens} = grammar.tokenizeLine('**')
    expect(tokens[0]).toEqual value: '**', scopes: ['source.md']

    {tokens} = grammar.tokenizeLine('__')
    expect(tokens[0]).toEqual value: '__', scopes: ['source.md']

    # http://spec.commonmark.org/0.22/#example-12
    {tokens} = grammar.tokenizeLine('  ***')
    expect(tokens[0]).toEqual value: '  ***', scopes: ['source.md', 'hr.md']

    # http://spec.commonmark.org/0.22/#example-13
    {tokens} = grammar.tokenizeLine('    ***')
    expect(tokens[0]).toEqual value: '    ***', scopes: ['source.md']

    # http://spec.commonmark.org/0.22/#example-14
    [firstLineTokens, secondLineTokens] = grammar.tokenizeLines("Foo\n    ***")
    expect(firstLineTokens[0]).toEqual value: 'Foo', scopes: ['source.md']
    expect(secondLineTokens[0]).toEqual value: '    ***', scopes: ['source.md']

    # http://spec.commonmark.org/0.22/#example-15
    {tokens} = grammar.tokenizeLine('_____________________________________')
    expect(tokens[0]).toEqual value: '_____________________________________', scopes: ['source.md', 'hr.md']

    # http://spec.commonmark.org/0.22/#example-16
    {tokens} = grammar.tokenizeLine(' - - -')
    expect(tokens[0]).toEqual value: ' - - -', scopes: ['source.md', 'hr.md']

    # http://spec.commonmark.org/0.22/#example-17
    {tokens} = grammar.tokenizeLine(' **  * ** * ** * **')
    expect(tokens[0]).toEqual value: ' **  * ** * ** * **', scopes: ['source.md', 'hr.md']

    # http://spec.commonmark.org/0.22/#example-18
    {tokens} = grammar.tokenizeLine('-     -      -      -')
    expect(tokens[0]).toEqual value: '-     -      -      -', scopes: ['source.md', 'hr.md']

    # http://spec.commonmark.org/0.22/#example-19
    {tokens} = grammar.tokenizeLine('- - - -    ')
    expect(tokens[0]).toEqual value: '- - - -    ', scopes: ['source.md', 'hr.md']

    # http://spec.commonmark.org/0.22/#example-20
    {tokens} = grammar.tokenizeLine('_ _ _ _ a')
    expect(tokens[0]).toEqual value: '_ _ _ _ a', scopes: ['source.md']

    {tokens} = grammar.tokenizeLine('a------')
    expect(tokens[0]).toEqual value: 'a------', scopes: ['source.md']

    {tokens} = grammar.tokenizeLine('---a---')
    expect(tokens[0]).toEqual value: '---a---', scopes: ['source.md']

    # FIXME naming in 'emphasis'
    # http://spec.commonmark.org/0.22/#example-21
    {tokens} = grammar.tokenizeLine(' *-*')
    # expect(tokens[0]).toEqual value: ' ', scopes: ['source.md']
    # expect(tokens[1]).toEqual value: '*', scopes: ['source.md', 'emphasis.md']
    # expect(tokens[2]).toEqual value: '-', scopes: ['source.md', 'emphasis.md']
    # expect(tokens[3]).toEqual value: '*', scopes: ['source.md', 'emphasis.md']

    # TODO impliment 'list-items'
    # http://spec.commonmark.org/0.22/#example-22
    [firstLineTokens, secondLineTokens, thirdLineTokens] = grammar.tokenizeLines("- foo\n***\n- bar")
    # expect(firstLineTokens[0]).toEqual value: '-', scopes: ['source.md', "unordered.list.md", "punctuation.md"]
    # expect(firstLineTokens[1]).toEqual value: ' foo', scopes: ['source.md', "unordered.list.md"]
    # expect(secondLineTokens[0]).toEqual value: '***', scopes: ['source.md', 'hr.md']
    # expect(thirdLineTokens[0]).toEqual value: '-', scopes: ['source.md', "unordered.list.md", "punctuation.md"]
    # expect(thirdLineTokens[1]).toEqual value: ' bar', scopes: ['source.md', "unordered.list.md"]

    # http://spec.commonmark.org/0.22/#example-23
    [firstLineTokens, secondLineTokens, thirdLineTokens] = grammar.tokenizeLines("Foo\n***\nbar")
    expect(firstLineTokens[0]).toEqual value: 'Foo', scopes: ['source.md']
    expect(secondLineTokens[0]).toEqual value: '***', scopes: ['source.md', 'hr.md']
    expect(thirdLineTokens[0]).toEqual value: 'bar', scopes: ['source.md']

    # TODO 'setext header'
    # http://spec.commonmark.org/0.22/#example-24
    {tokens} = grammar.tokenizeLine('Foo\n---\nbar')

    # TODO impliment 'list-items'
    # http://spec.commonmark.org/0.22/#example-25
    [firstLineTokens, secondLineTokens, thirdLineTokens] = grammar.tokenizeLines("- foo\n***\n- bar")
    # expect(firstLineTokens[0]).toEqual value: '*', scopes: ['source.md', "unordered.list.md", "punctuation.md"]
    # expect(firstLineTokens[1]).toEqual value: ' Foo', scopes: ['source.md', "unordered.list.md"]
    # expect(secondLineTokens[0]).toEqual value: '* * *', scopes: ['source.md', 'hr.md']
    # expect(thirdLineTokens[0]).toEqual value: '*', scopes: ['source.md', "unordered.list.md", "punctuation.md"]
    # expect(thirdLineTokens[1]).toEqual value: ' Bar', scopes: ['source.md', "unordered.list.md"]

    # TODO impliment 'list-items'
    # http://spec.commonmark.org/0.22/#example-26
    [firstLineTokens, secondLineTokens] = grammar.tokenizeLines("- Foo\n- * * *")
    # expect(firstLineTokens[0]).toEqual value: '-', scopes: ['source.md', "unordered.list.md", "punctuation.md"]
    # expect(firstLineTokens[1]).toEqual value: ' Foo', scopes: ['source.md', "unordered.list.md"]
    # expect(secondLineTokens[0]).toEqual value: '-', scopes: ['source.md', "unordered.list.md", "punctuation.md"]
    # expect(secondLineTokens[1]).toEqual value: ' * * *', scopes: ['source.md', "unordered.list.md", "hr.md"]
