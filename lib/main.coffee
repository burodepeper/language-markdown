{CompositeDisposable, Directory} = require 'atom'
CSON = require 'season'
path = require 'path'
fs = require 'fs'

module.exports =

  config:

    addListItems:
      title: 'Add new list-items'
      description: 'Automatically add a new list-item after the current (non-empty) one when pressing `ENTER`'
      type: 'boolean'
      default: true

    disableLanguageGfm:
      title: 'Disable language-gfm'
      description: 'Disable the default `language-gfm` package as this package is intended as its replacement'
      type: 'boolean'
      default: true

    emphasisShortcuts:
      title: 'Emphasis shortcuts'
      description: 'Enables keybindings `_` for emphasis, `*` for strong emphasis, and `~` for strike-through on selected text; emphasizing an already emphasized selection will de-emphasize it'
      type: 'boolean'
      default: true

    indentListItems:
      title: 'Indent list-items'
      description: 'Automatically in- and outdent list-items by pressing `TAB` and `SHIFT+TAB`'
      type: 'boolean'
      default: true

    removeEmptyListItems:
      title: 'Remove empty list-items'
      description: 'Remove the automatically created empty list-items when left empty, leaving an empty line'
      type: 'boolean'
      default: true

  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable()

    # Add commands to overwrite the behavior of tab within list-item context
    @subscriptions.add atom.commands.add 'atom-text-editor', 'markdown:indent-list-item': (event) => @indentListItem(event)
    @subscriptions.add atom.commands.add 'atom-text-editor', 'markdown:outdent-list-item': (event) => @outdentListItem(event)

    # Add commands for emphasizing selections
    @subscriptions.add atom.commands.add 'atom-text-editor', 'markdown:emphasis': (event) => @emphasizeSelection(event, "_")
    @subscriptions.add atom.commands.add 'atom-text-editor', 'markdown:strong-emphasis': (event) => @emphasizeSelection(event, "**")
    @subscriptions.add atom.commands.add 'atom-text-editor', 'markdown:strike-through': (event) => @emphasizeSelection(event, "~~")

    # Add command to toggle a task
    @subscriptions.add atom.commands.add 'atom-text-editor', 'markdown:toggle-task': (event) => @toggleTask(event)

    # Add command to insert a new list-item
    @subscriptions.add atom.commands.add 'atom-text-editor', 'markdown:insert-list-item': (event) => @insertListItem(event)

    # Disable language-gfm as this package is intended as its replacement
    if atom.config.get('language-markdown.disableLanguageGfm')
      unless atom.packages.isPackageDisabled('language-gfm')
        atom.packages.disablePackage('language-gfm')

    # Create the {language-markdown:compile-grammar} command via which the compiler can be executed. The keybinding via which this command can be executed, is also only available in dev-mode.
    if atom.inDevMode()
      @subscriptions.add atom.commands.add 'atom-workspace', 'markdown:compile-grammar-and-reload': => @compileGrammar()

    # NOTE
    # A thank you to @jonmagic from whom I've borrowed the first bit of code to make adding new list-items a reality. My implementation has since then taken a completely different approach, but his attempt was a pleasant jump-start.
    # https://github.com/jonmagic/gfm-lists
    # @burodepeper

    # Create a new list-item after pressing [enter]
    @subscriptions.add atom.workspace.observeTextEditors (editor) ->
      editor.onDidInsertText (event) ->
        grammar = editor.getGrammar()
        if grammar.name is 'Markdown'
          if atom.config.get('language-markdown.addListItems')
            # if event.text is "\n"
            if false

              previousRowNumber = event.range.start.row
              previousRowRange = editor.buffer.rangeForRow(previousRowNumber)
              previousLine = editor.getTextInRange(previousRowRange)

              # NOTE
              # At this point, it is rather tedious (as far as I know) to get to the tokenized version of {previousLine}. That is the reason why {tokens} a little further down is tokenized. But at this stage, we do need to know if {previousLine} was in fact Markdown, or from a different perspective, not a piece of embedded code. The reason for that is that the tokenized line below is tokenized without any context, so is Markdown by default. Therefore we determine if our current position is part of embedded code or not.
              # @burodepeper

              isEmbeddedCode = false
              scopeDescriptor = editor.scopeDescriptorForBufferPosition(previousRowRange.end)
              for scope in scopeDescriptor.scopes
                if scope.indexOf('source') isnt -1
                  isEmbeddedCode = true

              unless isEmbeddedCode
                {tokens} = grammar.tokenizeLine(previousLine)

                tokens.reverse()
                for token in tokens
                  isPunctuation = false
                  isListItem = false

                  scopes = token.scopes.reverse()
                  for scope in scopes
                    classes = scope.split('.')

                    # a list-item is valid when a punctuation class is immediately followed by a non-empty list-item class
                    if classes.indexOf('punctuation') isnt -1
                      isPunctuation = true

                    else if isPunctuation and classes.indexOf('list') isnt -1
                      if classes.indexOf('empty') is -1
                        isListItem = true
                        typeOfList = 'unordered'
                        if classes.indexOf('ordered') isnt -1
                          typeOfList = 'ordered'
                        if classes.indexOf('definition') isnt -1
                          typeOfList = 'definition'
                        break

                      else
                        isListItem = false
                        isPunctuation = false
                        if atom.config.get('language-markdown.removeEmptyListItems')
                          editor.setTextInBufferRange(previousRowRange, "")

                    else
                      isPunctuation = false

                  if isListItem and typeOfList isnt 'definition'
                    text = token.value

                    # increment ordered list-item
                    if typeOfList is 'ordered'
                      length = text.length
                      punctuation = text.match(/[^\d]+/)
                      value = parseInt(text) + 1
                      text = value + punctuation

                      # add left padding to ordered list-items (003.)
                      if text.length < length
                        for i in [0 .. (text.length - length + 1)]
                          text = '0' + text

                    else
                      # Convert task-list-items into incompleted ones
                      text = text.replace('x', ' ')

                    # Force {text} to become a string; prevents rare errors
                    editor.insertText(text + '')
                    break

  _getEditor: ->
    return atom.workspace.getActiveTextEditor()

  isEmbeddedCode: (scopes) ->
    isEmbeddedCode = false
    for scope in scopes
      if scope.indexOf('source') isnt -1
        isEmbeddedCode = true
    return isEmbeddedCode

  isEmptyListItem: (tokens) ->
    for token in tokens
      for scope in tokens.scopes
        classes = scope.split('.')
        if classes.indexOf('list') isnt -1 and classes.indexOf('empty') isnt -1
          return true
    return false

  # Cycle through {tokens} and {token.scopes} to determine if a the row is a list-item. A valid list-item is detected by a punctuation scope, immediately followed by a non-empty list-item scope.
  isInsertableListItem: (tokens) ->
    for token in tokens
      isPunctuation = false
      isListItem = false
      scopes = token.scopes.reverse()

      for scope in scopes
        classes = scope.split('.')
        if classes.indexOf('punctuation') isnt -1
          isPunctuation = true
        else if isPunctuation and classes.indexOf('list') isnt -1
          if classes.indexOf('empty') is -1
            isListItem = true
            typeOfList = 'unordered'
            if classes.indexOf('ordered') isnt -1
              typeOfList = 'ordered'
            if classes.indexOf('definition') isnt -1
              typeOfList = 'definition'
            break # List-item is detected, break out of {scopes} loop
        else
          # Resets the search for a valid list-item
          isPunctuation = false

      if isListItem and typeOfList isnt 'definition'
        return true
      else
        return false

  # TODO Fix multiple-cursor issues
  insertListItem: (event) ->
    console.log "insertListItem()", event
    editor = @_getEditor()
    if editor
      positions = editor.getCursorBufferPositions()
      grammar = editor.getGrammar()
      for position in positions

        console.log("position:", position)

        previousRowRange = editor.buffer.rangeForRow(position.row)
        previousLine = editor.getTextInRange(previousRowRange)
        scopeDescriptor = editor.scopeDescriptorForBufferPosition(previousRowRange.end)
        isEmbeddedCode = false
        indentationLevel = editor.indentationForBufferRow(position.row)

        # Ignore embedded-code-blocks
        if @isEmbeddedCode(scopeDescriptor.scopes)
          event.abortKeyBinding()

        else
          {tokens} = grammar.tokenizeLine(previousLine)
          tokens.reverse()

          # Remove empty list-item
          if atom.config.get('language-markdown.removeEmptyListItems') and @isEmptyListItem(tokens)
            editor.setTextInBufferRange(previousRowRange, '')
            editor.insertText('\n')

          # Insert new list-item
          else if @isInsertableListItem(tokens)
            # text = token.value
            text = tokens.reverse().join('')

            # Increment ordered list-items
            # TODO {typeOfList} is not defined
            if typeOfList is 'ordered'
              length = text.length
              punctuation = text.match(/[^\d]+/)
              value = parseInt(text) + 1
              text = value + punctuation

              # Add left-padding to ordered list-items (ie, 0003.)
              if text.length < length
                for i in [0 .. (text.length - length + 1)]
                  text = '0' + text

            # Convert task-list-items into incompleted ones
            else
              text = text.replace('x', ' ')

            console.log("Insert <#{text}> on line", position.row + 1, "with indentation", indentationLevel)
            editor.insertText('\n' + text)
            editor.setIndentationForBufferRow(position.row + 1, indentationLevel)
            # break # Break out of the {tokens} loop
            return

      # return

    # else
    #   event.abortKeyBinding()

  indentListItem: (event) ->
    {editor, position} = @_getEditorAndPosition(event)
    indentListItems = atom.config.get('language-markdown.indentListItems')
    if indentListItems and @_getListType(editor, position)
      editor.indentSelectedRows(position.row)
    else
      event.abortKeyBinding()

  outdentListItem: (event) ->
    {editor, position} = @_getEditorAndPosition(event)
    indentListItems = atom.config.get('language-markdown.indentListItems')
    if indentListItems and @_getListType(editor, position)
      editor.outdentSelectedRows(position.row)
    else
      event.abortKeyBinding()

  emphasizeSelection: (event, token) ->
    if atom.config.get('language-markdown.emphasisShortcuts')
      {editor, position} = @_getEditorAndPosition(event)
      text = editor.getSelectedText()
      if text
        # Multi-line emphasis is not supported, so the command is aborted when a new-line is detected in the selection
        if text.indexOf("\n") is -1
          editor.insertText(@_wrapSelection(text, token))
        else
          event.abortKeyBinding()
      else
        event.abortKeyBinding()
    else
      event.abortKeyBinding()

  _wrapSelection: (text, token) ->
    # unwrap selection
    if (text.substr(0, token.length) is token) and (text.substr(-token.length) is token)
      return text.substr(token.length, text.length - token.length * 2)
    # wrap selection
    else
      return token + text + token

  _getEditorAndPosition: (event) ->
    editor = atom.workspace.getActiveTextEditor()
    if editor
      positions = editor.getCursorBufferPositions()
      if positions
        position = positions[0]
        return {editor, position}
      else
        event.abortKeyBinding()
    else
      event.abortKeyBinding()

  _getListType: (editor, position) ->
    if editor and editor.getGrammar().name is 'Markdown'
      scopeDescriptor = editor.scopeDescriptorForBufferPosition(position)
      for scope in scopeDescriptor.scopes
        if scope.indexOf('list') isnt -1
          # NOTE
          # return scope (which counts as true) which can be used to determine type of list-item
          return scope
    return false

  toggleTask: (event) ->
    {editor, position} = @_getEditorAndPosition(event)
    listItem = @_getListType(editor, position)
    if listItem and listItem.indexOf('task') isnt -1
      currentLine = editor.lineTextForBufferRow(position.row)
      if listItem.indexOf('completed') isnt -1
        newLine = currentLine.replace(" [x] ", " [ ] ")
      else
        newLine = currentLine.replace(" [ ] ", " [x] ")
      # Replace the current line with the updated version
      range = [[position.row, 0], [position.row, newLine.length]]
      editor.setTextInBufferRange(range, newLine)
    else
      event.abortKeyBinding()

  # Loads the basic grammar structure,
  # which includes the grouped parts in the repository,
  # and then loads all grammar subrepositories,
  # and appends them to the main repository,
  # and finally writes {grammar} to {output}
  compileGrammar: ->
    if atom.inDevMode()
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
        patterns: @_compileFencedCodeGrammar()

      # Write {grammar} to {filepath},
      # and reload window when complete
      filepath = path.join(__dirname, output)
      CSON.writeFileSync filepath, grammar, do ->
        atom.commands.dispatch 'body', 'window:reload'


  # Reads fixtures from {input},
  # parses {data} to expand shortened syntax,
  # creates and returns patterns from valid items in {data}.
  _compileFencedCodeGrammar: ->
    input = '../grammars/fixtures/fenced-code.cson'
    filepath = path.join(__dirname, input)
    data = CSON.readFileSync(filepath)
    @_createPatternsFromData(data)

  # Transform an {item} into a {pattern} object,
  # and adds it to the {patterns} array.
  # Returns {patterns}.
  _createPatternsFromData: (data) ->
    patterns = []
    for item in data.list
      if item = @_parseItem(item)

        pattern =
          begin: '^\\s*([`~]{3,})\\s*(\\{?)((?:\\.?)(?:'+item.pattern+'))(?=( |$|{))\\s*(\\{?)([^`\\{\\}]*)(\\}?)$'
          beginCaptures:
            1: name: 'punctuation.md'
            2: name: 'punctuation.md'
            3: name: 'language.constant.md'
            5: name: 'punctuation.md'
            6: patterns: [{ include:'#special-attribute-elements' }]
            7: name: 'punctuation.md'
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
