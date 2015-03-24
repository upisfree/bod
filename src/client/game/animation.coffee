animations = []

class Animation
  constructor: (@s, @p, @t) ->
    @p0 = { x: @s.position.x, y: @s.position.y }
    @t0 = Date.now()
    @i = animations.length
    animations.push @
  update: ->
    if @s.position.x isnt @p.x or
       @s.position.y isnt @p.y
      @s.position.x += @delta @p0.x, @p.x
      @s.position.y += @delta @p0.y, @p.y
    else
      @remove()
  remove: ->
    animations.splice @.i - 1, 1
  delta: (v0, v) -> # TODO: parabolic motion
    return ((v - v0) / @t).toFixed()

updateAllAnimations = ->
  for animation in animations
    animation.update()