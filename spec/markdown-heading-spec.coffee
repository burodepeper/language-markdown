describe 'Markdown grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-markdown')

    runs ->
      grammar = atom.grammars.grammarForScopeName('source.md')

  # http://spec.commonmark.org/0.22/#atx-header
  it 'tokenizes ATX headings', ->

    # http://spec.commonmark.org/0.22/#example-27
    {tokens} = grammar.tokenizeLine('# Heading')
    expect(tokens[0]).toEqual value: '#', scopes: ['source.md', 'heading.md', 'heading-1.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['source.md', 'heading.md', 'heading-1.md']
    expect(tokens[2]).toEqual value: 'Heading', scopes: ['source.md', 'heading.md', 'heading-1.md']

    # http://spec.commonmark.org/0.22/#example-28
    {tokens} = grammar.tokenizeLine('####### foo')
    expect(tokens[0]).toEqual value: '####### foo', scopes: ['source.md']

    # http://spec.commonmark.org/0.22/#example-29
    {tokens} = grammar.tokenizeLine('#5 bolt')
    expect(tokens[0]).toEqual value: '#5 bolt', scopes: ['source.md']

    # Variant of #29
    {tokens} = grammar.tokenizeLine('#foobar')
    expect(tokens[0]).toEqual value: '#foobar', scopes: ['source.md']

    # http://spec.commonmark.org/0.22/#example-30
    {tokens} = grammar.tokenizeLine('\\## foo')
    expect(tokens[0]).toEqual value: '\\## foo', scopes: ['source.md']

    # FIXME
    # http://spec.commonmark.org/0.22/#example-31
    # {tokens} = grammar.tokenizeLine('# foo *bar* \*baz\*')
    # expect(tokens[0]).toEqual value: '#', scopes: ['source.md', 'heading.md', 'heading-1.md', 'punctuation.md']
    # expect(tokens[1]).toEqual value: ' ', scopes: ['source.md', 'heading.md', 'heading-1.md']
    # expect(tokens[2]).toEqual value: 'foo ', scopes: ['source.md', 'heading.md', 'heading-1.md']
    # expect(tokens[3]).toEqual value: '*', scopes: ['source.md', 'heading.md', 'heading-1.md', 'italic.md', 'punctuation.md']
    # expect(tokens[4]).toEqual value: 'bar', scopes: ['source.md', 'heading.md', 'heading-1.md', 'italic.md']
    # expect(tokens[5]).toEqual value: '*', scopes: ['source.md', 'heading.md', 'heading-1.md', 'italic.md', 'punctuation.md']
    # expect(tokens[6]).toEqual value: ' \*baz\*', scopes: ['source.md', 'heading.md', 'heading-1.md']

    # http://spec.commonmark.org/0.22/#example-32
    {tokens} = grammar.tokenizeLine('#                  foo')
    expect(tokens[0]).toEqual value: '#', scopes: ['source.md', 'heading.md', 'heading-1.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: '                  ', scopes: ['source.md', 'heading.md', 'heading-1.md']
    expect(tokens[2]).toEqual value: 'foo', scopes: ['source.md', 'heading.md', 'heading-1.md']

    # http://spec.commonmark.org/0.22/#example-33
    {tokens} = grammar.tokenizeLine('  ## Heading')
    expect(tokens[0]).toEqual value: '  ', scopes: ['source.md', 'heading.md', 'heading-2.md']
    expect(tokens[1]).toEqual value: '##', scopes: ['source.md', 'heading.md', 'heading-2.md', 'punctuation.md']
    expect(tokens[2]).toEqual value: ' ', scopes: ['source.md', 'heading.md', 'heading-2.md']
    expect(tokens[3]).toEqual value: 'Heading', scopes: ['source.md', 'heading.md', 'heading-2.md']

    # TODO 'code block' not yet implemented
    # http://spec.commonmark.org/0.22/#example-34
    {tokens} = grammar.tokenizeLine('    # foo')

    # TODO 'code block' not yet implemented
    # http://spec.commonmark.org/0.22/#example-35
    {tokens} = grammar.tokenizeLine('foo\n    # bar')

    # http://spec.commonmark.org/0.22/#example-36
    {tokens} = grammar.tokenizeLine('## foo ##')
    expect(tokens[0]).toEqual value: '##', scopes: ['source.md', 'heading.md', 'heading-2.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['source.md', 'heading.md', 'heading-2.md']
    expect(tokens[2]).toEqual value: 'foo', scopes: ['source.md', 'heading.md', 'heading-2.md']
    expect(tokens[3]).toEqual value: ' ', scopes: ['source.md', 'heading.md', 'heading-2.md']
    expect(tokens[4]).toEqual value: '##', scopes: ['source.md', 'heading.md', 'heading-2.md', 'punctuation.md']

    # Variant of #36
    {tokens} = grammar.tokenizeLine('  ###   bar    ###')
    expect(tokens[0]).toEqual value: '  ', scopes: ['source.md', 'heading.md', 'heading-3.md']
    expect(tokens[1]).toEqual value: '###', scopes: ['source.md', 'heading.md', 'heading-3.md', 'punctuation.md']
    expect(tokens[2]).toEqual value: '   ', scopes: ['source.md', 'heading.md', 'heading-3.md']
    expect(tokens[3]).toEqual value: 'bar   ', scopes: ['source.md', 'heading.md', 'heading-3.md']
    expect(tokens[4]).toEqual value: ' ', scopes: ['source.md', 'heading.md', 'heading-3.md']
    expect(tokens[5]).toEqual value: '###', scopes: ['source.md', 'heading.md', 'heading-3.md', 'punctuation.md']

    # This spec fails because the space after 'foo' is scoped together with the closing '###'s
    {tokens} = grammar.tokenizeLine('# foo ##################################')
    expect(tokens[0]).toEqual value: '#', scopes: ['source.md', 'heading.md', 'heading-1.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['source.md', 'heading.md', 'heading-1.md']
    expect(tokens[2]).toEqual value: 'foo', scopes: ['source.md', 'heading.md', 'heading-1.md']
    expect(tokens[3]).toEqual value: ' ', scopes: ['source.md', 'heading.md', 'heading-1.md']
    expect(tokens[4]).toEqual value: '##################################', scopes: ['source.md', 'heading.md', 'heading-1.md', 'punctuation.md']

    # This spec fails because the space after 'foo' is scoped together with the closing '##'
    {tokens} = grammar.tokenizeLine('##### foo ##')
    expect(tokens[0]).toEqual value: '#####', scopes: ['source.md', 'heading.md', 'heading-5.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['source.md', 'heading.md', 'heading-5.md']
    expect(tokens[2]).toEqual value: 'foo', scopes: ['source.md', 'heading.md', 'heading-5.md']
    expect(tokens[3]).toEqual value: ' ', scopes: ['source.md', 'heading.md', 'heading-5.md']
    expect(tokens[4]).toEqual value: '##', scopes: ['source.md', 'heading.md', 'heading-5.md', 'punctuation.md']

    # This spec fails because the space after 'foo' is scoped together with the closing '###'
    {tokens} = grammar.tokenizeLine('### foo ###     ')
    expect(tokens[0]).toEqual value: '###', scopes: ['source.md', 'heading.md', 'heading-3.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['source.md', 'heading.md', 'heading-3.md']
    expect(tokens[2]).toEqual value: 'foo', scopes: ['source.md', 'heading.md', 'heading-3.md']
    expect(tokens[3]).toEqual value: ' ', scopes: ['source.md', 'heading.md', 'heading-3.md']
    expect(tokens[4]).toEqual value: '###', scopes: ['source.md', 'heading.md', 'heading-3.md', 'punctuation.md']
    expect(tokens[5]).toEqual value: '     ', scopes: ['source.md', 'heading.md', 'heading-3.md']

    # http://spec.commonmark.org/0.22/#example-39
    {tokens} = grammar.tokenizeLine('### foo ### b')
    expect(tokens[0]).toEqual value: '###', scopes: ['source.md', 'heading.md', 'heading-3.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['source.md', 'heading.md', 'heading-3.md']
    expect(tokens[2]).toEqual value: 'foo ### b', scopes: ['source.md', 'heading.md', 'heading-3.md']

    # http://spec.commonmark.org/0.22/#example-40
    {tokens} = grammar.tokenizeLine('# foo#')
    expect(tokens[0]).toEqual value: '#', scopes: ['source.md', 'heading.md', 'heading-1.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['source.md', 'heading.md', 'heading-1.md']
    expect(tokens[2]).toEqual value: 'foo#', scopes: ['source.md', 'heading.md', 'heading-1.md']

    # http://spec.commonmark.org/0.22/#example-41
    {tokens} = grammar.tokenizeLine('### foo \\###')
    expect(tokens[0]).toEqual value: '###', scopes: ['source.md', 'heading.md', 'heading-3.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['source.md', 'heading.md', 'heading-3.md']
    expect(tokens[2]).toEqual value: 'foo \\###', scopes: ['source.md', 'heading.md', 'heading-3.md']

    # Variant of #41
    {tokens} = grammar.tokenizeLine('## foo #\\##')
    expect(tokens[0]).toEqual value: '##', scopes: ['source.md', 'heading.md', 'heading-2.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['source.md', 'heading.md', 'heading-2.md']
    expect(tokens[2]).toEqual value: 'foo #\\##', scopes: ['source.md', 'heading.md', 'heading-2.md']

    # Variant of #41
    {tokens} = grammar.tokenizeLine('# foo \\#')
    expect(tokens[0]).toEqual value: '#', scopes: ['source.md', 'heading.md', 'heading-1.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['source.md', 'heading.md', 'heading-1.md']
    expect(tokens[2]).toEqual value: 'foo \\#', scopes: ['source.md', 'heading.md', 'heading-1.md']

    # http://spec.commonmark.org/0.22/#example-42
    [firstLineTokens, secondLineTokens, thirdLineTokens] = grammar.tokenizeLines('****\n## foo\n****')
    expect(firstLineTokens[0]).toEqual value: '****', scopes: ['source.md', 'hr.md']
    expect(secondLineTokens[0]).toEqual value: '##', scopes: ['source.md', 'heading.md', 'heading-2.md', 'punctuation.md']
    expect(secondLineTokens[1]).toEqual value: ' ', scopes: ['source.md', 'heading.md', 'heading-2.md']
    expect(secondLineTokens[2]).toEqual value: 'foo', scopes: ['source.md', 'heading.md', 'heading-2.md']
    expect(thirdLineTokens[0]).toEqual value: '****', scopes: ['source.md', 'hr.md']

    # http://spec.commonmark.org/0.22/#example-43
    [firstLineTokens, secondLineTokens, thirdLineTokens] = grammar.tokenizeLines('Foo bar\n# baz\nBar foo')
    expect(firstLineTokens[0]).toEqual value: 'Foo bar', scopes: ['source.md']
    expect(secondLineTokens[0]).toEqual value: '#', scopes: ['source.md', 'heading.md', 'heading-1.md', 'punctuation.md']
    expect(secondLineTokens[1]).toEqual value: ' ', scopes: ['source.md', 'heading.md', 'heading-1.md']
    expect(secondLineTokens[2]).toEqual value: 'baz', scopes: ['source.md', 'heading.md', 'heading-1.md']
    expect(thirdLineTokens[0]).toEqual value: 'Bar foo', scopes: ['source.md']

    # http://spec.commonmark.org/0.22/#example-44
    {tokens} = grammar.tokenizeLine('## ')
    expect(tokens[0]).toEqual value: '##', scopes: ['source.md', 'heading.md', 'heading-2.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['source.md', 'heading.md', 'heading-2.md']

    # Variant of #44
    {tokens} = grammar.tokenizeLine('#')
    expect(tokens[0]).toEqual value: '#', scopes: ['source.md', 'heading.md', 'heading-1.md', 'punctuation.md']

    # Variant of #44
    {tokens} = grammar.tokenizeLine('### ###')
    expect(tokens[0]).toEqual value: '###', scopes: ['source.md', 'heading.md', 'heading-3.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['source.md', 'heading.md', 'heading-3.md']
    expect(tokens[2]).toEqual value: '###', scopes: ['source.md', 'heading.md', 'heading-3.md', 'punctuation.md']
