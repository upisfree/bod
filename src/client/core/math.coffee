Math.randomInt = (min, max) ->
  return Math.floor Math.random() * (max - min + 1) + min

Math.radiansToDegrees = (r) ->
  return r * (180 / Math.PI)

Math.degreesToRadians = (d) ->
  return d * (Math.PI / 180)