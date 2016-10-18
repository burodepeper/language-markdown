# TODO
# Simulate pressing `tab` instead of triggering a specific command.
# Or is that simply outside of the scope of these specs?

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

    # Set default config so we can 'assume' these values later on
    editor.config.set('editor.softTabs', true)
    editor.config.set('editor.tabLength', 2)
    editor.config.set('editor.tabType', 'soft')

    runs ->
      grammar = atom.grammars.grammarForScopeName('text.md')
      editor.setGrammar(grammar)
      editorElement = atom.views.getView(editor)

  afterEach ->
    editor.setText('')

  xit 'should be empty', ->
    expect(editor.isEmpty()).toBe(true)

  xit 'should have Markdown selected as grammar', ->
    expect(editor.getGrammar().name).toBe('Markdown')

  xit 'should have registered its custom commands', ->
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

  xdescribe 'toggling tasks', ->

    it 'toggles a task', ->
      editor.setText('- [ ] task')
      editor.setCursorBufferPosition(0, 0)
      atom.commands.dispatch(editorElement, "markdown:toggle-task")
      expect(editor.getText()).toBe('- [x] task')

    it 'toggles a task (with the cursor half way on the line)', ->
      editor.setText('- [ ] task')
      editor.setCursorBufferPosition(0, 4)
      atom.commands.dispatch(editorElement, "markdown:toggle-task")
      expect(editor.getText()).toBe('- [x] task')

    it 'toggles a completed task', ->
      editor.setText('- [x] task')
      editor.setCursorBufferPosition(0, 0)
      atom.commands.dispatch(editorElement, "markdown:toggle-task")
      expect(editor.getText()).toBe('- [ ] task')

    it 'toggles an indented task', ->
      editor.setText('  - [ ] task')
      editor.setCursorBufferPosition(0, 0)
      atom.commands.dispatch(editorElement, "markdown:toggle-task")
      expect(editor.getText()).toBe('  - [x] task')

    it 'does not toggle an invalid task', ->
      editor.setText('- [] invalid task')
      editor.setCursorBufferPosition(0, 0)
      atom.commands.dispatch(editorElement, "markdown:toggle-task")
      expect(editor.getText()).toBe('- [] invalid task')

    it 'does nothing on a normal list-item', ->
      editor.setText('- item')
      editor.setCursorBufferPosition(0, 0)
      atom.commands.dispatch(editorElement, "markdown:toggle-task")
      expect(editor.getText()).toBe('- item')

    it 'does nothing on a bit of regular text', ->
      editor.setText('[ ] text')
      editor.setCursorBufferPosition(0, 0)
      atom.commands.dispatch(editorElement, "markdown:toggle-task")
      expect(editor.getText()).toBe('[ ] text')

  xdescribe 'indenting list-items', ->

    it 'indents a valid list-item', ->
      editor.setText('- item')
      editor.setCursorBufferPosition(0, 0)
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

    it 'indents a tabbed indented list-item', ->
      editor.setText('\t- item')
      atom.commands.dispatch(editorElement, "markdown:indent-list-item")
      expect(editor.getText()).toBe('  \t- item')

    it 'does NOT indent an invalid list-item', ->
      editor.setText('-item')
      atom.commands.dispatch(editorElement, "markdown:indent-list-item")
      expect(editor.getText()).toBe('-item')

    it 'indents a partially indented list-item', ->
      editor.setText(' - item')
      atom.commands.dispatch(editorElement, "markdown:indent-list-item")
      expect(editor.getText()).toBe('   - item')

    it 'does NOT indent a seemingly valid list-item as part of fenced-code', ->
      editor.setText('```\n- item\n```')
      editor.setCursorBufferPosition(1, 3)
      atom.commands.dispatch(editorElement, "markdown:indent-list-item")
      expect(editor.getText()).toBe('```\n- item\n```')

    it 'indents a valid numbered list-item', ->
      editor.setText('1. item')
      atom.commands.dispatch(editorElement, "markdown:indent-list-item")
      expect(editor.getText()).toBe('  1. item')

    it 'indents a task-list-item', ->
      editor.setText('- [ ] task')
      atom.commands.dispatch(editorElement, "markdown:indent-list-item")
      expect(editor.getText()).toBe('  - [ ] task')

    it 'indents definition-lists', ->
      editor.setText(': definition')
      atom.commands.dispatch(editorElement, "markdown:indent-list-item")
      expect(editor.getText()).toBe('  : definition')

  xdescribe 'outdenting list-items', ->

    it 'outdents a valid list-item', ->
      editor.setText('  - item')
      editor.setCursorBufferPosition(0, 0)
      atom.commands.dispatch(editorElement, "markdown:outdent-list-item")
      expect(editor.getText()).toBe('- item')

    it 'outdents a list-item when the cursor is not at the start of a line', ->
      editor.setText('  - item')
      editor.setCursorBufferPosition(0, 3)
      atom.commands.dispatch(editorElement, "markdown:outdent-list-item")
      expect(editor.getText()).toBe('- item')

    it 'does nothing on an unindented list-item', ->
      editor.setText('- item')
      atom.commands.dispatch(editorElement, "markdown:outdent-list-item")
      expect(editor.getText()).toBe('- item')

    it 'outdents a tabbed indented list-item', ->
      editor.setText('\t- item')
      atom.commands.dispatch(editorElement, "markdown:outdent-list-item")
      expect(editor.getText()).toBe('- item')

    it 'does NOT outdent an invalid list-item', ->
      editor.setText('  -item')
      atom.commands.dispatch(editorElement, "markdown:outdent-list-item")
      expect(editor.getText()).toBe('  -item')

    it 'outdents a partially (3 spaces) indented list-item', ->
      editor.setText('   - item')
      atom.commands.dispatch(editorElement, "markdown:outdent-list-item")
      expect(editor.getText()).toBe(' - item')

    it 'does NOT outdent a seemingly valid list-item as part of fenced-code', ->
      editor.setText('```\n  - item\n```')
      editor.setCursorBufferPosition(1, 3)
      atom.commands.dispatch(editorElement, "markdown:outdent-list-item")
      expect(editor.getText()).toBe('```\n  - item\n```')

    it 'indents a valid numbered list-item', ->
      editor.setText('  1. item')
      atom.commands.dispatch(editorElement, "markdown:outdent-list-item")
      expect(editor.getText()).toBe('1. item')

    it 'outdents a task-list-item', ->
      editor.setText('  - [ ] task')
      atom.commands.dispatch(editorElement, "markdown:outdent-list-item")
      expect(editor.getText()).toBe('- [ ] task')

    it 'outdents definition-lists', ->
      editor.setText('  : definition')
      atom.commands.dispatch(editorElement, "markdown:outdent-list-item")
      expect(editor.getText()).toBe(': definition')
