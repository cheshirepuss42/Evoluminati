package Creeps.Traits 
{
	import Creeps.*;
	public class TraitSpawn extends Trait
	{
		public var GI:GameInfo;
		public var creepClass:Class;
		public function TraitSpawn(g:GameInfo,creep:Class) 
		{
			GI = g;
			timing = "ondeath";
			creepClass = creep;
		}
		override public function applyTo(crp:Creep):void 
		{
			creepClass(crp.world.create(creepClass)).init(GI,crp.x, crp.y);
			
		}			
	}

}