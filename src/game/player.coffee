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

    if window.DeviceOrientationEvent # mobile
      window.addEventListener 'deviceorientation', (e) ->
        p.alpha = e.alpha

        if e.alpha < 180
          if e.alpha <= 90
            p.s.speedX += (90 - e.alpha) / 10 if p.s.speedX < 10
          else
            p.s.speedX -= (e.alpha - 90) / 10 if p.s.speedX > -10
        else
          if e.alpha <= 270
            p.s.speedX += (270 - e.alpha) / 10 if p.s.speedX < 10
          else
            p.s.speedX -= (e.alpha - 270) / 10 if p.s.speedX > -10
      , false

      document.body.addEventListener 'touchend', (e) ->
        if p.beds > 0
          if p.alpha < 90
            a = 90 - p.alpha
          else if p.alpha >= 90 and p.alpha < 180
            a = -(p.alpha - 90)
          else if p.alpha >= 180 and p.alpha < 270
            a = 270 - p.alpha
          else if p.alpha >= 270 and p.alpha <= 360
            a = -(p.alpha - 270)
          
          new Bed p.s.position.x - a
          #p.beds -= 1
      , false
  checkIsNeedBeds: ->
    m = Stats.mileage / 100
    
    if (m - m % Config.whenGiveBeds) / Config.whenGiveBeds > @timesBedsBeenGiven
      @timesBedsBeenGiven += 1
      @beds += Config.bedsCountThatGives
  timesBedsBeenGiven: 0 # rename?
  beds: 10
  alpha: null