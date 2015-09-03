describe "Markdown (headings) grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-markdown")

    runs ->
      grammar = atom.grammars.grammarForScopeName("source.md")

  it "parses the grammar", ->
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "source.md"

  it "tokenizes simple headings", ->

    # http://spec.commonmark.org/0.22/#example-27
    {tokens} = grammar.tokenizeLine("# Heading")
    expect(tokens[0]).toEqual value: "#", scopes: ["source.md", "heading.md", "heading-1.md", "punctuation.md"]
    expect(tokens[1]).toEqual value: " ", scopes: ["source.md", "heading.md", "heading-1.md"]
    expect(tokens[2]).toEqual value: "Heading", scopes: ["source.md", "heading.md", "heading-1.md"]

    # TODO
    # Commonmark examples 28 through 32

    # http://spec.commonmark.org/0.22/#example-33
    {tokens} = grammar.tokenizeLine("  ## Heading")
    expect(tokens[0]).toEqual value: "  ", scopes: ["source.md", "heading.md"]
    expect(tokens[1]).toEqual value: "##", scopes: ["source.md", "heading.md", "heading-2.md", "punctuation.md"]
    expect(tokens[2]).toEqual value: " ", scopes: ["source.md", "heading.md", "heading-2.md"]
    expect(tokens[3]).toEqual value: "Heading", scopes: ["source.md", "heading.md", "heading-2.md"]

    # TODO
    # Commonmark examples 34 through 44
