describe "Markdown foobar spec", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-markdown")

    runs ->
      grammar = atom.grammars.grammarForScopeName("source.md")

  it "parses the grammar", ->
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "source.md"

  it "tokenizes spaces", ->
    expect(tokens[0]).toEqual value: "FOOBAR", scopes: ["source.md"]
