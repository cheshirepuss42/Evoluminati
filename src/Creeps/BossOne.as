package Creeps 
{
	import Creeps.Traits.*;

	public class BossOne extends Creep
	{
		public function init(g:GameInfo,startX:int, startY:int):void 
		{
			super._init(g,startX, startY, "BossOne");

			traits.push(new BossHealth());
			traits.push(new Slow());
			traits.push(new Slow());
			traits.push(new AuraOfImmunity());
			traits.push(new SpeedOnFirstDamage());
			
		}		
	}

}