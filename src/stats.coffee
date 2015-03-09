Stats =
  jumpedBeds: 0
  mileage: 0
  update: ->
    document.getElementById('beds').innerText = 'BEDS: ' + player.beds
    document.getElementById('mileage').innerText = 'MILEAGE: ' + Stats.mileage / 100 + 'm'