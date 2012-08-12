package Projectiles 
{
	import Effects.*;
	import net.flashpunk.graphics.Image;
	public class Flame extends Orb
	{
		
		public function Flame() 
		{
			
		}
		override public function init(g:GameInfo,sX:int, sY:int, tX:int, tY:int, speed:Number, range:int, energyCost:int = 1,fx:Vector.<Effect>=null):void		
		{
			//setHitbox(24, 24);
			super.init(g,sX, sY, tX, tY, speed, range, energyCost,fx);
			img = new Image(GI.gfx["Flame"]);
			img.centerOrigin();			
			graphic = img;

		}		
	}

}