package Auras 
{
import Effects.DamageEffect;
	public class FireRing extends Aura
	{
		
		public function FireRing() 
		{
			
		}
		override public function init(px:int, py:int, range:Number,modifier:Number=1):void 
		{
			color = 0xff0000;
			 super.init(px, py, range,modifier);
			 effect = new DamageEffect("aura", 0.5*mod);
			 //add image
			 //add effect
			 
		}
		override public function update():void 
		{
			super.update();
			//if it hits a creep, transfer effect
		}
	}

}