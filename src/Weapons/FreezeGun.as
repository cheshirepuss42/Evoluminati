package Weapons 
{
	import Effects.Effect;
	import Effects.SlowEffect;
	public class FreezeGun extends Weapon
	{		
		public function FreezeGun(g:GameInfo,holder:String="player",range:Number=1) 
		{
			super(g,"FreezeGun", range, holder);
			name = "FreezeGun";
			infoText = "Freezing gun slows creeps";
			properName = "Freeze Gun";	
			damageType = "cold";
			projectileColor = 0x5555ff;
			fx.push(new SlowEffect(holder,2.5));
		}

		
	}

}