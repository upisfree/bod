ticks = 0

Core.tick = ->
  ticks += 1

  # calc player position
  player.s.position.x += player.s.speedX
  player.s.position.y += player.s.speedY
  player.s.speedY += Config.gravity
  
  # apply wind
  player.s.speedX -= Config.windSpeed

  # contact with floor (lava or bed)
  if player.s.position.y > window.h - player.s.height - lava.s.height
    if not isContact player.s.position.x, player.s.width
      #Core.restart()
    else
      Stats.jumpedBeds += 1

    player.s.speedY -= Math.abs(Config.gravity * 2) if ticks > 2
    player.s.speedY *= -1
    player.s.position.y = window.h - player.s.height - lava.s.height

  # set camera
  Camera.set { x: window.w / 2 - player.s.position.x, y: renderer.offset.y }
  
  # lava animation
  lava.updatePosition player.s.position.x

  # background animation
  background.position.x = player.s.position.x - window.w / 2
  background.tilePosition.x = player.s.position.x / 10

  # update stats
  Stats.mileage = player.s.position.x if player.s.position.x > Stats.mileage
  Stats.bestMileage = Stats.mileage if Stats.mileage > Stats.bestMileage
  player.checkIsNeedBeds()
  Stats.update()