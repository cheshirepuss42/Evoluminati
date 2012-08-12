package Creeps.Traits 
{
	import Creeps.Creep;
	public class ImmuneToSlow extends TraitImmune
	{
		
		public function ImmuneToSlow() 
		{
			
		}
		override public function applyTo(crp:Creep):void 
		{
			//trace(crp.health, modifier);
			crp.addImmunity("slow");
			
		}		
		
	}

}