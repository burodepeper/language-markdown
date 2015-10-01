
glob = require 'glob'
yaml = require 'js-yaml'
path = require 'path'
_ = require 'lodash'
fs = require 'fs'
specHelper = require './spec-helper'

# Get filenames of each fixture file
fixtures = glob.sync(path.join(__dirname, 'fixtures', '**', '*.yaml'))

describe "Run all fixtures", ->

  _.forEach fixtures, (path) ->

    # Try loading fixture file

    fixture = null

    try
      fixture = yaml.safeLoad(fs.readFileSync(path))
    catch error
      fixture = null

    it "Loading fixtures in #{path} should not fail", ->
      expect(fixture).not.toEqual(null)

    it "#{path} should at least define one test", ->
      expect(fixture.tests.length > 0).toEqual(true)

    # Fixture file loaded successfully, let's run it:

    describe fixture.name, ->

      grammar = null

      # Activate Grammar for before each test
      beforeEach ->
        waitsForPromise ->
          atom.packages.activatePackage("language-markdown")

        runs ->
          grammar = atom.grammars.grammarForScopeName("text.md")

      # Cleanup after each test
      afterEach ->
        grammar = null

      _.forEach fixture.tests, (test) ->

        name = test.name or 'no name'

        # skip, if test has `todo: true`
        return if test.todo

        it "Test: #{name}", ->

          lines = grammar.tokenizeLines(test.md)

          result = specHelper.parseResult(test.result)

          # Result should have as many lines as markdown
          expect(lines.length).toEqual(_.size(result))

          _.forEach result, (line, lineNumber) ->

            # Each line should have exactly as much tokens as a result line
            expect(line.length).toEqual(result[lineNumber].length)

            _.forEach line, (token, tokenNumber) ->
              token = _.omit(token, 'line')
              # Each token of a line should match the result token
              expect(lines[lineNumber][tokenNumber]).toEqual(token)
