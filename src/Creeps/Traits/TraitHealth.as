package Creeps.Traits 
{
	import Creeps.Creep;
	public class TraitHealth extends Trait
	{
		
		public function TraitHealth() 
		{
			timing = "onstart";
		}
		override public function applyTo(crp:Creep):void 
		{
			//trace(crp.health, modifier);
			crp.health *= modifier;
			crp.maxHealth *= modifier;
			
		}			
	}

}