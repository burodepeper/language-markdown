path = require 'path'
ASS = require 'lib-ass'
fs = require 'fs'
_ = require 'lodash'

fixtures = [
  "issues"
  # BLOCKS
  "blocks/hr"
  "blocks/headings"
  "blocks/fenced-code"
  "blocks/link-references"
  "blocks/quotes"
  "blocks/lists"
  # INLINES
  "inlines/code-spans"
  "inlines/escapes"
  "inlines/entities"
  "inlines/emphasis"
  "inlines/links" # WIP
  "inlines/images"
  "inlines/autolinks"
  # "inlines/line-breaks"
  # FLAVORS
  "flavors/github"
  # "flavors/criticmark"
  "flavors/yaml-front-matter"
]

# Overwrite fixtures, cause this is what I'm working on...
# fixtures = [
#   "flavors/github"
# ]

describe "Markdown grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('language-markdown')

    runs ->
      grammar = atom.grammars.grammarForScopeName('text.md')

  # Test the grammar
  it "parses the grammar", ->
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "text.md"

  it "tokenizes spaces", ->
    {tokens} = grammar.tokenizeLine(" ")
    expect(tokens[0]).toEqual value: " ", scopes: ["text.md"]

  for fixture in fixtures

    # Try to load the fixture
    try
      absolutePath = path.join(__dirname, "fixtures/#{fixture}.ass")
      fileContents = fs.readFileSync(absolutePath, 'utf8')
      ass = new ASS(fileContents)
      tests = ass.getTests()
    catch error
      ass = null
      tests = 0

    # Test the basics of the fixture
    it "should load #{absolutePath}", ->
      expect(ass).not.toEqual(null)

    it "should define at least one test", ->
      expect(tests.length > 0).toEqual(true)

    # Everything seems to be okay, let's run the tests
    describe fixture, ->
      grammar = null

      beforeEach ->
        waitsForPromise ->
          atom.packages.activatePackage('language-markdown')

        runs ->
          grammar = atom.grammars.grammarForScopeName('text.md')

      # Cycle through the tests we've created in ASS
      # and we need to do it in a closure apparently
      _.forEach tests, (test) ->

        unless test.isValid
          xit "should pass test: #{fixture}/#{test.id}", ->
            return
        else

          it "should pass test: #{fixture}/#{test.id}", ->
            i = 0
            tokens = grammar.tokenizeLines(test.input)
            for line, a in tokens
              for token, b in line
                expectation = test.tokens[i]
                if tokens[a][b].value.length
                  expect(tokens[a][b]).toEqual value: expectation.value, scopes: expectation.scopes
                # else
                  # NOTE
                  # A token.value without a length has been created, and is ignored. I believe this happens when an optional capture in the grammar is empty. As far as I can tell, these can be ignored, because you would omit these (unexpected) tokens when writing manual tests.
                  # console.log "=== expectation[#{i}] for tokens[#{a}][#{b}] doesn't exist"
                  # console.log "--- value:'#{tokens[a][b].value}'"
                  # console.log "--- scopes:'#{tokens[a][b].scopes}'"
                i++
            return
