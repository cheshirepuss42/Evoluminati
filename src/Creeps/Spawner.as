package Creeps 
{
	import Creeps.Traits.*;
	public class Spawner extends Creep
	{
		public function init(g:GameInfo,startX:int, startY:int,creepType:Class):void 
		{
			super._init(g, startX, startY, "Spawner");
			traits.push(new SpawnsCreep(GI, creepType));
			traits.push(new Weak());
			
			
		}	
		
	}

}