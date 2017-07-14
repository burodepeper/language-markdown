'use babel'

import { CompositeDisposable, Directory } from 'atom'
// import { isListItem, wrapText } from './functions'

CSON = require('season')
fs = require('fs')
GrammarCompiler = require('./GrammarCompiler')
path = require('path')

module.exports = {
  config: {
    addListItems: {
      title: 'Add new list-items',
      description: 'Automatically add a new list-item after the current (non-empty) one when pressing <kbd>ENTER</kbd>',
      type: 'boolean',
      default: true
    },

    disableLanguageGfm: {
      title: 'Disable language-gfm',
      description: 'Disable the default `language-gfm` package as this package is intended as its replacement',
      type: 'boolean',
      default: true
    },

    emphasisShortcuts: {
      title: 'Emphasis shortcuts',
      description: 'Enables keybindings `_` for emphasis, `*` for strong emphasis, and `~` for strike-through on selected text; emphasizing an already emphasized selection will de-emphasize it',
      type: 'boolean',
      default: true
    },

    indentListItems: {
      title: 'Indent list-items',
      description: 'Automatically in- and outdent list-items by pressing `TAB` and `SHIFT+TAB`',
      type: 'boolean',
      default: true
    },

    linkShortcuts: {
      title: 'Link shortcuts',
      description: 'Enables keybindings `@` for converting the selected text to a link and `!` for converting the selected text to an image',
      type: 'boolean',
      default: true
    },

    removeEmptyListItems: {
      title: 'Remove empty list-items',
      description: 'Remove the automatically created empty list-items when left empty, leaving an empty line',
      type: 'boolean',
      default: true
    }
  },

  subscriptions: null,

  activate (state) {
    this.subscriptions = new CompositeDisposable()
    this.addCommands()

    /*
    Unless you are an advanced user, there is no need to have both this package
    and the one it replaces (language-gfm) enabled.

    If you are an advanced user, you can easily re-enable language-gfm again.
    */
    if (atom.config.get('language-markdown.disableLanguageGfm')) {
      if (!atom.packages.isPackageDisabled('language-gfm')) {
        atom.packages.disablePackage('language-gfm')
      }
    }

    /*
    I forgot why this action is created inline in activate() and not as a
    separate method, but there was a good reason for it.
    */
    this.subscriptions.add(atom.workspace.observeTextEditors(editor => {
      editor.onDidInsertText(event => {
        const grammar = editor.getGrammar()

        if (grammar.name !== 'Markdown') return
        if (!atom.config.get('language-markdown.addListItems')) return
        if (event.text !== '\n') return

        /*
        At this point, it is rather tedious (as far as I know) to get to the
        tokenized version of {previousLine}. That is the reason why {tokens} a
        little further down is tokenized. But at this stage, we do need to know
        if {previousLine} was in fact Markdown, or from a different perspective,
        not a piece of embedded code. The reason for that is that the tokenized
        line below is tokenized without any context, so is Markdown by default.
        Therefore we determine if our current position is part of embedded code
        or not.
        */

        const previousRowNumber = event.range.start.row
        const previousRowRange = editor.buffer.rangeForRow(previousRowNumber)
        if (this.isEmbeddedCode(editor, previousRowRange)) return

        const previousLine = editor.getTextInRange(previousRowRange)
        let { tokens } = grammar.tokenizeLine(previousLine)
        tokens.reverse()
        for (const token of tokens) {
          let isPunctuation = false
          let isListItem = false
          let typeOfList

          const scopes = token.scopes.reverse()
          for (const scope of scopes) {
            const classes = scope.split('.')

            /*
            A list-item is valid when a punctuation class is immediately
            followed by a non-empty list-item class.
            */
            if (classes.includes('punctuation')) {
              isPunctuation = true
            } else if (isPunctuation && classes.includes('list')) {
              if (!classes.includes('empty')) {
                isListItem = true
                typeOfList = 'unordered'
                if (classes.includes('ordered')) {
                  typeOfList = 'ordered'
                }
                if (classes.includes('definition')) {
                  typeOfList = 'definition'
                }
                break
              } else {
                isListItem = false
                isPunctuation = false
                if (atom.config.get('language-markdown.removeEmptyListItems')) {
                  editor.setTextInBufferRange(previousRowRange, '')
                }
              }
            } else {
              isPunctuation = false
            }
          }

          if (isListItem && typeOfList !== 'definition') {
            let text = token.value
            if (typeOfList === 'ordered') {
              const length = text.length
              const punctuation = text.match(/[^\d]+/)
              const value = parseInt(text) + 1
              text = value + punctuation
              if (text.length < length) {
                for (let j = 0; j < text.length - length + 1; j++) {
                  text = '0' + text
                }
              }
            } else {
              text = text.replace('x', ' ')
            }
            editor.insertText(text + '')
            break
          }
        }
      })
    }))
  },

  addCommands () {
    this.subscriptions.add(atom.commands.add('atom-text-editor', 'markdown:indent-list-item', (event) => this.indentListItem(event)))
    this.subscriptions.add(atom.commands.add('atom-text-editor', 'markdown:outdent-list-item', (event) => this.outdentListItem(event)))
    this.subscriptions.add(atom.commands.add('atom-text-editor', 'markdown:emphasis', (event) => this.emphasizeSelection(event, '_')))
    this.subscriptions.add(atom.commands.add('atom-text-editor', 'markdown:strong-emphasis', (event) => this.emphasizeSelection(event, '**')))
    this.subscriptions.add(atom.commands.add('atom-text-editor', 'markdown:strike-through', (event) => this.emphasizeSelection(event, '~~')))
    this.subscriptions.add(atom.commands.add('atom-text-editor', 'markdown:link', (event) => this.linkSelection(event)))
    this.subscriptions.add(atom.commands.add('atom-text-editor', 'markdown:image', (event) => this.linkSelection(event, true)))
    this.subscriptions.add(atom.commands.add('atom-text-editor', 'markdown:toggle-task', (event) => this.toggleTask(event)))

    if (atom.inDevMode()) {
      this.subscriptions.add(atom.commands.add('atom-workspace', 'markdown:compile-grammar-and-reload', () => this.compileGrammar()))
    }
  },

  indentListItem (event) {
    const { editor, position } = this._getEditorAndPosition(event)
    const indentListItems = atom.config.get('language-markdown.indentListItems')
    if (indentListItems && this.isListItem(editor, position)) {
      editor.indentSelectedRows(position.row)
      return
    }
    event.abortKeyBinding()
  },

  outdentListItem (event) {
    const { editor, position } = this._getEditorAndPosition(event)
    const indentListItems = atom.config.get('language-markdown.indentListItems')
    if (indentListItems && this.isListItem(editor, position)) {
      editor.outdentSelectedRows(position.row)
      return
    }
    event.abortKeyBinding()
  },

  emphasizeSelection (event, token) {
    if (atom.config.get('language-markdown.emphasisShortcuts')) {
      const { editor, position } = this._getEditorAndPosition(event)
      const text = editor.getSelectedText()
      if (text) {
        // Multi-line emphasis is not supported, so the command is aborted when a new-line is detected in the selection
        if (text.indexOf('\n') === -1) {
          editor.insertText(this.wrapText(text, token))
          return
        }
      }
    }
    event.abortKeyBinding()
  },

  // TODO: Doesn't place the cursor at the right position afterwards
  linkSelection (event, isImage) {
    if (atom.config.get('language-markdown.linkShortcuts')) {
      const { editor, position } = this._getEditorAndPosition(event)
      const text = editor.getSelectedText()
      if (text) {
        // Multi-line emphasis is not supported, so the command is aborted when a new-line is detected in the selection
        if (text.indexOf('\n') === -1) {
          const imageToken = isImage ? '!' : ''
          if (text.match(/[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)/)) {
            editor.insertText(imageToken + '[](' + text + ')')
            editor.setCursorBufferPosition([position.row, position.column - (text.length + 3)])
          } else {
            editor.insertText(imageToken + '[' + text + ']()')
            editor.setCursorBufferPosition([position.row, position.column - (text.length + 1)])
          }
          return
        }
      }
    }
    event.abortKeyBinding()
  },

  _getEditorAndPosition (event) {
    const editor = atom.workspace.getActiveTextEditor()
    if (editor) {
      const positions = editor.getCursorBufferPositions()
      if (positions) {
        const position = positions[0]
        return { editor, position }
      }
    }
    event.abortKeyBinding()
  },

  toggleTask (event) {
    const { editor, position } = this._getEditorAndPosition(event)
    const listItem = this.isListItem(editor, position)
    if (listItem && listItem.includes('task')) {
      const currentLine = editor.lineTextForBufferRow(position.row)
      let newLine
      if (listItem.includes('completed')) {
        newLine = currentLine.replace(' [x] ', ' [ ] ')
      } else {
        newLine = currentLine.replace(' [ ] ', ' [x] ')
      }
      const range = [[position.row, 0], [position.row, newLine.length]]
      editor.setTextInBufferRange(range, newLine)
      return
    }
    event.abortKeyBinding()
  },

  isListItem (editor, position) {
    if (editor) {
      if (editor.getGrammar().name === 'Markdown') {
        const scopeDescriptor = editor.scopeDescriptorForBufferPosition(position)
        for (const scope of scopeDescriptor.scopes) {
          if (scope.includes('list')) {
            /*
            Return {scope}, which evaluates as {true} and can be used by other
            functions to determine the type of list-item
            */
            return scope;
          }
        }
      }
    }
    return false
  },

  wrapText (text, token) {
    const length = token.length
    if ((text.substr(0, length) === token) && (text.substr(-length) === token)) {
      return text.substr(length, text.length - length * 2)
    } else {
      return token + text + token
    }
  },

  isEmbeddedCode (editor, range) {
    const scopeDescriptor = editor.scopeDescriptorForBufferPosition(range.end)
    for (const scope of scopeDescriptor.scopes) {
      if (scope.includes('source')) return true
    }
    return false
  },

  compileGrammar () {
    if (atom.inDevMode()) {
      const compiler = new GrammarCompiler()
      compiler.compile()
    }
  }
}
