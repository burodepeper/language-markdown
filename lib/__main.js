'use babel'

import { CompositeDisposable, Directory } from 'atom'
import { isListItem, wrapText } from './functions'

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

    if (atom.config.get('language-markdown.disableLanguageGfm')) {
      if (!atom.packages.isPackageDisabled('language-gfm')) {
        atom.packages.disablePackage('language-gfm')
      }
    }

    this.subscriptions.add(atom.workspace.observeTextEditors(editor => {
      editor.onDidInsertText(event => {
        const grammar = editor.getGrammar()
        if (grammar.name === 'Markdown') {
          if (atom.config.get('language-markdown.addListItems')) {
            if (event.text === '\n') {
              const previousRowNumber = event.range.start.row
              const previousRowRange = editor.buffer.rangeForRow(previousRowNumber)
              const previousLine = editor.getTextInRange(previousRowRange)

              // At this point, it is rather tedious (as far as I know) to get to the tokenized version of {previousLine}. That is the reason why {tokens} a little further down is tokenized. But at this stage, we do need to know if {previousLine} was in fact Markdown, or from a different perspective, not a piece of embedded code. The reason for that is that the tokenized line below is tokenized without any context, so is Markdown by default. Therefore we determine if our current position is part of embedded code or not.
              // @burodepeper

              let isEmbeddedCode = false
              const scopeDescriptor = editor.scopeDescriptorForBufferPosition(previousRowRange.end)
              for (let i = 0; i < scopeDescriptor.scopes.length; i++) {
                const scope = scopeDescriptor.scopes[i]
                if (scope.indexOf('source') !== -1) {
                  isEmbeddedCode = true
                }
              }

              if (!isEmbeddedCode) {
                let { tokens } = grammar.tokenizeLine(previousLine)
                tokens.reverse()
                for (let i = 0; i < tokens.length; i++) {
                  const token = tokens[i]
                  let isPunctuation = false
                  let isListItem = false
                  let typeOfList

                  const scopes = token.scopes.reverse()
                  for (let j = 0; j < scopes.length; j++) {
                    const scope = scopes[j]
                    const classes = scope.split('.')

                    // a list-item is valid when a punctuation class is immediately followed by a non-empty list-item class
                    if (classes.indexOf('punctuation') !== -1) {
                      isPunctuation = true
                    } else if (isPunctuation && classes.indexOf('list') !== -1) {
                      if (classes.indexOf('empty') === -1) {
                        isListItem = true
                        typeOfList = 'unordered'
                        if (classes.indexOf('ordered') !== -1) {
                          typeOfList = 'ordered'
                        }
                        if (classes.indexOf('definition') !== -1) {
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
              }
            }
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
    } else {
      event.abortKeyBinding()
    }
  },

  outdentListItem (event) {
    const { editor, position } = this._getEditorAndPosition(event)
    const indentListItems = atom.config.get('language-markdown.indentListItems')
    if (indentListItems && this.isListItem(editor, position)) {
      editor.outdentSelectedRows(position.row)
    } else {
      event.abortKeyBinding()
    }
  },

  emphasizeSelection (event, token) {
    if (atom.config.get('language-markdown.emphasisShortcuts')) {
      const { editor, position } = this._getEditorAndPosition(event)
      const text = editor.getSelectedText()
      if (text) {
        // Multi-line emphasis is not supported, so the command is aborted when a new-line is detected in the selection
        if (text.indexOf('\n') === -1) {
          editor.insertText(this.wrapText(text, token))
        } else {
          event.abortKeyBinding()
        }
      } else {
        event.abortKeyBinding()
      }
    } else {
      event.abortKeyBinding()
    }
  },

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
            editor.insertText(imageToken + '[' + text ']()')
            editor.setCursorBufferPosition([position.row, position.column - (text.length + 1)])
          }
        } else {
          event.abortKeyBinding()
        }
      } else {
        event.abortKeyBinding()
      }
    } else {
      event.abortKeyBinding()
    }
  },

  _getEditorAndPosition (event) {
    const editor = atom.workspace.getActiveTextEditor()
    if (editor) {
      const positions = editor.getCursorBufferPositions()
      if (positions) {
        const position = positions[0]
        return { editor, position }
      } else {
        event.abortKeyBinding()
      }
    } else {
      event.abortKeyBinding()
    }
  },

  toggleTask (event) {
    const { editor, position } = this._getEditorAndPosition(event)
    const listItem = this.isListItem(editor, position)
    if (listItem && listItem.indexOf('task') !== -1) {
      const currentLint = editor.lineTextForBufferRow(position.row)
      let newLine
      if (listItem.indexOf('completed') !== -1) {
        newLine = currentLine.replace(' [x] ', ' [ ] ')
      } else {
        newLine = currentLine.replace(' [ ] ', ' [x] ')
      }
      const range = [[position.row, 0], [position.row, newLine.length]]
      editor.setTextInBufferRange(range, newLine)
    } else {
      event.abortKeyBinding()
    }
  },

  compileGrammar () {
    if (atom.inDevMode()) {
      const compiler = new GrammarCompiler()
      compiler.compile()
    }
  }
}
