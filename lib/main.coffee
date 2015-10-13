# HACK
# Only execute this code in dev-mode; no client-side compiling.
# This means that after updating any of the grammar fixtures, the package
# has to be reloaded in dev-mode to compile the grammar files.

# if atom.inDevMode()
if false

  CSON = require 'season'
  {Directory} = require 'pathwatcher'
  path = require 'path'
  fs = require 'fs'

  module.exports =

    activate: ->
      @combineGrammarRepositories()

    # Reads fixtures from {input},
    # parses {data} to expand shortened syntax,
    # creates and returns patterns from valid items in {data}.
    compileFencedCodeGrammar: ->
      input = '../grammars/fixtures/fenced-code.cson'
      filepath = path.join(__dirname, input)
      data = CSON.readFileSync(filepath)
      @_createPatternsFromData(data)

    # Loads the basic grammar structure,
    # which includes the grouped parts in the repository,
    # and then loads all grammar subrepositories,
    # and appends them to the main repository,
    # and finally writes {grammar} to {output}
    combineGrammarRepositories: ->
      input = '../grammars/repositories/markdown.cson'
      output = '../grammars/markdown.compiled.cson'
      repositoryDirectories = ['blocks', 'flavors', 'inlines']
      filepath = path.join(__dirname, input)
      grammar = CSON.readFileSync(filepath)

      for directoryName in repositoryDirectories
        directory = new Directory(path.join(__dirname, '../grammars/repositories/'+directoryName))
        entries = directory.getEntriesSync()
        for entry in entries
          {key, patterns} = CSON.readFileSync(entry.path)
          if key and patterns
            grammar.repository[key] = patterns

      # Compile and add fenced-code-blocks to repository
      grammar.repository['fenced-code-blocks'] = @compileFencedCodeGrammar()

      # FIXME
      # Either
      # 1) grammar must be written as JSON (change {output} to .json), but that isn't interpreted;
      # 2) grammar must be written as CSON, but without double quotes string
      # because of two FIXME's in /grammars/repositories/blocks/headings.cson
      filepath = path.join(__dirname, output)
      CSON.writeFileSync filepath, grammar

    # Transform an {item} into a {pattern} object,
    # and adds it to the {patterns} array.
    # Returns {patterns}.
    _createPatternsFromData: (data) ->
      patterns = []
      for item in data.list
        if item = @_parseItem(item)

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

    # When provided with a valid {item} ({item.pattern} is required),
    # missing {include} and/or {contentName} are generated.
    _parseItem: (item) ->
      if (typeof item is 'object') and item.pattern?
        unless item.include then item.include = 'source.'+item.pattern
        unless item.contentName then item.contentName = 'embedded.'+item.include
        return item
      else
        return false
