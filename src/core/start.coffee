Core.start = ->
  stage = new PIXI.Stage 0xFFFFFF
  renderer = new PIXI.WebGLRenderer window.w, window.h
  renderer.view.style.zIndex = 1
  document.body.appendChild renderer.view

  container = new PIXI.DisplayObjectContainer()
  stage.addChild container

  # background
  background = new PIXI.TilingSprite PIXI.Texture.fromImage 'https://pp.vk.me/c621626/v621626450/c761/xvMcA2K8uJo.jpg'
  background.position = { x: 0, y: 0 }
  background.width = window.w
  background.height = window.h
  background.alpha = 0.1
  container.addChild background
  # /background

  beds = []
  player = new Player window.w / 2, window.h / 2
  lava = new Lava player.s.position.x - window.w / 2

  new Bed 0

  appliedGravity = 0

  requestAnimFrame animate