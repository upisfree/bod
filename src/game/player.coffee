class Player
  constructor: (x, y) ->
    @s = new PIXI.Sprite PIXI.Texture.fromImage 'assets/textures/player.png'
    @s.position.x = 0
    @s.position.y = 0
    @s.width = window.w * 0.128
    @s.height = window.h * 0.256
    @s.speedX = Math.random() * 10
    @s.speedY = 1 #(Math.random() * 10) - 5

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
        p.beta = e.beta

        if p.beta < 180
          if p.beta <= 90
            p.s.speedX += (90 - p.beta) / 10 if p.s.speedX < 10
          else
            p.s.speedX -= (p.beta - 90) / 10 if p.s.speedX > -10
        else
          if e.beta <= 270
            p.s.speedX += (270 - p.beta) / 10 if p.s.speedX < 10
          else
            p.s.speedX -= (p.beta - 270) / 10 if p.s.speedX > -10
      , true

      document.body.addEventListener 'touchend', (e) ->
        if p.beds > 0
          if p.beta < 90
            a = 90 - p.beta
          else if p.beta >= 90 and p.beta < 180
            a = -(p.beta - 90)
          else if p.beta >= 180 and p.beta < 270
            a = 270 - p.beta
          else if p.beta >= 270 and p.beta <= 360
            a = -(p.beta - 270)
          
          new Bed p.s.position.x - a
          p.beds -= 1
      , false
  checkIsNeedBeds: ->
    m = Stats.mileage / 100
    
    if (m - m % Config.whenGiveBeds) / Config.whenGiveBeds > @timesBedsBeenGiven
      @timesBedsBeenGiven += 1
      @beds += Config.bedsCountThatGives
  timesBedsBeenGiven: 0 # rename?
  beds: 10
  beta: null