document.body.addEventListener 'touchmove', (e) ->
  e.preventDefault()
, false

window.onresize = Core.resize

window.w = window.innerWidth
window.h = window.innerHeight

animate = ->
  requestAnimFrame animate

  Core.tick()
  updateAllAnimations()

  renderer.render stage

Core.start()
Core.resize()