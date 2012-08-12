package Creeps.Traits 
{
	import Creeps.Creep;
	public class ImmuneToTraps extends TraitImmune
	{
		
		public function ImmuneToTraps() 
		{
			
		}
		override public function applyTo(crp:Creep):void 
		{
			//trace(crp.health, modifier);
			crp.addImmunity("trap");
			
		}			
	}

}