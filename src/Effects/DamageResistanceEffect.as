package Effects 
{
	import Creeps.Creep;
	import net.flashpunk.FP;
	public class DamageResistanceEffect extends Effect
	{
		private var DRmodifier:Number;
		public function DamageResistanceEffect(mod:Number) 
		{
			DRmodifier = mod;
		}
		override public function handleCreep(crp:Creep):void 
		{
			crp.damageResistance = (!over)?DRmodifier:0;		
		}		
	}

}