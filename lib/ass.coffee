ASStest = require './ass-test'

module.exports =
class ASS
  file: null
  lines: null
  tests: null

  constructor: (@rawData) ->
    @parseData()

  parseData: ->
    @splitDataIntoLines()
    @removeEmptyLinesAndComments()
    @splitLinesIntoTests()

  splitDataIntoLines: ->
    @lines = @rawData.split("\n")

  removeEmptyLinesAndComments: ->
    lines = []
    for line in @lines
      if line.length and line[0] isnt "#"
        lines.push(line)
    @lines = lines

  splitLinesIntoTests: ->
    @tests = []
    test = []
    for line in @lines
      test.push(line)
      if line[0] is '}'
        @tests.push(new ASStest(@tests.length, test))
        test = []

  getTests: ->
    @tests
