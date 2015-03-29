window.ontouchmove = (e) ->
  e.preventDefault()

window.onresize = Core.resize

window.w = window.innerWidth
window.h = window.innerHeight

setInterval ->
  Core.tick()
  updateAllAnimations()
, 1000 / 60

animate = ->
  requestAnimFrame animate
  renderer.render stage

Core.start()
Core.resize()