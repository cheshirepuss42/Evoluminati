package Creeps 
{
	import Creeps.Traits.*;

	public class FastBigCreep extends Creep
	{
		
		public function init(g:GameInfo,startX:int, startY:int):void 
		{
			super._init(g,startX, startY, "FastBigCreep");
			traits.push(new Tough());
			traits.push(new Speedy());
			
		}			
	}

}