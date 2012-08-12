package Effects 
{
	import Creeps.Creep;
	import net.flashpunk.graphics.Image;
	public class SlowEffect extends Effect
	{
		private var speed:Number;
		public function SlowEffect(sourceType:String,dur:Number = 0.1, speed:Number = 0.5) 
		{
			this.speed = speed;
			this.effectSource = sourceType;
			timer=duration = dur;
			type = "slow";
			
		}
		override public function handleCreep(crp:Creep):void
		{
			//trace("applying slow",over,duration);
			if (!crp.isImmuneTo("slow"))
			{
				crp.speedModification = (over)?1:speed/((Stats.data.getStat("slow").modifier*2)-1);				
				if (!over)
				{
					Image(crp.graphic).color = 0x0000ff;
					Image(crp.graphic).tinting = 0.4;	
				}
				else 
				{
					Image(crp.graphic).color = 0xffffff;
					Image(crp.graphic).tinting = 0;					
				}
			}
			//return super.applyToCreep(crp);
		}	
		override public function clone():Effect
		{
			return new SlowEffect(effectSource,duration,speed);
		}
	}

}