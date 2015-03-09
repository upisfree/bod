Stats =
  bedsCount: 0
  mileage: 0
  update: ->
    document.getElementById('bedsCount').innerText = 'BEDS: ' + Stats.bedsCount
    document.getElementById('mileage').innerText = 'MILEAGE: ' + Stats.mileage / 100 + 'm'