class Player
  constructor: (x, y) ->
    @s = new PIXI.Sprite PIXI.Texture.fromImage 'http://i.imgur.com/fFEVrQr.png'
    @s.position.x = 0
    @s.position.y = 0
    @s.width = 100
    @s.height = 100
    @s.speedX = Math.random() * 10
    @s.speedY = (Math.random() * 10) - 5

    container.addChild @s

    @enableControl @s

    return @
  enableControl: (s) ->
    window.onkeydown = (e) ->
      switch e.keyCode
        when 65, 37
          s.speedX -= 5
        when 68, 39
          s.speedX += 5
        when 32
          new Bed s.position.x