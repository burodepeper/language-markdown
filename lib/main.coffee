{CompositeDisposable, Directory} = require 'atom'
CSON = require 'season'
path = require 'path'
fs = require 'fs'

module.exports =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable()

    # NOTE
    # https://atom.io/docs/api/v1.2.0/TextEditor
    # https://atom.io/docs/api/v1.2.0/ScopeDescriptor
    # https://atom.io/docs/latest/behind-atom-scoped-settings-scopes-and-scope-descriptors

    # TODO
    # Add thank-you for @jonmagic

    # TODO
    # Add an option to disable automatic list-items in settings-panel

    # Create a new list-item after pressing [enter]
    @subscriptions.add atom.workspace.observeTextEditors (editor) ->
      editor.onDidInsertText (event) ->
        grammar = editor.getGrammar()
        if grammar.name is 'Markdown'
          if event.text is "\n"

            previousRowNumber = event.range.start.row
            previousRowRange = editor.buffer.rangeForRow(previousRowNumber)
            previousLine = editor.getTextInRange(previousRowRange)
            {tokens} = grammar.tokenizeLine(previousLine)

            tokens.reverse()
            for token in tokens
              isPunctuation = false
              isListItem = false

              scopes = token.scopes.reverse()
              for scope in scopes
                classes = scope.split('.')

                # TODO
                # list-item is valid when a punctuation class is immediately
                # followed by a non-empty list class
                if classes.indexOf('punctuation') isnt -1
                  isPunctuation = true
                if classes.indexOf('list') isnt -1
                  if isPunctuation and classes.indexOf('empty') is -1
                    isListItem = true

              if isListItem and isPunctuation
                # TODO make the 'space' part of an empty list-item
                # TODO increment ordered list-item
                # TODO add left padding to ordered list-items (003.)
                # TODO add incomplete task-list-item
                # TODO skip definition-lists?
                editor.insertText token.value
                break

            # scopeDescriptor = editor.scopeDescriptorForBufferPosition(previousRowRange.end)
            # # console.log scopeDescriptor
            #
            # # Determine via {scopeDescriptor.scopes} if {previousLine} was a
            # # non-empty list-item
            # isListItem = false
            # for scope in scopeDescriptor.scopes.reverse()
            #   scopes = scope.split('.')
            #   if scopes.indexOf('list') isnt -1
            #     if scopes.indexOf('empty') is -1
            #       isListItem = true
            #       # console.log scopes
            #       break
            #
            # if isListItem
            #   console.log "isListItem:", isListItem
            #   grammar = editor.getGrammar()
            #   {tokens} = grammar.tokenizeLine(previousLine)
            #   console.log tokens


              # NOTE
              # Taken from gfm-lists by @jonmagic
              #
              # match = previous_line.match(/^\s*([\-|\*]\s\[[x|\s]\]|\*|\-|\d\.)\s.+/)
              # console.log(match)
              # if match
              #   switch match[1]
              #     when "*"     then editor.insertText "* "
              #     when "-"     then editor.insertText "- "
              #     when "- [ ]" then editor.insertText "- [ ] "
              #     when "* [ ]" then editor.insertText "* [ ] "
              #     when "- [x]" then editor.insertText "- [ ] "
              #     when "* [x]" then editor.insertText "* [ ] "
              #     else editor.insertText "#{parseInt(match[1]) + 1}. "

    # Only when in dev-mode,
    # create the {language-markdown:compile-grammar} command,
    # via which the compiler can be executed
    if atom.inDevMode()
      @subscriptions.add atom.commands.add 'atom-workspace', 'markdown:compile-grammar-and-reload': => @compileGrammar()

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

  # Reads fixtures from {input},
  # parses {data} to expand shortened syntax,
  # creates and returns patterns from valid items in {data}.
  compileFencedCodeGrammar: ->
    input = '../grammars/fixtures/fenced-code.cson'
    filepath = path.join(__dirname, input)
    data = CSON.readFileSync(filepath)
    @createPatternsFromData(data)

  # Transform an {item} into a {pattern} object,
  # and adds it to the {patterns} array.
  # Returns {patterns}.
  createPatternsFromData: (data) ->
    patterns = []
    for item in data.list
      if item = @parseItem(item)

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
  parseItem: (item) ->
    if (typeof item is 'object') and item.pattern?
      unless item.include then item.include = 'source.'+item.pattern
      unless item.contentName then item.contentName = 'embedded.'+item.include
      return item
    else
      return false
