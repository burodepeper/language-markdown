
_ = require 'lodash'

line = null

parse = (obj) ->
  line = 0
  return _.chain(parsePart(obj, null))
          .flattenDeep()
          .compact()
          .groupBy('line')
          .value()

parsePart = (obj, path) ->

  if _.get(obj, 'break', false)
    line += 1
    return null

  if _.isString(obj)
    return {
      scopes: path.split('|'),
      value: obj,
      line: line
    }

  if _.isArray(obj)
    return _.map obj, (value) ->
      return parsePart(value, path, line)

  if _.isObject(obj)

    return _.map obj, (value, key) ->
      if path is null
        return parsePart(value, key, line)
      return parsePart(value, path + "|" + key, line)

module.exports = {
  parseResult: parse
}
