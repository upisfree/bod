io = require('socket.io')(5252)

players = {}

io.on 'connection', (socket) ->
  #player = new Player(socket.speedX)
  #console.log socket.data
  #socket.broadcast.emit 'user connect',
  #  id: players[players.length - 1].id,
  #  players: players.length

  io.to(socket.id).emit 'confirm connection'

  socket.on 'confirm connection', (data) ->
    new Player socket.id, data.x, data.y, data.speedX, data.speedY
    data.id = socket.id
    socket.broadcast.emit 'new user', data

  #new Player socket.id, data.x, data.y, data.speedX, data.speedY
  ##data.id = socket.id
  #socket.broadcast.emit 'new user', data

  socket.on 'connect', (data) ->
    console.log data.x, data.y
    new Player socket.id, data.x, data.y, data.speedX, data.speedY
    data.id = socket.id
    socket.broadcast.emit 'new user', data
    #socket.send 'give all users', players

  socket.on 'user change speed', (data) ->
    players[socket.id].x = data.x
    players[socket.id].y = data.y
    players[socket.id].speedX = data.speedX
    players[socket.id].speedY = data.speedY

    data.id = socket.id

    socket.broadcast.emit 'user change speed', data

  socket.on 'disconnect', ->
    socket.broadcast.emit 'user disconnect', socket.id