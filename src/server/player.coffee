class Player
  constructor: (@id, @x, @y, @speedX, @speedY) ->
    players[@id] = @