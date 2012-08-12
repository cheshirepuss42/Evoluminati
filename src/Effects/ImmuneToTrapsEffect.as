package Effects 
{
	import Creeps.Creep;
	import net.flashpunk.graphics.Image;
	public class ImmuneToTrapsEffect extends Effect
	{
		
		public function ImmuneToTrapsEffect(sourceType:String,dur:Number = 0.1) 
		{
			//trace("maklng immunity effect");
			type = "immunity";
			timer = duration = dur;
			this.effectSource = sourceType;
		}

		override public function handleCreep(crp:Creep):void
		{
			//trace("handling immunity effect");
			crp.addImmunity("trap");
			if (!over)
			{
				Image(crp.graphic).color = 0x00ff00;
				Image(crp.graphic).tinting = 0.3;	
			}
			else 
			{
				Image(crp.graphic).color = 0xffffff;
				Image(crp.graphic).tinting = 0;					
			}			
			if (over)
				crp.removeImmunity("trap");

		}	
		override public function clone():Effect
		{
			return new ImmuneToTrapsEffect(effectSource,duration);
		}		
	}

}