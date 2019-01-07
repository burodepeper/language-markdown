describe 'Add new list items', ->
  editor = null

  beforeEach ->
    waitsForPromise ->
      atom.workspace.open()
      atom.packages.activatePackage('language-markdown')
    runs ->
      # with `buildTextEditor` the `onDidInsertText` event will never be emitted
      editor = atom.workspace.getActiveTextEditor()
      editor.setGrammar(atom.grammars.grammarForScopeName('text.md'))

  it 'ignores `setCursorBufferPosition`', ->
    editor.setText('0123')
    editor.setCursorBufferPosition(0, 4)
    expect(editor.getCursorBufferPosition().column).toBe(0)
    editor.insertText('x')
    expect(editor.getText()).toBe('x0123')

  it 'updates cursor position properly on `insertText`', ->
    editor.insertText('0123')
    expect(editor.getCursorBufferPosition().column).toBe(4)
    editor.insertText('x')
    expect(editor.getCursorBufferPosition().column).toBe(5)
    expect(editor.getText()).toBe('0123x')

  it 'should not create new list item on newline when disabled', ->
    atom.config.set('language-markdown.addListItems', false)
    expect(atom.config.get('language-markdown.addListItems')).toBe(false)
    editor.insertText('- item')
    editor.insertNewline()
    expect(editor.getText()).toBe('- item\n')

  it 'should create new list item on newline', ->
    editor.insertText('- item')
    editor.insertText('\n')
    expect(editor.getText()).toBe('- item\n- ')

  it 'should reproduce whitespaces between list item and content', ->
    editor.insertText('-   item')
    editor.insertText('\n')
    expect(editor.getText()).toBe('-   item\n-   ')

  it 'should reproduce tabs between list item and content', ->
    editor.insertText('-\titem')
    editor.insertText('\n')
    expect(editor.getText()).toBe('-\titem\n-\t')

  it 'should work with autoindent', ->
    editor.insertText('    - item')
    editor.autoIndent = true  # is there a better way to activate this?
    editor.insertText('\n')
    expect(editor.getText()).toBe('    - item\n    - ')

  it 'should reproduce whitespaces in nested lists, with help from autoindent', ->
    editor.insertText('-  item 1\n  -  item 2')
    editor.autoIndent = true  # is there a better way to activate this?
    editor.insertText('\n')
    expect(editor.getText()).toBe('-  item 1\n  -  item 2\n  -  ')

  it 'increments the count of numbered list items', ->
    editor.insertText('1. One')
    editor.insertText('\n')
    expect(editor.getText()).toBe('1. One\n2. ')

  it 'reproduces the previous line\'s whitespace with numbered list items', ->
    editor.insertText('1.   One')
    editor.insertText('\n')
    expect(editor.getText()).toBe('1.   One\n2.   ')

  it 'should not remove empty list items when disabled', ->
    atom.config.set('language-markdown.removeEmptyListItems', false)
    editor.insertText('- item')
    editor.insertText('\n')
    editor.insertText('\n')
    expect(editor.getText()).toBe('- item\n- \n')

  it 'should remove empty list items', ->
    editor.insertText('- item')
    editor.insertText('\n')
    editor.insertText('\n')
    expect(editor.getText()).toBe('- item\n\n')

  it 'should remove empty list items with multiple whitespaces', ->
    editor.insertText('-   item')
    editor.insertText('\n')
    editor.insertText('\n')
    expect(editor.getText()).toBe('-   item\n\n')
