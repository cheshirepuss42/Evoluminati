package Weapons 
{
	import Effects.DamageEffect;
	public class PoisonGun extends Weapon
	{
		
		public function PoisonGun(g:GameInfo,holder:String="player",range:Number=1) 
		{
			name = "PoisonGun";
			super(g,"Laser",range,holder);
			infoText="Poison gun";
			properName = "Poison Gun";
			fx.push(new DamageEffect(holder, 15, 1));			
			fx.push(new DamageEffect(holder,10, 0));
		}
		
	}

}