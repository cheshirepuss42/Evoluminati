package Creeps.Traits 
{
	import Auras.ImmunityAura;
	import Creeps.Creep;
	public class AuraOfImmunity extends TraitAura
	{
		
		public function AuraOfImmunity() 
		{
			
		}
		override public function applyTo(crp:Creep):void 
		{
			crp.aura = new ImmunityAura();
			
			//crp.aura.init(crp.x, crp.y, 0.5);
			
			super.applyTo(crp);
			//crp.aura = new FireRing();
			
		}		
	}

}