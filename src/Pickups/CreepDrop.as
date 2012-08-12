package Pickups 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	public class CreepDrop extends Entity
	{
		//public static var stayTime:Number=5;
		public var reward:int;
		public var timer:Number;
		public var dropType:String;
		public var GI:GameInfo;
		public function CreepDrop() 
		{
			type = "creepdrop";
			
			setHitbox(15, 15, -G.size / 3, -G.size / 3);
			layer = G.layerPickups;
		}
		public function setup(g:GameInfo,lx:int,ly:int,rew:int,dropType:String="upgrade"):void
		{
			GI = g;
			this.dropType = dropType;
			x = lx;
			y = ly;
			reward = (dropType== "upgrade")?rew:10;
			timer = G.creepDropStayTime;
			graphic = new Image(GI.gfx["CreepDrop"]);
			//reward *= A.currentLevelData.stat("upgradepointbonus").modifier;
			Image(graphic).color = (dropType == "upgrade")?0x0088ff:0x00ff00;			
			//graphic = new Image(A.gfx["pickup_01" + String(int(FP.random * 3) + 1)]);
			
		}
		override public function update():void
		{
			//trace(x, y, timer);
			super.update();
			timer -= FP.elapsed;
			if (timer <= 0)
				world.recycle(this);
		}
	}

}