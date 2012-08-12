package Projectiles 
{
	import net.flashpunk.graphics.Image;
	import Effects.*;
	import Worlds.Level;
	
	public class Bullet extends Projectile
	{
		
		public function Bullet() 
		{
			super();
		}
		public function init(g:GameInfo,sX:int, sY:int, tX:int, tY:int, speed:Number, range:int, energyCost:int = 1,fx:Vector.<Effect>=null):void		
		{
			super._init(g,sX, sY, tX, tY, speed, range, energyCost,fx);
			img=new Image(GI.gfx["Bullet"]);
			img.tinting = 0.8;
			img.centerOrigin();
			graphic = img;
			
			setHitbox(4, 4);			
		}	
		override public function update():void
		{
			if (Level(world).gameIsPaused)
			return;

			//if collides with structure
			if (blockedByStructure && collide("structure", x, y) != null)
			{
				world.recycle(this);
			}

			if (range < this.distanceToPoint(sourceX, sourceY))
			{
				world.recycle(this);
			}
			else
			{					
				move();
			}
		}	
		
	}

}