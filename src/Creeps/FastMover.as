package Creeps 
{
	//import Creeps.Traits.SpawnsTougher;
	import Creeps.Traits.Speedy;
	public class FastMover extends Creep
	{
		

		public function init(g:GameInfo,startX:int, startY:int):void 
		{
			super._init(g,startX, startY,"FastMover");
			traits.push(new Speedy());
			
		}
		
	}

}