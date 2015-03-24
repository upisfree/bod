(function(){var a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z;w=m=t=k=l=s=r=j=null,d={gravity:1,windSpeed:.1,bedsCountThatGives:10,whenGiveBeds:100},Array.prototype.min=function(){return Math.min.apply(null,this)},Array.prototype.max=function(){return Math.max.apply(null,this)},Array.prototype.remove=function(a,b){var c,d;return c=this.slice((b||a)+1||this.length),this.length=null!=(d=0>a)?d:this.length+{from:a},this.push.apply(this,c)},o=function(a){return document.getElementById(a)},n=function(a){return document.getElementsByClassName(a)},p=function(a){return document.getElementsByTagName(a)},Math.randomInt=function(a,b){return Math.floor(Math.random()*(b-a+1)+a)},Math.radiansToDegrees=function(a){return a*(180/Math.PI)},Math.degreesToRadians=function(a){return a*(Math.PI/180)},u=function(){var a,b,c,d;for(window.w=window.innerWidth,window.h=window.innerHeight,t.resize(window.w,window.h),r.s.width=window.w,r.s.position.y=window.h-r.s.height,d=[],b=0,c=l.length;c>b;b++)a=l[b],d.push(a.s.position.y=window.h-r.s.height-a.s.height);return d},i=[],a=function(){function a(a,b,c){this.s=a,this.p=b,this.t=c,this.p0={x:this.s.position.x,y:this.s.position.y},this.t0=Date.now(),this.i=i.length,i.push(this)}return a.prototype.update=function(){return this.s.position.x!==this.p.x||this.s.position.y!==this.p.y?(this.s.position.x+=this.delta(this.p0.x,this.p.x),this.s.position.y+=this.delta(this.p0.y,this.p.y)):this.remove()},a.prototype.remove=function(){return i.splice(this.i-1,1)},a.prototype.delta=function(a,b){return((b-a)/this.t).toFixed()},a}(),z=function(){var a,b,c,d;for(d=[],b=0,c=i.length;c>b;b++)a=i[b],d.push(a.update());return d},c={set:function(a){return t.offset=new PIXI.Point(a.x,a.y)}},f=function(){function a(){return this.s=new PIXI.Sprite(PIXI.Texture.fromImage("assets/textures/player.png")),this.s.position.x=0,this.s.position.y=0,this.s.width=128,this.s.height=256,this.s.speedX=10*Math.random(),this.s.speedY=10*Math.random()-5,m.addChild(this.s),this.enableControl(this),this}return a.prototype.enableControl=function(a){return window.onkeydown=function(c){switch(c.keyCode){case 65:case 37:if(a.s.speedX>-10)return a.s.speedX-=Math.randomInt(1,2.5);break;case 68:case 39:if(a.s.speedX<10)return a.s.speedX+=Math.randomInt(1,2.5);break;case 32:if(a.beds>0)return new b(a.s.position.x),a.beds-=1}}},a.prototype.checkIsNeedBeds=function(){var a;return a=g.mileage/100,(a-a%d.whenGiveBeds)/d.whenGiveBeds>this.timesBedsBeenGiven?(this.timesBedsBeenGiven+=1,this.beds+=d.bedsCountThatGives):void 0},a.prototype.timesBedsBeenGiven=0,a.prototype.beds=10,a}(),l=[],b=function(){function a(a){var b;Math.random()>.2?(b="assets/textures/bed.png",this.lifes=2):(b="assets/textures/broken_bed.png",this.lifes=1),this.s=new PIXI.Sprite(PIXI.Texture.fromImage(b)),this.s.width=256,this.s.height=128,this.s.position.x=a,this.s.position.y=window.h-r.s.height-this.s.height,l.push(this),m.addChild(this.s)}return a}(),q=function(a,b){var c,d,e;for(d=0,e=l.length;e>d;d++)if(c=l[d],a+b>=c.s.position.x&&a+b<=c.s.position.x+c.s.width||a>=c.s.position.x&&a<=c.s.position.x+c.s.width){switch(c.lifes-=1,c.lifes){case 1:c.s.texture=PIXI.Texture.fromImage("assets/textures/broken_bed.png");break;case 0:m.removeChild(c.s),l.splice(l.indexOf(c),1)}return c}},e=function(){function a(a){return this.s=new PIXI.TilingSprite(PIXI.Texture.fromImage("http://i.imgur.com/5rVPkJJ.png"),window.w,64),this.s.position={x:a,y:window.h-this.s.height},this.s.tilePosition={x:0,y:0},w.addChild(this.s),this}return a.prototype.updatePosition=function(a){return this.s.position.x=a-window.w/2,this.s.tilePosition.x=-a/2},a}(),g={jumpedBeds:0,mileage:0,bestMileage:0,update:function(){return o("beds").innerText="BEDS: "+s.beds,o("mileage").innerText="MILEAGE: "+(g.mileage/100).toFixed()+"m",o("bestMileage").innerText="BEST: "+(g.bestMileage/100).toFixed()+"m"}},document.body.addEventListener("touchmove",function(a){return a.preventDefault()},!1),window.onresize=u,x=function(){return w=new PIXI.Stage(16777215),t=new PIXI.WebGLRenderer(window.w,window.h),t.view.style.zIndex=1,document.body.appendChild(t.view),k=new PIXI.TilingSprite(PIXI.Texture.fromImage("https://pp.vk.me/c621626/v621626450/c761/xvMcA2K8uJo.jpg")),k.position={x:0,y:0},k.width=window.w,k.height=window.h,k.alpha=.1,w.addChild(k),m=new PIXI.DisplayObjectContainer,w.addChild(m),l=[],s=new f(window.w/2,window.h/2),r=new e(s.s.position.x-window.w/2),new b(0),j=0,requestAnimFrame(h)},v=function(){return new b(0),s.beds=d.bedsCountThatGives,s.s.speedX=10*Math.random(),s.s.position.x=0,g.jumpedBeds=0,g.mileage=0},y=function(){return s.s.position.x+=s.s.speedX,s.s.position.y+=s.s.speedY,s.s.speedY+=d.gravity,j+=d.gravity,s.s.speedX-=d.windSpeed,s.s.position.y>window.h-s.s.height-r.s.height&&(q(s.s.position.x,s.s.width)?g.jumpedBeds+=1:v(),s.s.speedY=Math.abs(s.s.speedY)-j/50,j=0,s.s.speedY*=-1,s.s.position.y=window.h-s.s.height-r.s.height),c.set({x:window.w/2-s.s.position.x,y:t.offset.y}),r.updatePosition(s.s.position.x),k.position.x=s.s.position.x-window.w/2,k.tilePosition.x=s.s.position.x/10,s.s.position.x>g.mileage&&(g.mileage=s.s.position.x),g.mileage>g.bestMileage&&(g.bestMileage=g.mileage),s.checkIsNeedBeds(),g.update()},h=function(){return requestAnimFrame(h),y(),z(),t.render(w)},x(),u()}).call(this);