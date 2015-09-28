module.exports =
class ASStest
  nr: null
  lines: null
  input: null
  tokens: null
  currentScope: null

  constructor: (@nr, @lines) ->
    @parseData()

  parseData: ->
    @input = @lines.shift()
    @input = @input.substring(0, @input.length - 1).trim()
    @input = @input.substring(1, @input.length - 1)

    # gather tokens and scopes
    @tokens = []
    @currentScope = []
    for line in @lines
      if line isnt '}'
        line = line.trim()

        # add scope
        if line[line.length - 1] is '{'
          line = line.substring(0, line.length - 1).trim()
          @addScope(line)

        # remove scope
        else if line is '}'
          @removeScope()

        # create token if (value)
        else if line[0] is line[line.length - 1]
          token =
            value: line.substring(1, line.length - 1)
            scopes: @getScope()
          @tokens.push(token)

        # create token if (value: scope)
        else
          position = null
          for i in [line.length - 1 .. 0]
            if line[i] is ':'
              position = i
              break
          if position isnt null
            @addScope(line.substring(position + 1).trim())
            token =
              value: line.substring(1, position - 1)
              scopes: @getScope()
            @removeScope()
            @tokens.push(token)

  addScope: (scope) ->
    @currentScope.push(scope)

  removeScope: ->
    removed = @currentScope.pop()

  getScope: ->
    # NOTE
    # Returns currentScope as a string
    # "return @currentScope" doesn't work. I think because it is stored as a reference, and therefor, at the end of the run, the currentScope is reset to zero.
    return @currentScope.join(" ")
