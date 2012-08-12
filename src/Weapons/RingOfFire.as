package Weapons 
{
	import Effects.DamageEffect;

	public class RingOfFire extends Weapon
	{
		
		public function RingOfFire(g:GameInfo,holder:String="player",range:Number=1) 
		{
			super(g,"gun_04",range,holder);
			infoText = "Ring Of Fire burns surrounding creeps";
			properName = "Fire Ring";	
			damageType = "normal";
			fx.push(new DamageEffect(holder,0.2));			
		}
		override public function fireAt(tX:int, tY:int):void
		{
			//make new aura
			
			//setTarget(tX, tY);			
			//var pr:Bullet = world.create(Bullet) as Bullet;		
			//
			//pr.init(centerX, centerY, tX, tY, projectileSpeed, range, 1, fx);
			//pr.projSource = weaponHolder;
			//if (collidesWithStructures)
				//pr.blockedByStructure = true;
			//A.sfx["player_shoot"].play();
			//reset timers
			//isOnCooldown = true;
		}		
	}

}