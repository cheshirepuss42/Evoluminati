package Effects 
{
	import Creeps.Creep;
	public class ImmuneToSlowEffect extends Effect
	{
		
		public function ImmuneToSlowEffect(sourceType:String,dur:Number = 0.1) 
		{
			type = "immunity";
			timer = duration = dur;
			this.effectSource = sourceType;
		}
		override public function handleCreep(crp:Creep):void
		{
			if (over)
				crp.removeImmunity("slow");
			else
				crp.addImmunity("slow");

		}		
	}

}