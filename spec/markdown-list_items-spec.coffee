# NOTE
# The following examples are skipped,
# because they rely on multiline awareness.
#
# http://spec.commonmark.org/0.22/#example-204
# http://spec.commonmark.org/0.22/#example-205
# http://spec.commonmark.org/0.22/#example-206
# http://spec.commonmark.org/0.22/#example-207
# http://spec.commonmark.org/0.22/#example-208
# http://spec.commonmark.org/0.22/#example-209
# http://spec.commonmark.org/0.22/#example-210
#
# http://spec.commonmark.org/0.22/#example-212
# http://spec.commonmark.org/0.22/#example-213
#
# http://spec.commonmark.org/0.22/#example-219
# http://spec.commonmark.org/0.22/#example-220
# http://spec.commonmark.org/0.22/#example-221
# http://spec.commonmark.org/0.22/#example-222
# http://spec.commonmark.org/0.22/#example-223
# http://spec.commonmark.org/0.22/#example-224
# http://spec.commonmark.org/0.22/#example-225
# http://spec.commonmark.org/0.22/#example-226
# http://spec.commonmark.org/0.22/#example-227
# http://spec.commonmark.org/0.22/#example-228
#
# http://spec.commonmark.org/0.22/#example-233
# http://spec.commonmark.org/0.22/#example-234
# http://spec.commonmark.org/0.22/#example-235
# http://spec.commonmark.org/0.22/#example-236
# http://spec.commonmark.org/0.22/#example-237
# http://spec.commonmark.org/0.22/#example-238
# http://spec.commonmark.org/0.22/#example-239
# http://spec.commonmark.org/0.22/#example-240
#
# http://spec.commonmark.org/0.22/#example-247

