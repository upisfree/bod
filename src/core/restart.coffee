Core.restart = ->
  new Bed 0

  player.beds = Config.bedsCountThatGives
  player.s.speedX = Math.random() * 10
  player.s.position.x = 0

  Stats.jumpedBeds = 0
  Stats.mileage = 0
  
  #new Animation player.s, { x: 0, y: player.s.position.y }, 500