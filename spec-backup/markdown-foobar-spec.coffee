describe "Markdown foobar spec", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-markdown")

    runs ->
      grammar = atom.grammars.grammarForScopeName("text.md")

  it "parses the grammar", ->
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "text.md"

  it "tokenizes spaces", ->
    {tokens} = grammar.tokenizeLine('FOOBAR')
    expect(tokens[0]).toEqual value: "FOOBAR", scopes: ["text.md"]
