describe 'Markdown grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-markdown')

    runs ->
      grammar = atom.grammars.grammarForScopeName('source.md')

  # http://spec.commonmark.org/0.22/#horizontal-rule
  it 'tokenizes horitontal rules', ->

    # TODO
    # http://spec.commonmark.org/0.22/#example-8
    {tokens} = grammar.tokenizeLine('***')

    {tokens} = grammar.tokenizeLine('---')

    {tokens} = grammar.tokenizeLine('___')

    # TODO
    # http://spec.commonmark.org/0.22/#example-9
    {tokens} = grammar.tokenizeLine('+++')

    # TODO
    # http://spec.commonmark.org/0.22/#example-10
    {tokens} = grammar.tokenizeLine('===')

    # TODO
    # http://spec.commonmark.org/0.22/#example-11
    {tokens} = grammar.tokenizeLine('--')

    {tokens} = grammar.tokenizeLine('**')

    {tokens} = grammar.tokenizeLine('__')

    # TODO
    # http://spec.commonmark.org/0.22/#example-12
    {tokens} = grammar.tokenizeLine('  ***')

    # TODO
    # http://spec.commonmark.org/0.22/#example-13
    {tokens} = grammar.tokenizeLine('    ***')

    # TODO
    # http://spec.commonmark.org/0.22/#example-14
    {tokens} = grammar.tokenizeLine('Foo\n    ***')

    # TODO
    # http://spec.commonmark.org/0.22/#example-15
    {tokens} = grammar.tokenizeLine('_____________________________________')

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

    # TODO
    # http://spec.commonmark.org/0.22/#example-20
    {tokens} = grammar.tokenizeLine('_ _ _ _ a')

    {tokens} = grammar.tokenizeLine('a------')

    {tokens} = grammar.tokenizeLine('---a---')

    # TODO
    # http://spec.commonmark.org/0.22/#example-21
    {tokens} = grammar.tokenizeLine(' *-*')

    # TODO
    # http://spec.commonmark.org/0.22/#example-22
    {tokens} = grammar.tokenizeLine('- foo\n***\n- bar')

    # TODO
    # http://spec.commonmark.org/0.22/#example-23
    {tokens} = grammar.tokenizeLine('Foo\n***\nbar')

    # TODO
    # http://spec.commonmark.org/0.22/#example-24
    {tokens} = grammar.tokenizeLine('Foo\n---\nbar')

    # TODO
    # http://spec.commonmark.org/0.22/#example-25
    {tokens} = grammar.tokenizeLine('* Foo\n* * *\n* Bar')

    # TODO
    # http://spec.commonmark.org/0.22/#example-26
    {tokens} = grammar.tokenizeLine('- Foo\n- * * *')
