CSON = require 'season'
path = require 'path'

module.exports =
  data: null
  version: null
  input: '../grammars/fixtures/fenced-code.cson'
  output: '../grammars/fenced-code.compiled.cson'

  activate: ->
    unless @grammarIsUpToDate()
      if @loadFixture()
        @updateGrammar()

  grammarIsUpToDate: ->
    filepath = path.join(__dirname, @output)
    @outputVersion = CSON.readFileSync(filepath).version
    @inputVersion = atom.packages.loadedPackages["language-markdown"].metadata.version
    return @inputVersion >= @outputVersion

  loadFixture: ->
    filepath = path.join(__dirname, @input)
    @data = CSON.readFileSync(filepath)

  updateGrammar: ->
    grammar =
      version: @inputVersion
      name: @data.name
      scopeName: @data.scopeName
      patterns: @createPatternsFromData()
    filepath = path.join(__dirname, @output)
    CSON.writeFileSync filepath, grammar, do =>
      console.log "language-markdown: Grammar for fenced-blocks updated to #{@inputVersion}"

  createPatternsFromData: ->
    patterns = []
    for item in @data.list
      if item = @parseItem(item)
        pattern =
          begin: '^\\s*([`~]{3})\\s*('+item.pattern+')$'
          beginCaptures:
            1: name: 'punctuation.md'
          end: '^\\s*(\\1)$'
          endCaptures:
            1: name: 'punctuation.md'
          name: 'fenced.code.md'
          contentName: item.contentName
          patterns: [{ include: item.include }]
        patterns.push pattern
    return patterns

  # item.pattern is required; return false if omitted
  # item.include is "source."+item.pattern if omitted
  # item.contentName is "embedded."+item.include if omitted
  parseItem: (item) ->
    if item.pattern?
      unless item.include then item.include = 'source.'+item.pattern
      unless item.contentName then item.contentName = 'embedded.'+item.include
      return item
    else
      return false
