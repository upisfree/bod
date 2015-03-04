Array::min = ->
  Math.min.apply null, this

Array::max = ->
  Math.max.apply null, this

Array::remove = (from, to) ->
  rest = @slice((to or from) + 1 or this.length)
  @length = from < 0 ? this.length + from : from
  return @push.apply(this, rest)