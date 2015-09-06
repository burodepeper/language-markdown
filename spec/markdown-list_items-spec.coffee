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

    # TODO http://spec.commonmark.org/0.22/#example-214

    # TODO http://spec.commonmark.org/0.22/#example-215

    # TODO http://spec.commonmark.org/0.22/#example-216

    # TODO http://spec.commonmark.org/0.22/#example-217

    # TODO http://spec.commonmark.org/0.22/#example-218
