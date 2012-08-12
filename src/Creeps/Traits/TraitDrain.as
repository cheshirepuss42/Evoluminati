package Creeps.Traits 
{
	import Creeps.Creep;
	public class TraitDrain extends Trait
	{
		
		public function TraitDrain() 
		{
			
			timing = "onstart";
		}
		override public function applyTo(crp:Creep):void 
		{
			crp.drainAmount *= modifier;
			
		}
		
	}

}