resize = ->
  window.w = window.innerWidth
  window.h = window.innerHeight
  
  renderer.resize window.w, window.h

  lava.s.width = window.w
  lava.s.position.y = window.h - lava.s.height

  for bed in beds
    bed.s.position.y = window.h - lava.s.height - bed.s.height