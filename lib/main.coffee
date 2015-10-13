# HACK
# Always (and only) execute in dev-mode.
# This means that after updating any of the grammar fixtures, the package has to be reloaded in dev-mode at least once to regenerate the grammar files.
if atom.inDevMode()

  CSON = require 'season'
  path = require 'path'

  module.exports =
    
    data: null
    version: null
    input: '../grammars/fixtures/fenced-code.cson'
    output: '../grammars/fenced-code.compiled.cson'

    activate: ->
      @updateGrammar()

    loadFixture: ->
      filepath = path.join(__dirname, @input)
      @data = CSON.readFileSync(filepath)

    updateGrammar: ->
      if @loadFixture()

        grammar =
          version: @inputVersion
          name: @data.name
          scopeName: @data.scopeName
          patterns: @createPatternsFromData()
          repository:
            'fenced-code-info':
              patterns: [
                {
                  match: '([^ ]+)(=)([^ ]+)'
                  name: 'info.fenced.code.md'
                  captures:
                    1: name: 'key.keyword.md'
                    2: name: 'punctuation.md'
                    3: name: 'value.string.md'
                }
              ]

        filepath = path.join(__dirname, @output)
        CSON.writeFileSync filepath, grammar, do ->
          console.log "language-markdown: Grammar generated for 'fenced-code-blocks'"

    createPatternsFromData: ->
      patterns = []
      for item in @data.list
        if item = @parseItem(item)

          pattern =
            begin: '^\\s*([`~]{3})\\s*('+item.pattern+')(?=( |$))\\s*([^`]*)$'
            beginCaptures:
              1: name: 'punctuation.md'
              2: name: 'language.constant.md'
              4: patterns: [{ include:'#fenced-code-info' }]
            end: '^\\s*(\\1)$'
            endCaptures:
              1: name: 'punctuation.md'
            name: 'fenced.code.md'
            contentName: item.contentName
            patterns: [{ include: item.include }]

          patterns.push pattern
      return patterns

    # NOTE
    # {item.pattern} is REQUIRED; return false if omitted
    # if omitted {item.include} = "source."+item.pattern
    # if omitted {item.contentName} = "embedded."+item.include
    parseItem: (item) ->
      if item.pattern?
        unless item.include then item.include = 'source.'+item.pattern
        unless item.contentName then item.contentName = 'embedded.'+item.include
        return item
      else
        return false
