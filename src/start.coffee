window.w = window.innerWidth
window.h = window.innerHeight

stage = new PIXI.Stage 0xFFFFFF
renderer = new PIXI.WebGLRenderer window.w, window.h
renderer.view.style.zIndex = 1
document.body.appendChild renderer.view

container = new PIXI.DisplayObjectContainer()

gravity = 1

beds = []
bedsCount = 0

new Bed 0
player = new Player window.w / 2, window.h / 2

stage.addChild container

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
  # ставим кровати
  #if not beds[0]
  #  new Bed player.position.x + Math.randomInt(100, 500), window.h - 100
  #else if beds[beds.length - 1].position.x - player.position.x <= 500 and Math.random > 0.5
  #  new Bed beds[beds.length - 1].position.x + Math.randomInt(100, 1000), window.h - 100

  # считаем позицию игрока
  player.position.x += player.speedX
  player.position.y += player.speedY
  player.speedY += gravity
  
  if player.position.y > window.h - player.height - 50
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
    player.position.y = window.h - player.height - 50

  # ставим камеру
  renderer.offset = new PIXI.Point window.w / 2 - player.position.x, renderer.offset.y

  # анимация лавы
  document.getElementById('lava').style.backgroundPosition = -player.position.x

animate = ->
  requestAnimFrame animate

  tick()

  renderer.render stage

requestAnimFrame animate