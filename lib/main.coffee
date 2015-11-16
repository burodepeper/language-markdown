{CompositeDisposable, Directory} = require 'atom'
CSON = require 'season'
path = require 'path'
fs = require 'fs'

module.exports =

  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable()

    # Create a new list-item after pressing [enter]
    @subscriptions.add atom.workspace.observeTextEditors (editor) ->
      editor.onDidInsertText (event) ->
        if editor.getGrammar().name is 'Markdown'
          if event.text is "\n"
            previousRowNumber = event.range.start.row
            previousRowRange = editor.buffer.rangeForRow(previousRowNumber)
            previousLine = editor.getTextInRange(previousRowRange)
            # console.log previousLine

            # TODO
            # - Use tokens to determine if {previousLine} was indeed Markdown, and not a bit of embedded Javascript for example
            # - Determine if {previousLine} was a list-item, and if so, what kind of list-item
            # - If {previousLine} was not an empty list-item, insert the correct new list-item on the current line, with the correct amount of leading white-space

            # NOTE
            # Taken from gfm-lists by @jonmagic; not sure if it is usable.
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
