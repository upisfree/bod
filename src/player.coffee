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

    @enableControl @

    return @
  enableControl: (p) ->
    window.onkeyup = (e) ->
      switch e.keyCode
        when 65, 37
          p.s.speedX -= 2.5 if p.s.speedX > -10
        when 68, 39
          p.s.speedX += 2.5 if p.s.speedX < 10
        when 32
          if p.beds > 0
            new Bed p.s.position.x
            p.beds -= 1
  beds: 10