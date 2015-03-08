beds = []

class Bed
  constructor: (x) ->
    b = new PIXI.Sprite PIXI.Texture.fromImage 'http://i.imgur.com/Upp8GdF.png'
    b.width = 200
    b.height = 100
    b.position.x = x
    b.position.y = window.h - b.height
    
    beds.push b
    container.addChild b

isContact = (x, w) ->
  for bed in beds
    if (x + w >= bed.position.x and x + w <= bed.position.x + bed.width) or
       (x >= bed.position.x and x <= bed.position.x + bed.width)
      return bed