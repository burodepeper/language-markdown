if atom.inDevMode()

  CSON = require 'season'
  path = require 'path'

  module.exports =
    data: null
    version: null
    input: '../grammars/fixtures/fenced-code.cson'
    output: '../grammars/fenced-code.compiled.cson'

    activate: ->
      # HACK Always (and only) execute in dev-mode. This means that after updating the fixtures list, the package has to be reloaded at least once to regenerate the fenced-code-blocks grammar.
      if @loadFixture()
        @updateGrammar()

      # unless @grammarIsUpToDate()
      #   if @loadFixture()
      #     @updateGrammar()

    # NOTE disabled, because we temporarily don't rely on this method of updating
    # grammarIsUpToDate: ->
    #   filepath = path.join(__dirname, @output)
    #   @outputVersion = CSON.readFileSync(filepath).version
    #   @inputVersion = atom.packages.loadedPackages["language-markdown"].metadata.version
    #   return @inputVersion >= @outputVersion

    loadFixture: ->
      filepath = path.join(__dirname, @input)
      @data = CSON.readFileSync(filepath)

    updateGrammar: ->
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
        # console.log "language-markdown: Grammar for fenced-blocks updated to #{@inputVersion}"
        console.log "language-markdown: Grammar for fenced-blocks updated via dev-mode"

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
