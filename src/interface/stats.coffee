Stats =
  jumpedBeds: 0
  mileage: 0
  bestMileage: 0
  update: ->
    getById('beta').innerText = 'BETA: ' + player.beta.toFixed()
    getById('speed').innerText = 'SPEED: ' + player.s.speedX

    getById('beds').innerText = 'BEDS: ' + player.beds
    getById('mileage').innerText = 'MILEAGE: ' + (Stats.mileage / 100).toFixed() + 'm'
    getById('bestMileage').innerText = 'BEST: ' + (Stats.bestMileage / 100).toFixed() + 'm'