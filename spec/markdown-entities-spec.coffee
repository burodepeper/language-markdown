describe 'Markdown grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-markdown')

    runs ->
      grammar = atom.grammars.grammarForScopeName('text.md')

  # http://spec.commonmark.org/0.22/#entities
  it 'tokenizes entities', ->

    # http://spec.commonmark.org/0.22/#example-286
    {tokens} = grammar.tokenizeLine('&nbsp;')
    expect(tokens[0]).toEqual value: '&', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: 'nbsp', scopes: ['text.md', 'entity.constant.md']
    expect(tokens[2]).toEqual value: ';', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']

    {tokens} = grammar.tokenizeLine('&amp;')
    expect(tokens[0]).toEqual value: '&', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: 'amp', scopes: ['text.md', 'entity.constant.md']
    expect(tokens[2]).toEqual value: ';', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']

    {tokens} = grammar.tokenizeLine('&copy;')
    expect(tokens[0]).toEqual value: '&', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: 'copy', scopes: ['text.md', 'entity.constant.md']
    expect(tokens[2]).toEqual value: ';', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']

    {tokens} = grammar.tokenizeLine('&AElig;')
    expect(tokens[0]).toEqual value: '&', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: 'AElig', scopes: ['text.md', 'entity.constant.md']
    expect(tokens[2]).toEqual value: ';', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']

    {tokens} = grammar.tokenizeLine('&Dcaron;')
    expect(tokens[0]).toEqual value: '&', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: 'Dcaron', scopes: ['text.md', 'entity.constant.md']
    expect(tokens[2]).toEqual value: ';', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']

    {tokens} = grammar.tokenizeLine('&frac34;')
    expect(tokens[0]).toEqual value: '&', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: 'frac34', scopes: ['text.md', 'entity.constant.md']
    expect(tokens[2]).toEqual value: ';', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']

    {tokens} = grammar.tokenizeLine('&HilbertSpace;')
    expect(tokens[0]).toEqual value: '&', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: 'HilbertSpace', scopes: ['text.md', 'entity.constant.md']
    expect(tokens[2]).toEqual value: ';', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']

    {tokens} = grammar.tokenizeLine('&DifferentialD;')
    expect(tokens[0]).toEqual value: '&', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: 'DifferentialD', scopes: ['text.md', 'entity.constant.md']
    expect(tokens[2]).toEqual value: ';', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']

    {tokens} = grammar.tokenizeLine('&ClockwiseContourIntegral;')
    expect(tokens[0]).toEqual value: '&', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: 'ClockwiseContourIntegral', scopes: ['text.md', 'entity.constant.md']
    expect(tokens[2]).toEqual value: ';', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']

    {tokens} = grammar.tokenizeLine('&ngE;')
    expect(tokens[0]).toEqual value: '&', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: 'ngE', scopes: ['text.md', 'entity.constant.md']
    expect(tokens[2]).toEqual value: ';', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']

    # http://spec.commonmark.org/0.22/#example-287
    {tokens} = grammar.tokenizeLine('&#35;')
    expect(tokens[0]).toEqual value: '&#', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: '35', scopes: ['text.md', 'entity.constant.md']
    expect(tokens[2]).toEqual value: ';', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']

    {tokens} = grammar.tokenizeLine('&#1234;')
    expect(tokens[0]).toEqual value: '&#', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: '1234', scopes: ['text.md', 'entity.constant.md']
    expect(tokens[2]).toEqual value: ';', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']

    {tokens} = grammar.tokenizeLine('&#992;')
    expect(tokens[0]).toEqual value: '&#', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: '992', scopes: ['text.md', 'entity.constant.md']
    expect(tokens[2]).toEqual value: ';', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']

    {tokens} = grammar.tokenizeLine('&#98765432;')
    expect(tokens[0]).toEqual value: '&#', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: '98765432', scopes: ['text.md', 'entity.constant.md']
    expect(tokens[2]).toEqual value: ';', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']

    {tokens} = grammar.tokenizeLine('&#0;')
    expect(tokens[0]).toEqual value: '&#', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: '0', scopes: ['text.md', 'entity.constant.md']
    expect(tokens[2]).toEqual value: ';', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']

    # http://spec.commonmark.org/0.22/#example-288
    {tokens} = grammar.tokenizeLine('&#X22;')
    expect(tokens[0]).toEqual value: '&#X', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: '22', scopes: ['text.md', 'entity.constant.md']
    expect(tokens[2]).toEqual value: ';', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']

    {tokens} = grammar.tokenizeLine('&#XD06;')
    expect(tokens[0]).toEqual value: '&#X', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: 'D06', scopes: ['text.md', 'entity.constant.md']
    expect(tokens[2]).toEqual value: ';', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']

    {tokens} = grammar.tokenizeLine('&#xcab;')
    expect(tokens[0]).toEqual value: '&#x', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: 'cab', scopes: ['text.md', 'entity.constant.md']
    expect(tokens[2]).toEqual value: ';', scopes: ['text.md', 'entity.constant.md', 'punctuation.md']

    # http://spec.commonmark.org/0.22/#example-289
    {tokens} = grammar.tokenizeLine('&nbsp')
    expect(tokens[0]).toEqual value: '&nbsp', scopes: ['text.md']

    {tokens} = grammar.tokenizeLine('&x;')
    expect(tokens[0]).toEqual value: '&x;', scopes: ['text.md']

    {tokens} = grammar.tokenizeLine('&#;')
    expect(tokens[0]).toEqual value: '&#;', scopes: ['text.md']

    {tokens} = grammar.tokenizeLine('&#x;')
    expect(tokens[0]).toEqual value: '&#x;', scopes: ['text.md']

    {tokens} = grammar.tokenizeLine('&ThisIsWayTooLongToBeAnEntityIsntIt;')
    expect(tokens[0]).toEqual value: '&ThisIsWayTooLongToBeAnEntityIsntIt;', scopes: ['text.md']

    {tokens} = grammar.tokenizeLine('&hi?;')
    expect(tokens[0]).toEqual value: '&hi?;', scopes: ['text.md']

    # http://spec.commonmark.org/0.22/#example-290
    {tokens} = grammar.tokenizeLine('&copy')
    expect(tokens[0]).toEqual value: '&copy', scopes: ['text.md']

    # FIXME See /rules/repositories/entities.cson for an explanation
    # http://spec.commonmark.org/0.22/#example-291
    {tokens} = grammar.tokenizeLine('&MadeUpEntity;')
    # expect(tokens[0]).toEqual value: '&MadeUpEntity;', scopes: ['text.md']

    # TODO
    # http://spec.commonmark.org/0.22/#example-292
    {tokens} = grammar.tokenizeLine('<a href="&ouml;&ouml;.html">')

    # TODO
    # http://spec.commonmark.org/0.22/#example-293
    {tokens} = grammar.tokenizeLine('[foo](/f&ouml;&ouml; "f&ouml;&ouml;")')

    # TODO
    # http://spec.commonmark.org/0.22/#example-294
    {tokens} = grammar.tokenizeLine('[foo]')

    {tokens} = grammar.tokenizeLine('[foo]: /f&ouml;&ouml; "f&ouml;&ouml;"')

    # TODO
    # http://spec.commonmark.org/0.22/#example-295
    tokens = grammar.tokenizeLines('``` f&ouml;&ouml;\nfoo\n```')

    # http://spec.commonmark.org/0.22/#example-296
    {tokens} = grammar.tokenizeLine('`f&ouml;&ouml;`')
    expect(tokens[0]).toEqual value: '`', scopes: ['text.md', 'code.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: 'f&ouml;&ouml;', scopes: ['text.md', 'code.md']
    expect(tokens[2]).toEqual value: '`', scopes: ['text.md', 'code.md', 'punctuation.md']

    # http://spec.commonmark.org/0.22/#example-297
    {tokens} = grammar.tokenizeLine('    f&ouml;f&ouml;')
    expect(tokens[0]).toEqual value: '    ', scopes: ['text.md', 'indented-code.md']
    expect(tokens[1]).toEqual value: 'f&ouml;f&ouml;', scopes: ['text.md', 'indented-code.md', 'code.md']
