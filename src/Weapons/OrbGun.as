package Weapons 
{
	import Effects.DamageEffect;
	import Projectiles.Orb;
	public class OrbGun extends Weapon
	{
		
		public function OrbGun(g:GameInfo,holder:String="player",range:Number=2) 
		{
			name = "OrbGun";
			super(g,"OrbGun",range,holder);
			infoText="Standard orb shooter";
			properName = "Orb Gun";
			fx.push(new DamageEffect(holder, 2, 0));
			cooldown = 1.5;
			projectileColor = 0x00ff00;
			energyCost = 15;
		}
		override public function fireAt(tX:int, tY:int):void
		{
			setTarget(tX, tY);			
			var pr:Orb = world.create(Orb) as Orb;		
			
			pr.init(GI,centerX, centerY, tX, tY, projectileSpeed / 5, range, energyCost, fx);	
			pr.color = projectileColor;
			//if (collidesWithStructures)
				//pr.blockedByStructure = true;
			GI.sfx["player_orb"].play();
			//reset timers
			isOnCooldown = true;
		}		
	}

}