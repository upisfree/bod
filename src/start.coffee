window.w = window.innerWidth
window.h = window.innerHeight

stage = new PIXI.Stage 0xFFFFFF
renderer = new PIXI.WebGLRenderer window.w, window.h
renderer.view.style.zIndex = 1
document.body.appendChild renderer.view

container = new PIXI.DisplayObjectContainer()

stage.addChild container

gravity = 1

beds = []
bedsCount = 0

player = new Player window.w / 2, window.h / 2

lava = new Lava player.position.x - window.w / 2

new Bed 0

window.onkeydown = (e) ->
  switch e.keyCode
    when 65, 37
      player.speedX -= 5
    when 68, 39
      player.speedX += 5
    when 32
      new Bed player.position.x

restart = ->
  beds = []
  Stats.bed.count = 0

  for i in stage.children
    stage.removeChild i

  container = new PIXI.DisplayObjectContainer()
  stage.addChild container

  new Bed 0
  player = new Player window.w / 2, window.h / 2

tick = ->
  # считаем позицию игрока
  player.position.x += player.speedX
  player.position.y += player.speedY
  player.speedY += gravity
  
  if player.position.y > window.h - player.height - lava.s.height
    if not isContact player.position.x, player.width
      console.log 'fail'
      #document.getElementById('fail').style.display = 'block'
      #restart()
    else
      Stats.bed.add()

      #if Math.random() > 0.5
      #  container.removeChild beds[0]
      #  beds.remove 0, 1

    player.speedY *= -0.95
    player.position.y = window.h - player.height - lava.s.height

  # ставим камеру
  renderer.offset = new PIXI.Point window.w / 2 - player.position.x, renderer.offset.y

  # анимация лавы
  lava.updatePosition player.position.x

animate = ->
  requestAnimFrame animate

  tick()

  renderer.render stage

requestAnimFrame animate