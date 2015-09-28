path = require 'path'
ASS = require '../lib/ass'
fs = require 'fs'

fixtures = [
  # "lists"
  # "headings"
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

      afterEach ->
        grammar = null

      # Cycle through tests
      for test, t in tests

        # it "should parse '#{test.input}'", ->
        it "should parse test '#{t}'", ->

          i = 0

          # if test.multiline

          console.log "input = '#{test.input}'"
          console.log "multiline = #{test.multiline}"
          tokens = grammar.tokenizeLines(test.input)
          for line, a in tokens
            for token, b in line
              console.log "[#{a}][#{b}].value = '#{tokens[a][b].value}'"
              expectation = test.tokens[i]
              expect(tokens[a][b]).toEqual value: expectation.value, scopes: expectation.scopes.split(' ')
              i++

          # else
          #   {tokens} = grammar.tokenizeLine(test.input)
          #   for token in tokens
          #     expectation = test.tokens[i]
          #     expect(token).toEqual value: expectation.value, scopes: expectation.scopes.split(' ')
          #     i++
