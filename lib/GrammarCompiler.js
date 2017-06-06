'use babel'

import { Directory } from 'atom'

CSON = require('season')
fs = require('fs')
path = require('path')

module.exports = class GrammarCompiler {
  constructor () {}

  // Loads the basic grammar structure,
  // which includes the grouped parts in the repository,
  // and then loads all grammar subrepositories,
  // and appends them to the main repository,
  // and finally writes {grammar} to {output}
  compile () {
    const input = '../grammars/repositories/markdown.cson'
    const output = '../grammars/language-markdown.json'
    const directories = ['blocks', 'flavors', 'inlines']
    const inputPath = path.join(__dirname, input)
    const grammar = CSON.readFileSync(inputPath)

    grammar.injections = this.compileInjectionsGrammar()

    for (let i = 0; i < directories.length; i++) {
      const directoryPath = path.join(__dirname, '../grammars/repositories/' + directories[i])
      const directory = new Directory(directoryPath)
      const entries = directory.getEntriesSync()
      for (let j = 0; j < entries.length; j++) {
        const entry = entries[j];
        const { key, patterns } = CSON.readFileSync(entry.path)
        if (key && patterns) {
          grammar.repository[key] = { patterns }
        }
      }
    }

    grammar.repository['fenced-code-blocks'] = {
      patterns: this.compileFencedCodeGrammar()
    }

    const outputPath = path.join(__dirname, output)
    CSON.writeFileSync(outputPath, grammar, (function () {
      return atom.commands.dispatch('body', 'window:reload')
    })())
  }

  // Reads fixtures from {input},
  // parses {data} to expand shortened syntax,
  // creates and returns patterns from valid items in {data}.
  compileFencedCodeGrammar () {
    const input = '../grammars/fixtures/fenced-code.cson'
    const inputPath = path.join(__dirname, input)
    const data = CSON.readFileSync(inputPath)
    return this.createPatternsFromData(data)
  }

  // Reads fixtures from {input},
  // parses {data} to expand shortened syntax,
  // creates and returns patterns from valid items in {data}.
  compileInjectionsGrammar () {
    const directoryPath = path.join(__dirname, '../grammars/injections')
    const directory = new Directory(directoryPath)
    const entries = directory.getEntriesSync()
    const injections = {}

    for (let j = 0; j < entries.length; j++) {
      const entry = entries[j];
      const { key, patterns } = CSON.readFileSync(entry.path)

      if (key && patterns) {
        injections[key] = {
          patterns: patterns
        }
      }
    }

    return injections
  }

  // Transform an {item} into a {pattern} object,
  // and adds it to the {patterns} array.
  createPatternsFromData (data) {
    const patterns = []
    for (let i = 0; i < data.list.length; i++) {
      const item = this.parseItem(data.list[i])
      if (item) {
        patterns.push({
          begin: '^\\s*([`~]{3,})\\s*(\\{?)((?:\\.?)(?:'+item.pattern+'))(?=( |$|{))\\s*(\\{?)([^`\\{\\}]*)(\\}?)$',
          beginCaptures: {
            '1': { name: 'punctuation.md' },
            '2': { name: 'punctuation.md' },
            '3': { name: 'language.constant.md' },
            '5': { name: 'punctuation.md' },
            '6': { patterns: [{ include: '#special-attribute-elements' }] },
            '7': { name: 'punctuation.md' }
          },
          end: '^\\s*(\\1)$',
          endCaptures: {
            '1': { name: 'punctuation.md' }
          },
          name: 'fenced.code.md',
          contentName: item.contentName,
          patterns: [{
            include: item.include
          }]
        })
      }
    }
    return patterns
  }

  // When provided with a valid {item} ({item.pattern} is required),
  // missing {include} and {contentName} are generated.
  parseItem (item) {
    if (typeof item === 'object' && item.pattern !== null) {
      if (!item.include && !item.contentName) {
        item.include = 'source.' + item.pattern
        item.contentName = 'source.embedded.' + item.pattern
      } else if (!item.include) {
        return false
      }
      return item
    }
    return false
  }
}
