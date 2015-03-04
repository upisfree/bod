class Player
  constructor: (x, y) ->
    p = new PIXI.Sprite PIXI.Texture.fromImage 'http://i.imgur.com/fFEVrQr.png'
    p.position.x = 0
    p.position.y = 0
    p.width = 100
    p.height = 100
    p.speedX = Math.random() * 10
    p.speedY = (Math.random() * 10) - 5

    container.addChild p

    return p