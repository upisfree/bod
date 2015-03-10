Stats =
  jumpedBeds: 0
  mileage: 0
  bestMileage: 0
  update: ->
    document.getElementById('beds').innerText = 'BEDS: ' + player.beds
    document.getElementById('mileage').innerText = 'MILEAGE: ' + (Stats.mileage / 100).toFixed() + 'm'
    document.getElementById('bestMileage').innerText = 'BEST: ' + (Stats.bestMileage / 100).toFixed() + 'm'