describe 'Markdown grammar', ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-markdown')

    runs ->
      grammar = atom.grammars.grammarForScopeName('text.md')

  # http://spec.commonmark.org/0.22/#list-items
  it 'tokenizes list items', ->

    # http://spec.commonmark.org/0.22/#example-203
    tokens = grammar.tokenizeLines('A paragraph\nwith two lines.\n\n    indented code\n\n> A block quote.')
    expect(tokens[0][0]).toEqual value: 'A paragraph', scopes: ['text.md']
    expect(tokens[1][0]).toEqual value: 'with two lines.', scopes: ['text.md']
    expect(tokens[2][0]).toEqual value: '', scopes: ['text.md']
    expect(tokens[3][0]).toEqual value: '    ', scopes: ['text.md', 'indented-code.md']
    expect(tokens[3][1]).toEqual value: 'indented code', scopes: ['text.md', 'indented-code.md', 'code.md']
    expect(tokens[4][0]).toEqual value: '', scopes: ['text.md']
    expect(tokens[5][0]).toEqual value: '>', scopes: ['text.md', 'quote.md', 'punctuation.md']
    expect(tokens[5][1]).toEqual value: ' ', scopes: ['text.md', 'quote.md']
    expect(tokens[5][2]).toEqual value: 'A block quote.', scopes: ['text.md', 'quote.md']

    # http://spec.commonmark.org/0.22/#example-211
    {tokens} = grammar.tokenizeLine('-one')
    expect(tokens[0]).toEqual value: '-one', scopes: ['text.md']

    {tokens} = grammar.tokenizeLine('2.two')
    expect(tokens[0]).toEqual value: '2.two', scopes: ['text.md']

    # http://spec.commonmark.org/0.22/#example-214
    {tokens} = grammar.tokenizeLine('123456789. ok')
    expect(tokens[0]).toEqual value: '123456789.', scopes: ['text.md', 'ordered.list.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['text.md', 'ordered.list.md']
    expect(tokens[2]).toEqual value: 'ok', scopes: ['text.md', 'ordered.list.md']

    # http://spec.commonmark.org/0.22/#example-215
    {tokens} = grammar.tokenizeLine('1234567890. not ok')
    expect(tokens[0]).toEqual value: '1234567890. not ok', scopes: ['text.md']

    # http://spec.commonmark.org/0.22/#example-216
    {tokens} = grammar.tokenizeLine('0. ok')
    expect(tokens[0]).toEqual value: '0.', scopes: ['text.md', 'ordered.list.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['text.md', 'ordered.list.md']
    expect(tokens[2]).toEqual value: 'ok', scopes: ['text.md', 'ordered.list.md']

    # http://spec.commonmark.org/0.22/#example-217
    {tokens} = grammar.tokenizeLine('003. ok')
    expect(tokens[0]).toEqual value: '003.', scopes: ['text.md', 'ordered.list.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['text.md', 'ordered.list.md']
    expect(tokens[2]).toEqual value: 'ok', scopes: ['text.md', 'ordered.list.md']

    # http://spec.commonmark.org/0.22/#example-218
    {tokens} = grammar.tokenizeLine('-1. not ok')
    expect(tokens[0]).toEqual value: '-1. not ok', scopes: ['text.md']

    # http://spec.commonmark.org/0.22/#example-229
    tokens = grammar.tokenizeLines('- foo\n-\n- bar')
    expect(tokens[0][0]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[0][2]).toEqual value: 'foo', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[1][0]).toEqual value: '-', scopes: ['text.md', 'empty.unordered.list.md', 'punctuation.md']
    expect(tokens[2][0]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[2][1]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[2][2]).toEqual value: 'bar', scopes: ['text.md', 'unordered.list.md']

    # http://spec.commonmark.org/0.22/#example-230
    tokens = grammar.tokenizeLines('- foo\n-   \n- bar')
    expect(tokens[0][0]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[0][2]).toEqual value: 'foo', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[1][0]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[1][1]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[1][2]).toEqual value: '  ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[2][0]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[2][1]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[2][2]).toEqual value: 'bar', scopes: ['text.md', 'unordered.list.md']

    # http://spec.commonmark.org/0.22/#example-231
    tokens = grammar.tokenizeLines('1. foo\n2.\n3. bar')
    expect(tokens[0][0]).toEqual value: '1.', scopes: ['text.md', 'ordered.list.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'ordered.list.md']
    expect(tokens[0][2]).toEqual value: 'foo', scopes: ['text.md', 'ordered.list.md']
    expect(tokens[1][0]).toEqual value: '2.', scopes: ['text.md', 'empty.ordered.list.md', 'punctuation.md']
    expect(tokens[2][0]).toEqual value: '3.', scopes: ['text.md', 'ordered.list.md', 'punctuation.md']
    expect(tokens[2][1]).toEqual value: ' ', scopes: ['text.md', 'ordered.list.md']
    expect(tokens[2][2]).toEqual value: 'bar', scopes: ['text.md', 'ordered.list.md']

    # http://spec.commonmark.org/0.22/#example-232
    {tokens} = grammar.tokenizeLine('*')
    expect(tokens[0]).toEqual value: '*', scopes: ['text.md', 'empty.unordered.list.md', 'punctuation.md']

    # http://spec.commonmark.org/0.22/#example-241
    tokens = grammar.tokenizeLines('- foo\n  - bar\n    - baz')
    expect(tokens[0][0]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[0][2]).toEqual value: 'foo', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[1][0]).toEqual value: '  ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[1][1]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[1][2]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[1][3]).toEqual value: 'bar', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[2][0]).toEqual value: '    ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[2][1]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[2][2]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[2][3]).toEqual value: 'baz', scopes: ['text.md', 'unordered.list.md']

    # http://spec.commonmark.org/0.22/#example-242
    tokens = grammar.tokenizeLines('- foo\n - bar\n  - baz')
    expect(tokens[0][0]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[0][2]).toEqual value: 'foo', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[1][0]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[1][1]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[1][2]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[1][3]).toEqual value: 'bar', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[2][0]).toEqual value: '  ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[2][1]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[2][2]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[2][3]).toEqual value: 'baz', scopes: ['text.md', 'unordered.list.md']

    # http://spec.commonmark.org/0.22/#example-243
    tokens = grammar.tokenizeLines('10) foo\n    - bar')
    expect(tokens[0][0]).toEqual value: '10)', scopes: ['text.md', 'ordered.list.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'ordered.list.md']
    expect(tokens[0][2]).toEqual value: 'foo', scopes: ['text.md', 'ordered.list.md']
    expect(tokens[1][0]).toEqual value: '    ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[1][1]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[1][2]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[1][3]).toEqual value: 'bar', scopes: ['text.md', 'unordered.list.md']

    # http://spec.commonmark.org/0.22/#example-244
    tokens = grammar.tokenizeLines('10) foo\n   - bar')
    expect(tokens[0][0]).toEqual value: '10)', scopes: ['text.md', 'ordered.list.md', 'punctuation.md']
    expect(tokens[0][1]).toEqual value: ' ', scopes: ['text.md', 'ordered.list.md']
    expect(tokens[0][2]).toEqual value: 'foo', scopes: ['text.md', 'ordered.list.md']
    expect(tokens[1][0]).toEqual value: '   ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[1][1]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[1][2]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[1][3]).toEqual value: 'bar', scopes: ['text.md', 'unordered.list.md']

    # http://spec.commonmark.org/0.22/#example-245
    {tokens} = grammar.tokenizeLine('- - foo')
    expect(tokens[0]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[2]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[3]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md', 'unordered.list.md']
    expect(tokens[4]).toEqual value: 'foo', scopes: ['text.md', 'unordered.list.md', 'unordered.list.md']

    # http://spec.commonmark.org/0.22/#example-246
    {tokens} = grammar.tokenizeLine('1. - 2. foo')
    expect(tokens[0]).toEqual value: '1.', scopes: ['text.md', 'ordered.list.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['text.md', 'ordered.list.md']
    expect(tokens[2]).toEqual value: '-', scopes: ['text.md', 'ordered.list.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[3]).toEqual value: ' ', scopes: ['text.md', 'ordered.list.md', 'unordered.list.md']
    expect(tokens[4]).toEqual value: '2.', scopes: ['text.md', 'ordered.list.md', 'unordered.list.md', 'ordered.list.md', 'punctuation.md']
    expect(tokens[5]).toEqual value: ' ', scopes: ['text.md', 'ordered.list.md', 'unordered.list.md', 'ordered.list.md']
    expect(tokens[6]).toEqual value: 'foo', scopes: ['text.md', 'ordered.list.md', 'unordered.list.md', 'ordered.list.md']

    # http://spec.commonmark.org/0.22/#example-247
    {tokens} = grammar.tokenizeLine('- # Foo')
    expect(tokens[0]).toEqual value: '-', scopes: ['text.md', 'unordered.list.md', 'punctuation.md']
    expect(tokens[1]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md']
    expect(tokens[2]).toEqual value: '#', scopes: ['text.md', 'unordered.list.md', 'heading.md', 'heading-1.md', 'punctuation.md']
    expect(tokens[3]).toEqual value: ' ', scopes: ['text.md', 'unordered.list.md', 'heading.md', 'heading-1.md']
    expect(tokens[4]).toEqual value: 'Foo', scopes: ['text.md', 'unordered.list.md', 'heading.md', 'heading-1.md']
