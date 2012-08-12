package Points 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class Pickup extends GroundPoint
	{		
		private var timeLeft:Number;
		public var reward:int;
		public var pickedUp:Boolean;
		
		public function Pickup() 
		{			
			type = "pickup";			

		
		}
		
		public function init(g:GameInfo,gfx:String,reward:int,timer:Number,random:Boolean=false,grX:int=0,grY:int=0):void
		{
			super._init(g,gfx, grX, grY);
			pickedUp = false;
			timeLeft = timer;
			this.reward = reward;			
			if (random)
			{
				x = G.offsetX + (int(Math.random()*(G.gridWidth-4))+2) * G.size;
				y = G.offsetY + (int(Math.random()*(G.gridHeight-4))+2) * G.size;					
			}
		}
		override public function update():void
		{
			timeLeft-=FP.elapsed;
			if (timeLeft <= 0)
				world.remove(this);			
			if (collide("player",x,y))
			{				
				pickedUp = true;
			}
		}
		
	}

}