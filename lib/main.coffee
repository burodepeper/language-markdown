'use babel'

{CompositeDisposable, Directory} = require 'atom'
CSON = require 'season'
GrammarCompiler = require './GrammarCompiler'
path = require 'path'
fs = require 'fs'

# import {isListItem, wrapText} from './functions'

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

    linkShortcuts:
      title: 'Link shortcuts'
      description: 'Enables keybindings `@` for converting the selected text to a link and `!` for converting the selected text to an image'
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

    # Add command for linkifying selections
    @subscriptions.add atom.commands.add 'atom-text-editor', 'markdown:link': (event) => @linkSelection(event)
    @subscriptions.add atom.commands.add 'atom-text-editor', 'markdown:image': (event) => @linkSelection(event, true)

    # Add command to toggle a task
    @subscriptions.add atom.commands.add 'atom-text-editor', 'markdown:toggle-task': (event) => @toggleTask(event)

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
            if event.text is "\n"

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

  indentListItem: (event) ->
    {editor, position} = @_getEditorAndPosition(event)
    indentListItems = atom.config.get('language-markdown.indentListItems')
    if indentListItems and @isListItem(editor, position)
      editor.indentSelectedRows(position.row)
    else
      event.abortKeyBinding()

  outdentListItem: (event) ->
    {editor, position} = @_getEditorAndPosition(event)
    indentListItems = atom.config.get('language-markdown.indentListItems')
    if indentListItems and @isListItem(editor, position)
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
          editor.insertText(@wrapText(text, token))
        else
          event.abortKeyBinding()
      else
        event.abortKeyBinding()
    else
      event.abortKeyBinding()

  linkSelection: (event, isImage) ->
    if atom.config.get('language-markdown.linkShortcuts')
      {editor, position} = @_getEditorAndPosition(event)
      text = editor.getSelectedText()
      if text
        # Multi-line emphasis is not supported, so the command is aborted when a new-line is detected in the selection
        if text.indexOf("\n") is -1
          imageToken = if isImage then '!' else ''
          if text.match(/[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/)
            # if text.match(/\.(jpg|jpeg|png|gif|tiff)/) then imageToken = '!'
            editor.insertText(imageToken + '[](' + text + ')')
            {editor, position} = @_getEditorAndPosition(event)
            editor.setCursorBufferPosition([position.row, position.column - (text.length + 3)])
          else
            editor.insertText(imageToken + '[' + text + ']()')
            {editor, position} = @_getEditorAndPosition(event)
            editor.setCursorBufferPosition([position.row, position.column - 1])
        else
          event.abortKeyBinding()
      else
        event.abortKeyBinding()
    else
      event.abortKeyBinding()

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

  toggleTask: (event) ->
    {editor, position} = @_getEditorAndPosition(event)
    listItem = @isListItem(editor, position)
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

  compileGrammar: ->
    if atom.inDevMode()
      compiler = new GrammarCompiler()
      compiler.compile()
      return

  isListItem: (editor, position) ->
    if editor and editor.getGrammar().name is 'Markdown'
      scopeDescriptor = editor.scopeDescriptorForBufferPosition(position)
      for scope in scopeDescriptor.scopes
        if scope.indexOf('list') isnt -1
          return scope
    return false

  wrapText: (text, token) ->
    length = token.length
    if (text.substr(0, length) is token) and (text.substr(-length) is token)
      return text.substr(length, text.length - length * 2)
    else
      return token + text + token
