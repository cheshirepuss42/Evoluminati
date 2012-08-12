package Creeps.Traits 
{
	import Creeps.Creep;

	public class TraitSpeed extends Trait
	{
		
		public function TraitSpeed() 
		{
			timing = "onstart";
		}
		override public function applyTo(crp:Creep):void 
		{
			crp.defaultSpeed *= modifier;
			
		}		
	}

}