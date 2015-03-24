(function() {
  var Player, io, players;

  Player = (function() {
    function Player(id, x, y, speedX, speedY) {
      this.id = id;
      this.x = x;
      this.y = y;
      this.speedX = speedX;
      this.speedY = speedY;
      players[this.id] = this;
    }

    return Player;

  })();

  io = require('socket.io')(5252);

  players = {};

  io.on('connection', function(socket) {
    io.to(socket.id).emit('confirm connection');
    socket.on('confirm connection', function(data) {
      new Player(socket.id, data.x, data.y, data.speedX, data.speedY);
      data.id = socket.id;
      return socket.broadcast.emit('new user', data);
    });
    socket.on('connect', function(data) {
      console.log(data.x, data.y);
      new Player(socket.id, data.x, data.y, data.speedX, data.speedY);
      data.id = socket.id;
      return socket.broadcast.emit('new user', data);
    });
    socket.on('user change speed', function(data) {
      players[socket.id].x = data.x;
      players[socket.id].y = data.y;
      players[socket.id].speedX = data.speedX;
      players[socket.id].speedY = data.speedY;
      data.id = socket.id;
      return socket.broadcast.emit('user change speed', data);
    });
    return socket.on('disconnect', function() {
      return socket.broadcast.emit('user disconnect', socket.id);
    });
  });

}).call(this);
