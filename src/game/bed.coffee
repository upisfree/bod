beds = []

class Bed
  constructor: (x) ->
    if Math.random() > 0.2 # 1 / 10 (wow!)
      texture = 'assets/textures/bed.png'
      @lifes = 2
    else
      texture = 'assets/textures/broken_bed.png'
      @lifes = 1

    @s = new PIXI.Sprite PIXI.Texture.fromImage texture
    @s.width = window.w * 0.256
    @s.height = window.h * 0.128
    @s.position.x = x #- @s.width / 2
    @s.position.y = window.h - lava.s.height - @s.height

    beds.push @
    container.addChild @s

isContact = (x, w) ->
  for bed in beds
    if (x + w >= bed.s.position.x and x + w <= bed.s.position.x + bed.s.width) or
       (x >= bed.s.position.x and x <= bed.s.position.x + bed.s.width)
      bed.lifes -= 1

      switch bed.lifes
        when 1
          bed.s.texture = PIXI.Texture.fromImage 'assets/textures/broken_bed.png'
        when 0
          container.removeChild bed.s
          beds.splice beds.indexOf(bed), 1
      
      return bed