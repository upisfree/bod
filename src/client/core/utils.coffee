# Array
Array::min = ->
  Math.min.apply null, @

Array::max = ->
  Math.max.apply null, @

Array::remove = (from, to) ->
  rest = @slice((to or from) + 1 or @.length)
  @length = from < 0 ? @.length + from : from
  return @push.apply(@, rest)

# html
getById = (id) ->
  return document.getElementById id

getByClass = (c) -> # class :(
  return document.getElementsByClassName c

getByTag = (tag) ->
  return document.getElementsByTagName tag