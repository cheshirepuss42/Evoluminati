package Auras 
{
	import Effects.SlowEffect;

	public class SlowAura extends Aura
	{
		
		public function SlowAura() 
		{
			
		}
		override public function init(px:int, py:int, range:Number,modifier:Number=1):void 
		{
			color = 0x0033ff;
			super.init(px, py, range,modifier);
			effect = new SlowEffect("aura", 0.5);		 
		}
	}

}