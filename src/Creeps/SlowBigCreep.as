package Creeps 
{
	import Creeps.Traits.*;

	public class SlowBigCreep extends Creep
	{

		public function init(g:GameInfo,startX:int, startY:int):void 
		{
			super._init(g,startX, startY, "creep_02");
			traits.push(new Tough());
			traits.push(new Slow());
			
		}		
	}

}