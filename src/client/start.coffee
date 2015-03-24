document.body.addEventListener 'touchmove', (e) ->
  e.preventDefault()
, false

window.w = window.innerWidth
window.h = window.innerHeight

stage = new PIXI.Stage 0xFFFFFF
renderer = new PIXI.WebGLRenderer window.w, window.h
renderer.view.style.zIndex = 1
document.body.appendChild renderer.view

# background
background = new PIXI.TilingSprite PIXI.Texture.fromImage 'https://pp.vk.me/c621626/v621626450/c761/xvMcA2K8uJo.jpg'
background.position = { x: 0, y: 0 }
background.width = window.w
background.height = window.h
background.alpha = 0.1
stage.addChild background
# /background

container = new PIXI.DisplayObjectContainer()
stage.addChild container

beds = []
players = {}

player = new Player window.w / 2, window.h / 2

lava = new Lava player.s.position.x - window.w / 2

Multiplayer.init()

tick = ->
  # calc players position
  for k, p of players
    p.s.position.x += p.s.speedX
    p.s.position.y += p.s.speedY
    p.s.speedY += Config.gravity
    p.appliedGravity += Config.gravity
  
    # apply wind
    p.s.speedX -= Config.windSpeed

    # contact with floor (lava or bed)
    if p.s.position.y > window.h - p.s.height - lava.s.height
      if not isContact p.s.position.x, p.s.width
        p.restart()
        new Bed 0
      else
        Stats.jumpedBeds += 1

      p.s.speedY = Math.abs(p.s.speedY) - p.appliedGravity / 50
      p.appliedGravity = 0
      p.s.speedY *= -1
      p.s.position.y = window.h - player.s.height - lava.s.height

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

animate = ->
  requestAnimFrame animate

  tick()
  updateAllAnimations()

  renderer.render stage

requestAnimFrame animate