function random(min, max) 
{
  return Math.floor(Math.random() * (max - min + 1)) + min; 
};

Math.rToD = function(r)
{
  return r * (180 / Math.PI);
}

Math.dToR = function(d)
{
  return d * (Math.PI / 180);
}

Array.prototype.remove = function(from, to)
{
  var rest = this.slice((to || from) + 1 || this.length);
  this.length = from < 0 ? this.length + from : from;
  return this.push.apply(this, rest);
}

/*
  погнали
*/

var _w = window.innerWidth,
    _h = window.innerHeight;

var stage = new PIXI.Stage(0xFFFFFF);
var renderer = new PIXI.WebGLRenderer(_w, _h);
renderer.view.style.zIndex = 1;
document.body.appendChild(renderer.view);

var container = new PIXI.DisplayObjectContainer();

var gravity = 10;

var beds = [];
var bedsCount = 0;

/*

http://i.imgur.com/Upp8GdF.png -- застеленная кровать
http://i.imgur.com/LfhMygw.png -- незастеленная кровать
http://i.imgur.com/fFEVrQr.png -- игрок
http://i.imgur.com/5rVPkJJ.png -- лава

*/

/*
  кровати
*/

function addBed(x, y)
{
  var bed = new PIXI.Sprite(PIXI.Texture.fromImage('http://i.imgur.com/Upp8GdF.png'));
  bed.position.x = x;
  bed.position.y = y;
  bed.width = 200;
  bed.height = 100;
  
  beds.push(bed);
  container.addChild(bed);
}

function isContact(x)
{
  for (var i = 0; i <= beds.length - 1; i++)
  {
    if (beds[i].position.x <= x && beds[i].position.x + 200 >= x)
    {
      return true;
    };    
  };
}

/*
  игрок
*/

var player = new PIXI.Sprite(PIXI.Texture.fromImage('http://i.imgur.com/fFEVrQr.png'));
player.position.x = 0;
player.position.y = 0;
player.width = 100;
player.height = 100;
player.speedX = Math.random() * 10;
player.speedY = (Math.random() * 10) - 5;

container.addChild(player);

addBed(0, _h - 100);

// нажатие клавиш
window.onkeydown = function(e)
{
  switch (e.keyCode)
  {
    case 65:
    case 37:
      player.speedX -= 5;
      break;
    case 68:
    case 39:
      player.speedX += 5;
      break;
  }
};


requestAnimFrame(animate);

stage.addChild(container);

function animate()
{
  requestAnimFrame(animate);

  // ставим кровати
  if (Math.random() < 0.1)
  {
    if (!beds[0])
      addBed(player.position.x + random(100, 500), _h - 100);      
    else
      addBed(beds[beds.length - 1].position.x + random(100, 500), _h - 100);
  };

  // считаем позицию игрока
  player.position.x += player.speedX;
  player.position.y += player.speedY;
  player.speedY += gravity;
  
  if (player.position.y > _h - player.height - 50)
  {
    if (!isContact(player.position.x))
    {
      document.getElementById('fail').style.display = 'block';
      setTimeout(location.reload(), 1000);
    }
    else
    {
      bedsCount += 1;
      document.getElementById('bedsCount').innerText = 'КРОВАТЕЙ: ' + bedsCount;

      if (Math.random() > 0.5)
      {
        container.removeChild(beds[0]);
        beds.remove(0, 1);
      }
    }

    player.speedY *= -0.85;
    player.position.y = _h - player.height - 50;
    player.spin = (Math.random()-0.5) * 0.2
    if (Math.random() > 0.5)
    {
      player.speedY -= Math.random() * 6;
    }
  }

  // ставим камеру
  renderer.offset = new PIXI.Point(_w / 2 - player.position.x, renderer.offset.y);

  // анимация лавы
  document.getElementById('lava').style.backgroundPosition = -player.position.x;

  renderer.render(stage);
}