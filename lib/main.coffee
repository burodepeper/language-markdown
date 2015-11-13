# NOTE
# When in dev-mode, the command {language-markdown:compile-grammar} is added, which triggers a re-compile of the grammar. This piece of awesomeness needs to be triggered manually however, everytime you've changed a piece of the grammar. Yay for automation. But since a change in grammar needs a reload of Atom anyway, I think I can get away with this solution.
if atom.inDevMode()

  {CompositeDisposable, Directory} = require 'atom'
  CSON = require 'season'
  path = require 'path'
  fs = require 'fs'

  module.exports =

    subscriptions: null

    # Create the {language-markdown:compile-grammar} command,
    # via which the compiler can be executed
    activate: ->
      @subscriptions = new CompositeDisposable()
      @subscriptions.add atom.commands.add 'atom-workspace', 'markdown:compile-grammar-and-reload': => @compileGrammar()

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
    compileGrammar: ->
      input = '../grammars/repositories/markdown.cson'
      output = '../grammars/language-markdown.json'
      repositoryDirectories = ['blocks', 'flavors', 'inlines']
      filepath = path.join(__dirname, input)
      grammar = CSON.readFileSync(filepath)

      for directoryName in repositoryDirectories
        directory = new Directory(path.join(__dirname, '../grammars/repositories/'+directoryName))
        entries = directory.getEntriesSync()
        for entry in entries
          {key, patterns} = CSON.readFileSync(entry.path)
          if key and patterns
            grammar.repository[key] =
              patterns: patterns

      # Compile and add fenced-code-blocks to repository
      grammar.repository['fenced-code-blocks'] =
        patterns: @compileFencedCodeGrammar()

      # Write {grammar} to {filepath},
      # and reload window when complete
      filepath = path.join(__dirname, output)
      CSON.writeFileSync filepath, grammar, do ->
        atom.commands.dispatch 'body', 'window:reload'

    # Transform an {item} into a {pattern} object,
    # and adds it to the {patterns} array.
    # Returns {patterns}.
    _createPatternsFromData: (data) ->
      patterns = []
      for item in data.list
        if item = @_parseItem(item)

          pattern =
            # begin: '^\\s*([`~]{3,})\\s*(?:\\{)((?:\\.?)(?:'+item.pattern+'))(?=( |$))\\s*([^`]*)$'
            # begin: '^\\s*([`~]{3,})\\s*((?:\\.?)(?:'+item.pattern+'))(?=( |$))\\s*([^`]*)$'
            begin: '^\\s*([`~]{3,})\\s*(\\{?)((?:\\.?)(?:'+item.pattern+'))(?=( |$))\\s*([^`\\}]*)(\\}?)$'
            beginCaptures:
              1: name: 'punctuation.md'
              2: name: 'punctuation.md'
              3: name: 'language.constant.md'
              5: patterns: [{ include:'#special-attribute-elements' }]
              6: name: 'punctuation.md'
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
