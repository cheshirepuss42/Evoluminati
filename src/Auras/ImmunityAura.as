package Auras 
{
	import Effects.ImmuneToTrapsEffect;

	public class ImmunityAura extends Aura
	{
		
		public function ImmunityAura() 
		{
			
		}
		override public function init(px:int, py:int, range:Number,modifier:Number=1):void 
		{
			color = 0x0033ff;
			 super.init(px, py, range,modifier);
			 effect = new ImmuneToTrapsEffect("aura", 0.5);
			 //trace(effect.effectType);
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