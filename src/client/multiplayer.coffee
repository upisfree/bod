Multiplayer =
  init: ->
    socket = io 'http://localhost:' + Config.port

    socket.on 'confirm connection', ->
      socket.emit 'confirm connection',
        x: player.s.position.x
        y: player.s.position.y
        speedX: player.s.speedX
        speedY: player.s.speedY

    socket.on 'new user', (data) ->
      console.log data.x
      new Player data.x, data.y, data.speedX, data.speedY, data.id

    #socket.on 'give all users', (data) ->
    #  console.log data
    #  for k, p of data
    #    new Player p.x, p.y, p.speedX, p.speedY, p.id

    #socket.on 'user change speed', (data) ->
    #  console.log data.x
    #  players[data.id].x = data.x
    #  players[data.id].y = data.y
    #  players[data.id].speedX = data.speedX
    #  players[data.id].speedY = data.speedY

    socket.on 'user disconnect', (id) ->
      #container.removeChild players[id].s
      #delete players[id]