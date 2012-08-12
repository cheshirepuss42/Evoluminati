package Creeps 
{
	import Creeps.Traits.Tough;

	public class BigCreep extends Creep
	{
		
		public function init(g:GameInfo,startX:int, startY:int):void 
		{
			super._init(g,startX, startY,"BigCreep");
			traits.push(new Tough());
			
		}		
	}

}