package Creeps.Traits 
{
	import Auras.FireRing;
	import Creeps.Creep;
	public class TraitAura extends Trait
	{
		
		public function TraitAura() 
		{
			timing = "onstart";
		}
		override public function applyTo(crp:Creep):void 
		{
			//crp.aura = new FireRing();
			crp.aura.init(crp.x, crp.y, 0.5);
			//crp.aura = new FireRing();
			
		}				
	}

}