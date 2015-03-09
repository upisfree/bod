Camera =
  set: (point) ->
    renderer.offset = new PIXI.Point point.x, point.y
  #animation:
  #  update: (p0, p, t) ->
  #    if renderer.offset.x isnt p.x or
  #       renderer.offset.y isnt p.y
  #      renderer.offset.x += Camera.animation.delta p0.x, p.x, t
  #      renderer.offset.y += Camera.animation.delta p0.y, p.y, t
  #      Camera.animation.isOn = true
  #    else
  #      Camera.animation.isOn = false
  #  delta: (v0, v, t) -> # TODO: parabolic motion
  #    return Math.round (v0 - v) / t
  #  isOn: false