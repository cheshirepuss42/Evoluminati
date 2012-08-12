package Creeps.Traits 
{
	import Auras.SlowAura;
	import Creeps.Creep;
	/**
	 * ...
	 * @author 
	 */
	public class AuraOfSlow extends TraitAura
	{
		
		public function AuraOfSlow() 
		{
			
		}
		override public function applyTo(crp:Creep):void 
		{
			crp.aura = new SlowAura();
			
			//crp.aura.init(crp.x, crp.y, 0.5);
			
			super.applyTo(crp);
			//crp.aura = new FireRing();
			
		}		
	}

}