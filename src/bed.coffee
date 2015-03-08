beds = []

class Bed
  constructor: (x) ->
    @s = new PIXI.Sprite PIXI.Texture.fromImage 'http://i.imgur.com/Upp8GdF.png'
    @s.width = 200
    @s.height = 100
    @s.position.x = x
    @s.position.y = window.h - lava.s.height - @s.height
    
    @lifes = 2

    beds.push @
    container.addChild @s

isContact = (x, w) ->
  for bed in beds
    if (x + w >= bed.s.position.x and x + w <= bed.s.position.x + bed.s.width) or
       (x >= bed.s.position.x and x <= bed.s.position.x + bed.s.width)
      bed.lifes -= 1

      switch bed.lifes
        when 1
          bed.s.texture = PIXI.Texture.fromImage 'http://i.imgur.com/LfhMygw.png'
        when 0
          container.removeChild bed.s
          beds.splice beds.indexOf(bed), 1
      
      return bed