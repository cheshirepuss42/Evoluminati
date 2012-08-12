package Auras 
{
	/**
	 * ...
	 * @author 
	 */
	public class SpeedAura 
	{
		
		public function SpeedAura() 
		{
			
		}
		override public function init(px:int, py:int, range:Number,modifier:Number=1):void 
		{
			color = 0x0033ff;
			 super.init(px, py, range,modifier);
			 effect = new SlowEffect("aura", 1.5);
			 //trace(effect.effectType);
			 //add image
			 //add effect
			 
		}		
	}

}