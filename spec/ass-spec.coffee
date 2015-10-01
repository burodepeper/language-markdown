path = require 'path'
ASS = require '../lib/ass'
fs = require 'fs'
_ = require 'lodash'

fixtures = [
  "lists"
  "headings"
  "quotes"
  "code"
]

describe "Markdown grammar", ->

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

    it "should load #{absolutePath}", ->
      expect(ass).not.toEqual(null)

    it "should define at least one test", ->
      expect(tests.length > 0).toEqual(true)

    # Everything seems to be okay, let's run the tests
    # describe "Fixture: #{fixture}", ->
    describe fixture, ->
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
      # and we need to do it in a closure apparently
      _.forEach tests, (test) ->

        # NOTE
        # A lot of `it`s are created, and I believe that that causes a lot of unnecessary loading/activating of a package/grammar, and thus a lot of extra time spent rendering.
        it "should pass test: #{fixture}/nr.#{test.nr}", ->

          # console.log "- input:'#{test.input}'"
          i = 0
          tokens = grammar.tokenizeLines(test.input)
          for line, a in tokens
            for token, b in line
              expectation = test.tokens[i]
              # if expectation? and expectation.value?
              if tokens[a][b].value.length
                expect(tokens[a][b]).toEqual value: expectation.value, scopes: expectation.scopes
              else
                # NOTE
                # A token.value without a length has been created, and is ignored.
                console.log "=== expectation[#{i}] for tokens[#{a}][#{b}] doesn't exist"
                console.log "--- value:'#{tokens[a][b].value}'"
                console.log "--- scopes:'#{tokens[a][b].scopes}'"
              i++
          return
