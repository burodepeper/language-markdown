describe 'Markdown grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-markdown')

    runs ->
      grammar = atom.grammars.grammarForScopeName('text.md')

  # http://spec.commonmark.org/0.22/#backslash-escapes
  it 'tokenizes backslash escapes', ->

    # http://spec.commonmark.org/0.22/#example-273
    {tokens} = grammar.tokenizeLine('\\!\\"\\#\\$\\%\\&\\(\\)\\*\\+\\,\\-\\.\\/\\:\\;\\<\\=\\>\\?')
    expect(tokens[0]).toEqual value: '\\!', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[1]).toEqual value: '\\"', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[2]).toEqual value: '\\#', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[3]).toEqual value: '\\$', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[4]).toEqual value: '\\%', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[5]).toEqual value: '\\&', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[6]).toEqual value: '\\(', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[7]).toEqual value: '\\)', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[8]).toEqual value: '\\*', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[9]).toEqual value: '\\+', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[10]).toEqual value: '\\,', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[11]).toEqual value: '\\-', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[12]).toEqual value: '\\.', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[13]).toEqual value: '\\/', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[14]).toEqual value: '\\:', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[15]).toEqual value: '\\;', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[16]).toEqual value: '\\<', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[17]).toEqual value: '\\=', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[18]).toEqual value: '\\>', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[19]).toEqual value: '\\?', scopes: ['text.md', 'escape.constant.md']

    {tokens} = grammar.tokenizeLine('\\@\\[\\\\\\]\\^\\_\\`\\{\\|\\}\\~')
    expect(tokens[0]).toEqual value: '\\@', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[1]).toEqual value: '\\[', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[2]).toEqual value: '\\\\', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[3]).toEqual value: '\\]', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[4]).toEqual value: '\\^', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[5]).toEqual value: '\\_', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[6]).toEqual value: '\\`', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[7]).toEqual value: '\\{', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[8]).toEqual value: '\\|', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[9]).toEqual value: '\\}', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[10]).toEqual value: '\\~', scopes: ['text.md', 'escape.constant.md']

    # http://spec.commonmark.org/0.22/#example-274
    {tokens} = grammar.tokenizeLine('\\→\\A\\a\\ \\3\\φ\\«')
    expect(tokens[0]).toEqual value: '\\→', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[1]).toEqual value: '\\A', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[2]).toEqual value: '\\a', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[3]).toEqual value: '\\ ', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[4]).toEqual value: '\\3', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[5]).toEqual value: '\\φ', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[6]).toEqual value: '\\«', scopes: ['text.md', 'escape.constant.md']

    # http://spec.commonmark.org/0.22/#example-275
    {tokens} = grammar.tokenizeLine('\\*not emphasized*')
    expect(tokens[0]).toEqual value: '\\*', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[1]).toEqual value: 'not emphasized*', scopes: ['text.md']

    {tokens} = grammar.tokenizeLine('\\<br/> not a tag')
    expect(tokens[0]).toEqual value: '\\<', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[1]).toEqual value: 'br/> not a tag', scopes: ['text.md']

    {tokens} = grammar.tokenizeLine('\\[not a link](/foo)')
    expect(tokens[0]).toEqual value: '\\[', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[1]).toEqual value: 'not a link](/foo)', scopes: ['text.md']

    {tokens} = grammar.tokenizeLine('\\`not code`')
    expect(tokens[0]).toEqual value: '\\`', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[1]).toEqual value: 'not code`', scopes: ['text.md']

    {tokens} = grammar.tokenizeLine('1\\. not a list')
    expect(tokens[0]).toEqual value: '1', scopes: ['text.md']
    expect(tokens[1]).toEqual value: '\\.', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[2]).toEqual value: ' not a list', scopes: ['text.md']

    {tokens} = grammar.tokenizeLine('\\* not a list')
    expect(tokens[0]).toEqual value: '\\*', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[1]).toEqual value: ' not a list', scopes: ['text.md']

    {tokens} = grammar.tokenizeLine('\\# not a header')
    expect(tokens[0]).toEqual value: '\\#', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[1]).toEqual value: ' not a header', scopes: ['text.md']

    {tokens} = grammar.tokenizeLine('\\[foo]: /url "not a reference"')
    expect(tokens[0]).toEqual value: '\\[', scopes: ['text.md', 'escape.constant.md']
    expect(tokens[1]).toEqual value: 'foo]: /url "not a reference"', scopes: ['text.md']

    # TODO
    # http://spec.commonmark.org/0.22/#example-276
    {tokens} = grammar.tokenizeLine('\\\\*emphasis*')

    # http://spec.commonmark.org/0.22/#example-277
    tokens = grammar.tokenizeLines('foo\\\nbar')
    expect(tokens[0][0]).toEqual value: 'foo\\', scopes: ['text.md']
    expect(tokens[1][0]).toEqual value: 'bar', scopes: ['text.md']

    # http://spec.commonmark.org/0.22/#example-278
    {tokens} = grammar.tokenizeLine('`` \\[\\` ``')
    expect(tokens[0]).toEqual value: '``', scopes: ['text.md', 'code.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' \\[\\` ', scopes: ['text.md', 'code.md']
    expect(tokens[2]).toEqual value: '``', scopes: ['text.md', 'code.md', 'punctuation.md']

    # NOTE indented-code is disabled
    # http://spec.commonmark.org/0.22/#example-279
    # {tokens} = grammar.tokenizeLine('    \\[\\]')
    # expect(tokens[0]).toEqual value: '    ', scopes: ['text.md', 'indented-code.md']
    # expect(tokens[1]).toEqual value: '\\[\\]', scopes: ['text.md', 'indented-code.md', 'code.md']

    # TODO
    # http://spec.commonmark.org/0.22/#example-280
    tokens = grammar.tokenizeLines('~~~\n\\[\\]\n~~~')

    # TODO
    # http://spec.commonmark.org/0.22/#example-281
    {tokens} = grammar.tokenizeLine('<http://example.com?find=\\*>')

    # TODO
    # http://spec.commonmark.org/0.22/#example-282
    {tokens} = grammar.tokenizeLine('<a href="/bar\\/)">')

    # TODO
    # http://spec.commonmark.org/0.22/#example-283
    {tokens} = grammar.tokenizeLine('[foo](/bar\\* "ti\\*tle")')

    # TODO
    # http://spec.commonmark.org/0.22/#example-284
    {tokens} = grammar.tokenizeLine('[foo]')

    {tokens} = grammar.tokenizeLine('[foo]: /bar\\* "ti\\*tle"')

    # TODO
    # http://spec.commonmark.org/0.22/#example-285
    tokens = grammar.tokenizeLines('``` foo\\+bar\nfoo\n```')
