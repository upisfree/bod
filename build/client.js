(function() {
  var Animation, Bed, Camera, Config, Lava, Multiplayer, Player, Stats, animate, animations, background, beds, container, getByClass, getById, getByTag, isContact, lava, player, players, renderer, stage, tick, updateAllAnimations;

  Config = {
    gravity: 1,
    windSpeed: 0.1,
    bedsCountThatGives: 10,
    whenGiveBeds: 100,
    port: 5252
  };

  Array.prototype.min = function() {
    return Math.min.apply(null, this);
  };

  Array.prototype.max = function() {
    return Math.max.apply(null, this);
  };

  Array.prototype.remove = function(from, to) {
    var rest, _ref;
    rest = this.slice((to || from) + 1 || this.length);
    this.length = (_ref = from < 0) != null ? _ref : this.length + {
      from: from
    };
    return this.push.apply(this, rest);
  };

  getById = function(id) {
    return document.getElementById(id);
  };

  getByClass = function(c) {
    return document.getElementsByClassName(c);
  };

  getByTag = function(tag) {
    return document.getElementsByTagName(tag);
  };

  Math.randomInt = function(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min);
  };

  Math.radiansToDegrees = function(r) {
    return r * (180 / Math.PI);
  };

  Math.degreesToRadians = function(d) {
    return d * (Math.PI / 180);
  };

  animations = [];

  Animation = (function() {
    function Animation(s, p, t) {
      this.s = s;
      this.p = p;
      this.t = t;
      this.p0 = {
        x: this.s.position.x,
        y: this.s.position.y
      };
      this.t0 = Date.now();
      this.i = animations.length;
      animations.push(this);
    }

    Animation.prototype.update = function() {
      if (this.s.position.x !== this.p.x || this.s.position.y !== this.p.y) {
        this.s.position.x += this.delta(this.p0.x, this.p.x);
        return this.s.position.y += this.delta(this.p0.y, this.p.y);
      } else {
        return this.remove();
      }
    };

    Animation.prototype.remove = function() {
      return animations.splice(this.i - 1, 1);
    };

    Animation.prototype.delta = function(v0, v) {
      return ((v - v0) / this.t).toFixed();
    };

    return Animation;

  })();

  updateAllAnimations = function() {
    var animation, _i, _len, _results;
    _results = [];
    for (_i = 0, _len = animations.length; _i < _len; _i++) {
      animation = animations[_i];
      _results.push(animation.update());
    }
    return _results;
  };

  Camera = {
    set: function(point) {
      return renderer.offset = new PIXI.Point(point.x, point.y);
    }
  };

  Player = (function() {
    function Player(x, y, speedX, speedY, id) {
      this.id = id != null ? id : 0;
      this.s = new PIXI.Sprite(PIXI.Texture.fromImage('assets/textures/player.png'));
      this.s.position.x = x;
      this.s.position.y = y;
      this.s.width = 128;
      this.s.height = 256;
      if (!speedX) {
        this.s.speedX = Math.random() * 10;
      }
      if (!speedY) {
        this.s.speedY = (Math.random() * 10) - 5;
      }
      this.appliedGravity = 0;
      container.addChild(this.s);
      players[this.id] = this;
      console.log(players);
      if (this.id === 0) {
        this.enableControl(this);
      }
    }

    Player.prototype.enableControl = function(p) {
      return window.onkeydown = function(e) {
        switch (e.keyCode) {
          case 65:
          case 37:
            if (p.s.speedX > -10) {
              return p.s.speedX -= 1.5;
            }
            break;
          case 68:
          case 39:
            if (p.s.speedX < 10) {
              return p.s.speedX += 1.5;
            }
            break;
          case 32:
            if (p.beds > 0) {
              new Bed(p.s.position.x);
              return p.beds -= 1;
            }
        }
      };
    };

    Player.prototype.restart = function() {
      this.beds = Config.bedsCountThatGives;
      this.s.speedX = 2.5;
      this.s.position.x = 0;
      Stats.jumpedBeds = 0;
      return Stats.mileage = 0;
    };

    Player.prototype.checkIsNeedBeds = function() {
      var m;
      m = Stats.mileage / 100;
      if ((m - m % Config.whenGiveBeds) / Config.whenGiveBeds > this.timesBedsBeenGiven) {
        this.timesBedsBeenGiven += 1;
        return this.beds += Config.bedsCountThatGives;
      }
    };

    Player.prototype.timesBedsBeenGiven = 0;

    Player.prototype.beds = 10;

    return Player;

  })();

  beds = [];

  Bed = (function() {
    function Bed(x) {
      var texture;
      if (Math.random() > 0.2) {
        texture = 'assets/textures/bed.png';
        this.lifes = 2;
      } else {
        texture = 'assets/textures/broken_bed.png';
        this.lifes = 1;
      }
      this.s = new PIXI.Sprite(PIXI.Texture.fromImage(texture));
      this.s.width = 256;
      this.s.height = 128;
      this.s.position.x = x;
      this.s.position.y = window.h - lava.s.height - this.s.height;
      beds.push(this);
      container.addChild(this.s);
    }

    return Bed;

  })();

  isContact = function(x, w) {
    var bed, _i, _len;
    for (_i = 0, _len = beds.length; _i < _len; _i++) {
      bed = beds[_i];
      if ((x + w >= bed.s.position.x && x + w <= bed.s.position.x + bed.s.width) || (x >= bed.s.position.x && x <= bed.s.position.x + bed.s.width)) {
        bed.lifes -= 1;
        switch (bed.lifes) {
          case 1:
            bed.s.texture = PIXI.Texture.fromImage('assets/textures/broken_bed.png');
            break;
          case 0:
            container.removeChild(bed.s);
            beds.splice(beds.indexOf(bed), 1);
        }
        return bed;
      }
    }
  };

  Lava = (function() {
    function Lava(x) {
      this.s = new PIXI.TilingSprite(PIXI.Texture.fromImage('http://i.imgur.com/5rVPkJJ.png'), window.w, 64);
      this.s.position = {
        x: x,
        y: window.h - this.s.height
      };
      this.s.tilePosition = {
        x: 0,
        y: 0
      };
      stage.addChild(this.s);
      return this;
    }

    Lava.prototype.updatePosition = function(x) {
      this.s.position.x = x - window.w / 2;
      return this.s.tilePosition.x = -x / 2;
    };

    return Lava;

  })();

  Stats = {
    jumpedBeds: 0,
    mileage: 0,
    bestMileage: 0,
    update: function() {
      getById('beds').innerText = 'BEDS: ' + player.beds;
      getById('mileage').innerText = 'MILEAGE: ' + (Stats.mileage / 100).toFixed() + 'm';
      return getById('bestMileage').innerText = 'BEST: ' + (Stats.bestMileage / 100).toFixed() + 'm';
    }
  };

  Multiplayer = {
    init: function() {
      var socket;
      socket = io('http://localhost:' + Config.port);
      socket.on('confirm connection', function() {
        return socket.emit('confirm connection', {
          x: player.s.position.x,
          y: player.s.position.y,
          speedX: player.s.speedX,
          speedY: player.s.speedY
        });
      });
      socket.on('new user', function(data) {
        console.log(data.x);
        return new Player(data.x, data.y, data.speedX, data.speedY, data.id);
      });
      return socket.on('user disconnect', function(id) {});
    }
  };

  document.body.addEventListener('touchmove', function(e) {
    return e.preventDefault();
  }, false);

  window.w = window.innerWidth;

  window.h = window.innerHeight;

  stage = new PIXI.Stage(0xFFFFFF);

  renderer = new PIXI.WebGLRenderer(window.w, window.h);

  renderer.view.style.zIndex = 1;

  document.body.appendChild(renderer.view);

  background = new PIXI.TilingSprite(PIXI.Texture.fromImage('https://pp.vk.me/c621626/v621626450/c761/xvMcA2K8uJo.jpg'));

  background.position = {
    x: 0,
    y: 0
  };

  background.width = window.w;

  background.height = window.h;

  background.alpha = 0.1;

  stage.addChild(background);

  container = new PIXI.DisplayObjectContainer();

  stage.addChild(container);

  beds = [];

  players = {};

  player = new Player(window.w / 2, window.h / 2);

  lava = new Lava(player.s.position.x - window.w / 2);

  Multiplayer.init();

  tick = function() {
    var k, p;
    for (k in players) {
      p = players[k];
      p.s.position.x += p.s.speedX;
      p.s.position.y += p.s.speedY;
      p.s.speedY += Config.gravity;
      p.appliedGravity += Config.gravity;
      p.s.speedX -= Config.windSpeed;
      if (p.s.position.y > window.h - p.s.height - lava.s.height) {
        if (!isContact(p.s.position.x, p.s.width)) {
          p.restart();
          new Bed(0);
        } else {
          Stats.jumpedBeds += 1;
        }
        p.s.speedY = Math.abs(p.s.speedY) - p.appliedGravity / 50;
        p.appliedGravity = 0;
        p.s.speedY *= -1;
        p.s.position.y = window.h - player.s.height - lava.s.height;
      }
    }
    Camera.set({
      x: window.w / 2 - player.s.position.x,
      y: renderer.offset.y
    });
    lava.updatePosition(player.s.position.x);
    background.position.x = player.s.position.x - window.w / 2;
    background.tilePosition.x = player.s.position.x / 10;
    if (player.s.position.x > Stats.mileage) {
      Stats.mileage = player.s.position.x;
    }
    if (Stats.mileage > Stats.bestMileage) {
      Stats.bestMileage = Stats.mileage;
    }
    player.checkIsNeedBeds();
    return Stats.update();
  };

  animate = function() {
    requestAnimFrame(animate);
    tick();
    updateAllAnimations();
    return renderer.render(stage);
  };

  requestAnimFrame(animate);

}).call(this);
