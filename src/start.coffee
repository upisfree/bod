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

gravity = 1

beds = []
player = new Player window.w / 2, window.h / 2
lava = new Lava player.s.position.x - window.w / 2

new Bed 0

restart = ->
  new Bed 0

  player.beds = 10
  player.s.speedX = Math.random() * 10
  player.s.position.x = 0

  Stats.jumpedBeds = 0
  Stats.mileage = 0
  
  new Animation player.s, { x: 0, y: player.s.position.y }, 500

tick = ->
  # calc player position
  player.s.position.x += player.s.speedX
  player.s.position.y += player.s.speedY
  player.s.speedY += gravity
  
  if player.s.position.y > window.h - player.s.height - lava.s.height
    if not isContact player.s.position.x, player.s.width
      restart()
    else
      Stats.jumpedBeds += 1

    player.s.speedY *= -0.95
    player.s.position.y = window.h - player.s.height - lava.s.height

  # set camera
  Camera.set { x: window.w / 2 - player.s.position.x, y: renderer.offset.y }
  
  # lava animation
  lava.updatePosition player.s.position.x

  # background animation
  background.position.x = player.s.position.x - window.w / 2
  background.tilePosition.x = player.s.position.x / 10

  # update stats
  Stats.mileage = Math.round player.s.position.x if player.s.position.x > Stats.mileage
  Stats.update()

animate = ->
  requestAnimFrame animate

  tick()
  updateAllAnimations()

  renderer.render stage

requestAnimFrame animate