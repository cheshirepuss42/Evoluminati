package Projectiles 
{
	import Creeps.Creep;
	import Effects.DamageEffect;
	import Effects.Effect;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import Points.Pickup;
	import net.flashpunk.FP;

	
	public class Projectile extends Entity
	{
		//the speed of the projectile
		public var speed:Number;
		//the direction it goes
		public var direction:Point;		
		//range the projectile travels
		public var range:int;		
		public var blockedByStructure:Boolean;
		public var blockedByCreep:Boolean;		
		public var shouldBeRemoved:Boolean = false;		
		public var sourceX:int;
		public var sourceY:int;
		public var targetX:int;
		public var targetY:int;		
		public var energyCost:int;	
		public var effects:Vector.<Effect>;
		public var img:Image;
		public var GI:GameInfo;
		
		public function Projectile()
		{
			layer = G.layerProjectiles;		
			type = "projectile";
		}
		
		public function _init(g:GameInfo,sX:int, sY:int, tX:int, tY:int, speed:Number,range:int,energyCost:int=1,fx:Vector.<Effect>=null):void
		{
			GI = g;
			collidable = true;			
			effects = new Vector.<Effect>();
			var fxl:int = fx.length;
			for (var i:int = 0; i < fxl; i++) 
			{
				effects.push(fx[i].clone());
			}			
			this.speed = speed;
			this.range = range;					
			this.x = sourceX = sX;
			this.y = sourceY = sY;	
			targetX = tX;
			targetY = tY;
			direction = new Point(tX - sX, tY - sY);
			direction.normalize(1);				
			x += direction.x * (G.size / 1.8);
			y += direction.y * (G.size / 1.8);	
			blockedByStructure = false;
			blockedByCreep = true;
			shouldBeRemoved = false;
			this.energyCost = energyCost;

		}
		public function set color(c:uint):void
		{
			img.color = c;
		}
		public function move():void
		{
			if (range < this.distanceToPoint(sourceX, sourceY))
			{
				world.recycle(this);
			}
			else
			{					
				x += direction.x * speed * FP.elapsed;			
				y += direction.y * speed * FP.elapsed;				
			}			
			
		}
	}
}