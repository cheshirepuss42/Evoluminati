package Points 
{
	import Effects.DamageEffect;
	import Effects.Effect;
	import Effects.SlowEffect;

	public class Trap extends GroundPoint 
	{
		public var trapType:String;
		public var effect:Effect;
		public function Trap() 
		{			
			super();
			type = "trap";
		}
		public function setupTrap(g:GameInfo,grX:int, grY:int, type:String):GroundPoint 
		{	
			
			this.trapType = type;		
			super._init(g,(type=="fire")?"floortrap_02":"floortrap_01", grX, grY);
				
			if (trapType == "fire")
			{
				effect = new DamageEffect("trap",0.2);
			}
			else
			{
				effect = new SlowEffect("trap",0.1);
			}
			
			return this;
		}

		
	}

}