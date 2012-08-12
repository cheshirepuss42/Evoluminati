package Creeps.Traits 
{
	/**
	 * ...
	 * @author 
	 */
	public class SpawnsCreep extends TraitSpawn
	{
		
		public function SpawnsCreep(g:GameInfo,creep:Class) 
		{
			super(g,creep);
			modifier = 2.5;
		}
		
	}

}