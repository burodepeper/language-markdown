# TODO Simulate pressing `tab` instead of triggering a specific command

describe "Markdown", ->

  editor = null
  grammar = null
  editorElement = null

  beforeEach ->

    waitsForPromise ->
      atom.packages.activatePackage('language-markdown')

    editor = atom.workspace.buildTextEditor()
    editor.setText('')
    editor.setCursorBufferPosition(0, 0)
    # TODO set width of tab to 2 characters, and only use soft-tabs

    runs ->
      grammar = atom.grammars.grammarForScopeName('text.md')
      editor.setGrammar(grammar)
      editorElement = atom.views.getView(editor)

  afterEach ->
    editor.setText('')

  it 'should be empty', ->
    expect(editor.isEmpty()).toBe(true)

  it 'should have Markdown selected as grammar', ->
    expect(editor.getGrammar().name).toBe('Markdown')

  it 'should have registered its custom commands', ->
    commands = atom.commands.findCommands({ target: editorElement })
    customCommands =
      'markdown:indent-list-item': false
      'markdown:outdent-list-item': false
      'markdown:toggle-task': false
    for command in commands
      if customCommands[command.name]?
        customCommands[command.name] = true
    for command, isRegistered of customCommands
      expect(isRegistered).toBe(true)

  # TODO
  # toggle-task
  # describe 'toggling tasks', ->

  describe 'indenting list-items', ->

    it 'indents a valid list-item', ->
      editor.setText('- item')
      atom.commands.dispatch(editorElement, "markdown:indent-list-item")
      expect(editor.getText()).toBe('  - item')

    it 'indents a list-item when the cursor is not at the start of a line', ->
      editor.setText('- item')
      editor.setCursorBufferPosition(0, 3)
      atom.commands.dispatch(editorElement, "markdown:indent-list-item")
      expect(editor.getText()).toBe('  - item')

    it 'indents an already indented list-item', ->
      editor.setText('  - item')
      atom.commands.dispatch(editorElement, "markdown:indent-list-item")
      expect(editor.getText()).toBe('    - item')

    # TODO How does indenting work with tabs instead of spaces?
    xit 'indents an tabbed indented list-item', ->
      editor.setText('\t- item')
      atom.commands.dispatch(editorElement, "markdown:indent-list-item")
      expect(editor.getText()).toBe('\t\t- item')

    it 'does NOT indent an invalid list-item', ->
      editor.setText('-item')
      atom.commands.dispatch(editorElement, "markdown:indent-list-item")
      expect(editor.getText()).toBe('-item')

    it 'indents a list-item with a single leading space', ->
      editor.setText(' - item')
      atom.commands.dispatch(editorElement, "markdown:indent-list-item")
      expect(editor.getText()).toBe('   - item')

    it 'does NOT indent a seemingly valid list-item as part of fenced-code', ->
      editor.setText('```\n- item\n```')
      editor.setCursorBufferPosition(1, 3)
      atom.commands.dispatch(editorElement, "markdown:indent-list-item")
      expect(editor.getText()).not.toBe('```\n  - item\n```')

    it 'indents a valid numbered list-item', ->
      editor.setText('1. item')
      atom.commands.dispatch(editorElement, "markdown:indent-list-item")
      expect(editor.getText()).toBe('  1. item')

    it 'indents a task-list-item', ->
      editor.setText('- [ ] task')
      atom.commands.dispatch(editorElement, "markdown:indent-list-item")
      expect(editor.getText()).toBe('  - [ ] task')

    # TODO it should not indent definition-lists
    xit 'does NOT indent definition-lists', ->
      editor.setText(': definition')
      atom.commands.dispatch(editorElement, "markdown:indent-list-item")
      expect(editor.getText()).toBe(': definition')

  # describe 'outdenting list-items', ->

    # TODO
    # outdent-list-item
