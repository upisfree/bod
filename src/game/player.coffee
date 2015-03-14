class Player
  constructor: (x, y) ->
    @s = new PIXI.Sprite PIXI.Texture.fromImage 'assets/textures/player.png'
    @s.position.x = 0
    @s.position.y = 0
    @s.width = 128
    @s.height = 256
    @s.speedX = Math.random() * 10
    @s.speedY = (Math.random() * 10) - 5

    container.addChild @s

    @enableControl @

    return @
  enableControl: (p) ->
    window.onkeydown = (e) -> # TODO: Mousetrap
      switch e.keyCode
        when 65, 37
          p.s.speedX -= Math.randomInt(1, 2.5) if p.s.speedX > -10
        when 68, 39
          p.s.speedX += Math.randomInt(1, 2.5) if p.s.speedX < 10
        when 32
          if p.beds > 0
            new Bed p.s.position.x
            p.beds -= 1
  checkIsNeedBeds: ->
    m = Stats.mileage / 100
    
    if (m - m % Config.whenGiveBeds) / Config.whenGiveBeds > @timesBedsBeenGiven
      @timesBedsBeenGiven += 1
      @beds += Config.bedsCountThatGives
  timesBedsBeenGiven: 0 # rename?
  beds: 10