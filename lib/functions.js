'use babel'

function isListItem (editor, position) {
  if (editor) {
    if (editor.getGrammar().name === 'Markdown') {
      const scopeDescriptor = editor.scopeDescriptorForBufferPosition(position)
      for (let i = 0; i < scopeDescriptor.scopes.length; i++) {
        const scope = scopeDescriptor.scopes[i];
        if (scope.indexOf('list') !== -1) {
          // Return {scope}, which evaluates as {true} and can be used by other functions to determine the type of list-item
          return scope;
        }
      }
    }
  }
  return false
}

function wrapText (text, token) {
  const length = token.length
  if ((text.substr(0, length) === token) && (text.substr(-length) === token)) {
    return text.substr(length, text.length - length * 2)
  } else {
    return token + text + token
  }
}

export { isListItem, wrapText }
