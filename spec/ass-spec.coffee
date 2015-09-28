path = require 'path'
ASS = require '../lib/ass'
fs = require 'fs'
# _ = require 'lodash'

fixtures = [
  "lists"
  "headings"
  "quotes"
]

describe "Markdown grammar", ->

  for fixture in fixtures

    # Try to load the fixture
    try
      absolutePath = path.join(__dirname, "asses/#{fixture}.ass")
      fileContents = fs.readFileSync(absolutePath, 'utf8')
      ass = new ASS(fileContents)
      tests = ass.getTests()
    catch error
      ass = null
      tests = 0

    it "should load #{absolutePath}", ->
      expect(ass).not.toEqual(null)

    it "should define at least one test", ->
      expect(tests.length > 0).toEqual(true)

    # Everything seems to be okay, let's run the tests
    describe "Fixture: #{fixture}", ->
      grammar = null

      beforeEach ->
        waitsForPromise ->
          atom.packages.activatePackage('language-markdown')

        runs ->
          grammar = atom.grammars.grammarForScopeName('text.md')

      it "parses the grammar", ->
        expect(grammar).toBeDefined()
        expect(grammar.scopeName).toBe "text.md"

      it "tokenizes spaces", ->
        {tokens} = grammar.tokenizeLine(" ")
        expect(tokens[0]).toEqual value: " ", scopes: ["text.md"]

      # Cycle through the tests we've created in ASS
      for test, t in tests
      # _.forEach tests, (test) ->

        # TODO The line below causes the test to be skipped...
        # it "should parse '#{test.input}'", ->
        it "should parse test '#{t}'", ->
          i = 0
          tokens = grammar.tokenizeLines(test.input)
          for line, a in tokens
            for token, b in line
              expectation = test.tokens[i]
              expect(tokens[a][b]).toEqual value: expectation.value, scopes: expectation.scopes.split(' ')
              i++
          return
