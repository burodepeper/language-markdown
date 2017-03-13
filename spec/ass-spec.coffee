_ = require 'lodash'
ASS = require 'lib-ass'
{Directory} = require 'atom'
fs = require 'fs'
path = require 'path'

# NOTE
# Manually specify {fixtures} if you only want to run specific tests.
# A {fixture} is a relative path + filename (without extension).
# fixtures = [
#   # "blocks/fenced-code"
#   "flavors/math"
#   # "inlines/entities"
#   # "issues"
# ]

# Automatically generate the {fixtures} array from the file system.
# Include all .ass files found inside /spec/fixtures, by their relative path
# but excluding the file extension. This {fixture} is used to generate
# identifiers for tasks.
unless fixtures
  getFixturesFrom = (directoryPath = '') ->
    results = []
    directory = new Directory(path.join(__dirname, './fixtures' + directoryPath))
    entries = directory.getEntriesSync()
    for entry in entries
      if entry.isFile()
        filename = entry.getBaseName()
        if filename.substr(-4) is '.ass'
          fixture = directoryPath + "/" + filename.substr(0, filename.length - 4)
          results.push fixture
      else
        results = results.concat(getFixturesFrom(directoryPath + "/" + entry.getBaseName()))
    return results

  fixtures = getFixturesFrom()

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
                # NOTE
                # A token.value without a length has been created, and is
                # ignored. I believe this happens when an optional capture in
                # the grammar is empty. As far as I can tell, these can be
                # safely ignored, because you would omit these (unexpected)
                # tokens when writing manual tests.
                if tokens[a][b].value.length
                  expect(tokens[a][b]).toEqual value: expectation.value, scopes: expectation.scopes
                i++
            return
