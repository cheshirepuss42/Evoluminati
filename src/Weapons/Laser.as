package Weapons 
{
	import Projectiles.LaserProjectile;

	public class Laser extends Weapon
	{
		
		public function Laser(g:GameInfo) 
		{
			super(g,"Laser");
			infoText = "Motherfucking laser";
			properName = "The Zappa";
			cooldown = 0.8;
		}

		override public function fireAt(tX:int, tY:int):void
		{
			setTarget(tX, tY);
			isOnCooldown = true;
			var pr:LaserProjectile = world.create(LaserProjectile) as LaserProjectile;
			pr.init(centerX, centerY, tX, tY, projectileSpeed, range, 100, damageType, 1);			
			//pr.blockedByStructure = true;
			GI.sfx["player_shoot"].play();
			//pr.range = range;		
			//trace("shooting laser at", tX, tY);
		}		
	}

}