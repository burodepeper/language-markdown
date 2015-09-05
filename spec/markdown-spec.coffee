describe "Markdown grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-markdown")

    runs ->
      grammar = atom.grammars.grammarForScopeName("text")

  it "parses the grammar", ->
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "text"

  it "tokenizes spaces", ->
    {tokens} = grammar.tokenizeLine(" ")
    expect(tokens[0]).toEqual value: " ", scopes: ["text"]
