describe 'Markdown grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-markdown')

    runs ->
      grammar = atom.grammars.grammarForScopeName('text.md')

  # http://spec.commonmark.org/0.22/#atx-header
  it 'tokenizes ATX headings', ->

    # http://spec.commonmark.org/0.22/#example-27
    {tokens} = grammar.tokenizeLine('# Heading')
    expect(tokens[0]).toEqual value: '#', scopes: ['text.md', 'heading.md', 'heading-1.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['text.md', 'heading.md', 'heading-1.md']
    expect(tokens[2]).toEqual value: 'Heading', scopes: ['text.md', 'heading.md', 'heading-1.md']

    # http://spec.commonmark.org/0.22/#example-28
    {tokens} = grammar.tokenizeLine('####### foo')
    expect(tokens[0]).toEqual value: '####### foo', scopes: ['text.md']

    # http://spec.commonmark.org/0.22/#example-29
    {tokens} = grammar.tokenizeLine('#5 bolt')
    expect(tokens[0]).toEqual value: '#', scopes: ['text.md', 'issue.reference.gfm.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: '5', scopes: ['text.md', 'issue.reference.gfm.md']
    expect(tokens[2]).toEqual value: ' bolt', scopes: ['text.md']

    # Variant of #29
    {tokens} = grammar.tokenizeLine('#foobar')
    expect(tokens[0]).toEqual value: '#foobar', scopes: ['text.md']

    # http://spec.commonmark.org/0.22/#example-30
    {tokens} = grammar.tokenizeLine('\\## foo')
    expect(tokens[0]).toEqual value: '\\#', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[1]).toEqual value: '# foo', scopes: ['text.md']

    # FIXME
    # http://spec.commonmark.org/0.22/#example-31
    {tokens} = grammar.tokenizeLine('# foo *bar* \\*baz\\*')
    # expect(tokens[0]).toEqual value: '#', scopes: ['text.md', 'heading.md', 'heading-1.md', 'punctuation.md']
    # expect(tokens[1]).toEqual value: ' ', scopes: ['text.md', 'heading.md', 'heading-1.md']
    # expect(tokens[2]).toEqual value: 'foo ', scopes: ['text.md', 'heading.md', 'heading-1.md']
    # expect(tokens[3]).toEqual value: '*', scopes: ['text.md', 'heading.md', 'heading-1.md', 'emphasis.md', 'punctuation.md']
    # expect(tokens[4]).toEqual value: 'bar', scopes: ['text.md', 'heading.md', 'heading-1.md', 'emphasis.md']
    # expect(tokens[5]).toEqual value: '*', scopes: ['text.md', 'heading.md', 'heading-1.md', 'emphasis.md', 'punctuation.md']
    # expect(tokens[6]).toEqual value: ' ', scopes: ['text.md', 'heading.md', 'heading-1.md']
    # expect(tokens[7]).toEqual value: '\*', scopes: ['text.md', 'heading.md', 'heading-1.md', 'escape.constant.md']
    # expect(tokens[8]).toEqual value: 'baz', scopes: ['text.md', 'heading.md', 'heading-1.md']
    # expect(tokens[9]).toEqual value: '\*', scopes: ['text.md', 'heading.md', 'heading-1.md', 'escape.constant.md']

    # for token, i in tokens
    #   console.log i+":'"+token.value+"'"

    # http://spec.commonmark.org/0.22/#example-32
    {tokens} = grammar.tokenizeLine('#                  foo')
    expect(tokens[0]).toEqual value: '#', scopes: ['text.md', 'heading.md', 'heading-1.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: '                  ', scopes: ['text.md', 'heading.md', 'heading-1.md']
    expect(tokens[2]).toEqual value: 'foo', scopes: ['text.md', 'heading.md', 'heading-1.md']

    # http://spec.commonmark.org/0.22/#example-33
    {tokens} = grammar.tokenizeLine('  ## Heading')
    expect(tokens[0]).toEqual value: '  ', scopes: ['text.md', 'heading.md', 'heading-2.md']
    expect(tokens[1]).toEqual value: '##', scopes: ['text.md', 'heading.md', 'heading-2.md', 'punctuation.md']
    expect(tokens[2]).toEqual value: ' ', scopes: ['text.md', 'heading.md', 'heading-2.md']
    expect(tokens[3]).toEqual value: 'Heading', scopes: ['text.md', 'heading.md', 'heading-2.md']

    # NOTE indented-code is disabled
    # http://spec.commonmark.org/0.22/#example-34
    # {tokens} = grammar.tokenizeLine('    # foo')
    # expect(tokens[0]).toEqual value: '    ', scopes: ['text.md', 'indented-code.md']
    # expect(tokens[1]).toEqual value: '# foo', scopes: ['text.md', 'indented-code.md', 'code.md']

    # NOTE indented-code is disabled
    # http://spec.commonmark.org/0.22/#example-35
    # tokens = grammar.tokenizeLines('foo\n    # bar')
    # expect(tokens[0][0]).toEqual value: 'foo', scopes: ['text.md']
    # expect(tokens[1][0]).toEqual value: '    ', scopes: ['text.md', 'indented-code.md']
    # expect(tokens[1][1]).toEqual value: '# bar', scopes: ['text.md', 'indented-code.md', 'code.md']

    # http://spec.commonmark.org/0.22/#example-36
    {tokens} = grammar.tokenizeLine('## foo ##')
    expect(tokens[0]).toEqual value: '##', scopes: ['text.md', 'heading.md', 'heading-2.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['text.md', 'heading.md', 'heading-2.md']
    expect(tokens[2]).toEqual value: 'foo', scopes: ['text.md', 'heading.md', 'heading-2.md']
    expect(tokens[3]).toEqual value: ' ', scopes: ['text.md', 'heading.md', 'heading-2.md']
    expect(tokens[4]).toEqual value: '##', scopes: ['text.md', 'heading.md', 'heading-2.md', 'punctuation.md']

    # Variant of #36
    {tokens} = grammar.tokenizeLine('  ###   bar    ###')
    expect(tokens[0]).toEqual value: '  ', scopes: ['text.md', 'heading.md', 'heading-3.md']
    expect(tokens[1]).toEqual value: '###', scopes: ['text.md', 'heading.md', 'heading-3.md', 'punctuation.md']
    expect(tokens[2]).toEqual value: '   ', scopes: ['text.md', 'heading.md', 'heading-3.md']
    expect(tokens[3]).toEqual value: 'bar   ', scopes: ['text.md', 'heading.md', 'heading-3.md']
    expect(tokens[4]).toEqual value: ' ', scopes: ['text.md', 'heading.md', 'heading-3.md']
    expect(tokens[5]).toEqual value: '###', scopes: ['text.md', 'heading.md', 'heading-3.md', 'punctuation.md']

    # This spec fails because the space after 'foo' is scoped together with the closing '###'s
    {tokens} = grammar.tokenizeLine('# foo ##################################')
    expect(tokens[0]).toEqual value: '#', scopes: ['text.md', 'heading.md', 'heading-1.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['text.md', 'heading.md', 'heading-1.md']
    expect(tokens[2]).toEqual value: 'foo', scopes: ['text.md', 'heading.md', 'heading-1.md']
    expect(tokens[3]).toEqual value: ' ', scopes: ['text.md', 'heading.md', 'heading-1.md']
    expect(tokens[4]).toEqual value: '##################################', scopes: ['text.md', 'heading.md', 'heading-1.md', 'punctuation.md']

    # This spec fails because the space after 'foo' is scoped together with the closing '##'
    {tokens} = grammar.tokenizeLine('##### foo ##')
    expect(tokens[0]).toEqual value: '#####', scopes: ['text.md', 'heading.md', 'heading-5.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['text.md', 'heading.md', 'heading-5.md']
    expect(tokens[2]).toEqual value: 'foo', scopes: ['text.md', 'heading.md', 'heading-5.md']
    expect(tokens[3]).toEqual value: ' ', scopes: ['text.md', 'heading.md', 'heading-5.md']
    expect(tokens[4]).toEqual value: '##', scopes: ['text.md', 'heading.md', 'heading-5.md', 'punctuation.md']

    # This spec fails because the space after 'foo' is scoped together with the closing '###'
    {tokens} = grammar.tokenizeLine('### foo ###     ')
    expect(tokens[0]).toEqual value: '###', scopes: ['text.md', 'heading.md', 'heading-3.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['text.md', 'heading.md', 'heading-3.md']
    expect(tokens[2]).toEqual value: 'foo', scopes: ['text.md', 'heading.md', 'heading-3.md']
    expect(tokens[3]).toEqual value: ' ', scopes: ['text.md', 'heading.md', 'heading-3.md']
    expect(tokens[4]).toEqual value: '###', scopes: ['text.md', 'heading.md', 'heading-3.md', 'punctuation.md']
    expect(tokens[5]).toEqual value: '     ', scopes: ['text.md', 'heading.md', 'heading-3.md']

    # http://spec.commonmark.org/0.22/#example-39
    {tokens} = grammar.tokenizeLine('### foo ### b')
    expect(tokens[0]).toEqual value: '###', scopes: ['text.md', 'heading.md', 'heading-3.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['text.md', 'heading.md', 'heading-3.md']
    expect(tokens[2]).toEqual value: 'foo ### b', scopes: ['text.md', 'heading.md', 'heading-3.md']

    # http://spec.commonmark.org/0.22/#example-40
    {tokens} = grammar.tokenizeLine('# foo#')
    expect(tokens[0]).toEqual value: '#', scopes: ['text.md', 'heading.md', 'heading-1.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['text.md', 'heading.md', 'heading-1.md']
    expect(tokens[2]).toEqual value: 'foo#', scopes: ['text.md', 'heading.md', 'heading-1.md']

    # http://spec.commonmark.org/0.22/#example-41
    {tokens} = grammar.tokenizeLine('### foo \\###')
    expect(tokens[0]).toEqual value: '###', scopes: ['text.md', 'heading.md', 'heading-3.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['text.md', 'heading.md', 'heading-3.md']
    expect(tokens[2]).toEqual value: 'foo ', scopes: ['text.md', 'heading.md', 'heading-3.md']
    expect(tokens[3]).toEqual value: '\\#', scopes: ['text.md', 'heading.md', 'heading-3.md', 'escape.constant.md']
    expect(tokens[4]).toEqual value: '##', scopes: ['text.md', 'heading.md', 'heading-3.md']

    # Variant of #41
    {tokens} = grammar.tokenizeLine('## foo #\\##')
    expect(tokens[0]).toEqual value: '##', scopes: ['text.md', 'heading.md', 'heading-2.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['text.md', 'heading.md', 'heading-2.md']
    expect(tokens[2]).toEqual value: 'foo #', scopes: ['text.md', 'heading.md', 'heading-2.md']
    expect(tokens[3]).toEqual value: '\\#', scopes: ['text.md', 'heading.md', 'heading-2.md', 'escape.constant.md']
    expect(tokens[4]).toEqual value: '#', scopes: ['text.md', 'heading.md', 'heading-2.md']

    # Variant of #41
    {tokens} = grammar.tokenizeLine('# foo \\#')
    expect(tokens[0]).toEqual value: '#', scopes: ['text.md', 'heading.md', 'heading-1.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['text.md', 'heading.md', 'heading-1.md']
    expect(tokens[2]).toEqual value: 'foo ', scopes: ['text.md', 'heading.md', 'heading-1.md']
    expect(tokens[3]).toEqual value: '\\#', scopes: ['text.md', 'heading.md', 'heading-1.md', 'escape.constant.md']

    # http://spec.commonmark.org/0.22/#example-42
    [firstLineTokens, secondLineTokens, thirdLineTokens] = grammar.tokenizeLines('****\n## foo\n****')
    expect(firstLineTokens[0]).toEqual value: '****', scopes: ['text.md', 'hr.md']
    expect(secondLineTokens[0]).toEqual value: '##', scopes: ['text.md', 'heading.md', 'heading-2.md', 'punctuation.md']
    expect(secondLineTokens[1]).toEqual value: ' ', scopes: ['text.md', 'heading.md', 'heading-2.md']
    expect(secondLineTokens[2]).toEqual value: 'foo', scopes: ['text.md', 'heading.md', 'heading-2.md']
    expect(thirdLineTokens[0]).toEqual value: '****', scopes: ['text.md', 'hr.md']

    # http://spec.commonmark.org/0.22/#example-43
    [firstLineTokens, secondLineTokens, thirdLineTokens] = grammar.tokenizeLines('Foo bar\n# baz\nBar foo')
    expect(firstLineTokens[0]).toEqual value: 'Foo bar', scopes: ['text.md']
    expect(secondLineTokens[0]).toEqual value: '#', scopes: ['text.md', 'heading.md', 'heading-1.md', 'punctuation.md']
    expect(secondLineTokens[1]).toEqual value: ' ', scopes: ['text.md', 'heading.md', 'heading-1.md']
    expect(secondLineTokens[2]).toEqual value: 'baz', scopes: ['text.md', 'heading.md', 'heading-1.md']
    expect(thirdLineTokens[0]).toEqual value: 'Bar foo', scopes: ['text.md']

    # http://spec.commonmark.org/0.22/#example-44
    {tokens} = grammar.tokenizeLine('## ')
    expect(tokens[0]).toEqual value: '##', scopes: ['text.md', 'empty.heading.md', 'heading-2.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['text.md', 'empty.heading.md', 'heading-2.md']

    # Variant of #44
    {tokens} = grammar.tokenizeLine('#')
    expect(tokens[0]).toEqual value: '#', scopes: ['text.md', 'empty.heading.md', 'heading-1.md', 'punctuation.md']

    # Variant of #44
    {tokens} = grammar.tokenizeLine('### ###')
    expect(tokens[0]).toEqual value: '###', scopes: ['text.md', 'empty.heading.md', 'heading-3.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['text.md', 'empty.heading.md', 'heading-3.md']
    expect(tokens[2]).toEqual value: '###', scopes: ['text.md', 'empty.heading.md', 'heading-3.md', 'punctuation.md']
