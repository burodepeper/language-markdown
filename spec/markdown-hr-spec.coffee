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

    # TODO
    # http://spec.commonmark.org/0.22/#example-14
    {tokens} = grammar.tokenizeLine('Foo\n    ***')

    # http://spec.commonmark.org/0.22/#example-15
    {tokens} = grammar.tokenizeLine('_____________________________________')
    expect(tokens[0]).toEqual value: '_____________________________________', scopes: ['source.md', 'hr.md']

    # TODO
    # http://spec.commonmark.org/0.22/#example-16
    {tokens} = grammar.tokenizeLine(' - - -')

    # TODO
    # http://spec.commonmark.org/0.22/#example-17
    {tokens} = grammar.tokenizeLine(' **  * ** * ** * **')

    # TODO
    # http://spec.commonmark.org/0.22/#example-18
    {tokens} = grammar.tokenizeLine('-     -      -      -')

    # TODO
    # http://spec.commonmark.org/0.22/#example-19
    {tokens} = grammar.tokenizeLine('- - - -    ')

    # http://spec.commonmark.org/0.22/#example-20
    {tokens} = grammar.tokenizeLine('_ _ _ _ a')
    expect(tokens[0]).toEqual value: '_ _ _ _ a', scopes: ['source.md']

    {tokens} = grammar.tokenizeLine('a------')
    expect(tokens[0]).toEqual value: 'a------', scopes: ['source.md']

    {tokens} = grammar.tokenizeLine('---a---')
    expect(tokens[0]).toEqual value: '---a---', scopes: ['source.md']

    # FIXME
    # http://spec.commonmark.org/0.22/#example-21
    {tokens} = grammar.tokenizeLine(' *-*')
    # expect(tokens[0]).toEqual value: ' ', scopes: ['source.md']
    # expect(tokens[1]).toEqual value: '*', scopes: ['source.md', 'emphasis.md']
    # expect(tokens[2]).toEqual value: '-', scopes: ['source.md', 'emphasis.md']
    # expect(tokens[3]).toEqual value: '*', scopes: ['source.md', 'emphasis.md']

    # TODO
    # http://spec.commonmark.org/0.22/#example-22
    {tokens} = grammar.tokenizeLine('- foo\n***\n- bar')

    # TODO
    # http://spec.commonmark.org/0.22/#example-23
    {tokens} = grammar.tokenizeLine('Foo\n***\nbar')

    # for token, i in tokens
    #   console.log "#23["+i+"]: '"+token.value+"' ("+token.value.length+")"

    # TODO
    # http://spec.commonmark.org/0.22/#example-24
    {tokens} = grammar.tokenizeLine('Foo\n---\nbar')

    # TODO
    # http://spec.commonmark.org/0.22/#example-25
    {tokens} = grammar.tokenizeLine('* Foo\n* * *\n* Bar')

    # TODO
    # http://spec.commonmark.org/0.22/#example-26
    {tokens} = grammar.tokenizeLine('- Foo\n- * * *')
