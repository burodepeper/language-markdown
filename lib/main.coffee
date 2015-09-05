
{Grammar} = require "first-mate"
CSON = require 'season'
glob = require 'glob'
_ = require 'lodash'
path = require 'path'


# options: Object
#     fileTypes: Array[9]
#     maxTokensPerLine: 100
#     name: "Pandoc Markdown"
#     patterns: Array[5]
#     repository: Object
#     scopeName: "source.gfm"
loadGrammar = () ->
  options = CSON.readFileSync(path.join(__dirname, '../rules/main.cson'))
  repositories = glob.sync(path.join(__dirname, '../rules/repositories/*.cson'))
  repositories = _.chain(repositories)
                  .map(CSON.readFileSync)
                  .indexBy('key')
                  .value()

  options.repository = _.chain(options.repository)
                        .defaults(repositories)
                        .mapValues((repository) ->
                          # Remove Patterns that have disable set to true
                          repository.patterns = _.reject(repository.patterns, 'disable')
                          repository
                        )
                        .value()


  console.warn(options)

  options

module.exports =
  activate:  ->
    #packagePath = atom.packages.getActivePath('language-markdown').path

    options = loadGrammar()

    atom.grammars.addGrammar(new Grammar(atom.grammars, options))
