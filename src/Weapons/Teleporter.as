package Weapons 
{
	import Worlds.Level;
	
	public class Teleporter extends ChargableWeapon
	{
		public function Teleporter(g:GameInfo) 
		{
			super(g,"Teleporter");
			infoText = "Teleports you to where you click";
			properName = "Teleporter";
			name="Teleporter";			
			necessaryChargeTime = 1;
			snapsToGrid = true;
		}

		override public function onFullCharge():void 
		{			
			super.onFullCharge();
			Level(world).player.x = targetX-G.halfSize;
			Level(world).player.y = targetY - G.halfSize;		
		}

		
	}

}