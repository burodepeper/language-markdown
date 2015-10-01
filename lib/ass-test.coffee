module.exports =
class ASStest
  id: null
  lines: null
  input: null
  tokens: null
  currentScope: null
  isValid: false

  constructor: (@id, @lines) ->
    @parseData()

  parseData: ->
    # @input = @lines.shift()
    # @input = @input.substring(0, @input.length - 1).trim()
    # @input = @input.substring(1, @input.length - 1)
    # @input = @input.replace(/\\n/g, '\n')

    if (@lines[0][0] is '@')
      @id = @lines.shift().substring(1)

    @input = ""
    while (@lines[0][0] is '"') or (@lines[0][0] is "'")
      input = @lines.shift()
      # remove last character (either { or +) and trim whitespace
      input = input.substring(0, input.length - 1).trim()
      # remove encasing quotes
      input = input.substring(1, input.length - 1)
      # transform \n into proper new lines
      input = input.replace(/\\n/g, '\n')
      # insert a new line when concatenating multiple input lines
      if @input then @input += '\n'
      @input += input

      # NOTE
      # If @input.length is 0 then test is empty, and thus can be skipped
      @isValid = true if @input.length

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
    return @currentScope.join(" ").split(" ")
