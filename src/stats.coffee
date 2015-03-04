Stats =
  bed:
    add: ->
      Stats.bed.count += 1
      document.getElementById('bedsCount').innerText = 'КРОВАТЕЙ: ' + Stats.bed.count
    count: 0