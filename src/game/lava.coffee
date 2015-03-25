class Lava
  constructor: (x) ->
    @s = new PIXI.TilingSprite PIXI.Texture.fromImage('http://i.imgur.com/5rVPkJJ.png')
    @s.width = window.w
    @s.height = window.h * 0.064
    @s.position = { x: x, y: window.h - @s.height }
    @s.tilePosition = { x: 0, y: 0 }
    
    stage.addChild @s

    return @
  updatePosition: (x) ->
    @s.position.x = x - window.w / 2
    @s.tilePosition.x = -x / 2