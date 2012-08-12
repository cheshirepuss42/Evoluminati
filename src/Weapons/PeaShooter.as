package Weapons 
{
	import Effects.DamageEffect;
	public class PeaShooter extends Weapon
	{		
		public function PeaShooter(g:GameInfo,holder:String="player",range:Number=1) 
		{
			name = "PeaShooter";
			super(g,"PeaShooter",range,holder);
			infoText="Standard gun";
			properName = "Pea Shooter";
			fx.push(new DamageEffect(holder,40, 0));
		}
	}
}