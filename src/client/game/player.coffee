class Player
  constructor: (x, y, speedX, speedY, @id = 0) ->
    @s = new PIXI.Sprite PIXI.Texture.fromImage 'assets/textures/player.png'
    @s.position.x = x
    @s.position.y = y
    @s.width = 128
    @s.height = 256
    @s.speedX = Math.random() * 10 if not speedX
    @s.speedY = (Math.random() * 10) - 5 if not speedY

    @appliedGravity = 0

    container.addChild @s
    players[@id] = @

    console.log players

    if @id is 0
      @enableControl @
  
  enableControl: (p) ->
    window.onkeydown = (e) -> # TODO: Mousetrap
      switch e.keyCode
        when 65, 37
          p.s.speedX -= 1.5 if p.s.speedX > -10

          #socket.broadcast.emit 'user change speed',
          #  x: p.s.position.x
          #  y: p.s.position.y
          #  speedX: p.s.position.speedX
          #  speedY: p.s.position.speedY
        when 68, 39
          p.s.speedX += 1.5 if p.s.speedX < 10

          #socket.broadcast.emit 'user change speed',
          #  x: p.s.position.x
          #  y: p.s.position.y
          #  speedX: p.s.position.speedX
          #  speedY: p.s.position.speedY
        when 32
          if p.beds > 0
            new Bed p.s.position.x
            p.beds -= 1

            #socket.broadcast.emit 'user put bed',
            #  x: p.s.position.x
  
  restart: ->
    @beds = Config.bedsCountThatGives
    @s.speedX = 2.5
    @s.position.x = 0

    Stats.jumpedBeds = 0
    Stats.mileage = 0
    
    #new Animation player.s, { x: 0, y: player.s.position.y }, 500

  checkIsNeedBeds: ->
    m = Stats.mileage / 100
    
    if (m - m % Config.whenGiveBeds) / Config.whenGiveBeds > @timesBedsBeenGiven
      @timesBedsBeenGiven += 1
      @beds += Config.bedsCountThatGives
  
  timesBedsBeenGiven: 0 # rename?
  beds: 10