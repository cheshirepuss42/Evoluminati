package Creeps.Traits 
{
	import Creeps.Creep;
	public class TraitOnFirstHit extends Trait
	{
		
		public function TraitOnFirstHit() 
		{
			timing = "onfirsthit";
		}
		override public function applyTo(crp:Creep):void 
		{
			crp.defaultSpeed *= modifier;
			
		}			
	}

}