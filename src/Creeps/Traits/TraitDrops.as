package Creeps.Traits 
{
	import Creeps.Creep;
	public class TraitDrops extends Trait
	{
		
		public function TraitDrops() 
		{
			timing = "ondeath";
		}
		override public function applyTo(crp:Creep):void 
		{
			crp.reward *= modifier;
			
		}		
	}

}