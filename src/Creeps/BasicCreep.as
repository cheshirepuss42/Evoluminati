package Creeps 
{
	import Creeps.Traits.*;

	public class BasicCreep extends Creep
	{
		
		public function init(g:GameInfo,startX:int, startY:int):void 
		{
			super._init(g, startX, startY, "BasicCreep");
			traits.push(new SpeedOnFirstDamage());

			
		}		
	}

}