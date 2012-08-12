package Weapons 
{
	/**
	 * ...
	 * @author 
	 */
	import net.flashpunk.FP
	public class ChargableWeapon extends Weapon
	{
		public var isCharging:Boolean;
		private var stoppedCharging:Boolean;
		public var necessaryChargeTime:Number;
		private var chargeSoFar:Number=0;
		public function ChargableWeapon(g:GameInfo,gfx:String, rng:Number = 1,holder:String="player" )
		{
			super(g,gfx, rng, holder);
			isCharging = false;
		}

		public function startCharging():void
		{
			if (!isCharging)
			{
				chargeSoFar = 0;
				//trace("ssdfsdfsd");
				isCharging = true;				
				stoppedCharging = false;				
			}

		}
		public function stopCharging():void
		{
			stoppedCharging = true;
			isCharging = false;
			//
		}
		public function onFullCharge():void
		{
			
		}
		override public function update():void 
		{
			super.update();
			//trace(chargeSoFar);
			if (isCharging)
			{
				//trace("charging",chargeSoFar);
				chargeSoFar += FP.elapsed;
			}
			if (stoppedCharging)
			{
				stoppedCharging= false;
				if (chargeSoFar >= necessaryChargeTime)
				{
					onFullCharge();
					chargeSoFar = 0;
				}
				
			}
		}
	}

}