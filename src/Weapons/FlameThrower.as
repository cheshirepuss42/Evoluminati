package Weapons 
{
 	import Effects.DamageEffect;
	import Projectiles.*;	
	import net.flashpunk.graphics.Image;
	public class FlameThrower extends Weapon
	{
		
		public function FlameThrower(g:GameInfo,holder:String="player",range:Number=1) 
		{
			name = "FlameThrower";
			super(g,"OrbGun",range,holder);
			infoText="Shoots flames";
			properName = "Flame Thrower";
			fx.push(new DamageEffect(holder, 2, 0));
			cooldown = 0.05;
			//projectileColor = 0xff0000;
			
		}
		override public function added():void 
		{
			super.added();
			energyCost = 5 - Stats.data.getStat("flamer").ranks;			
			trace(energyCost);
		}
		override public function fireAt(tX:int, tY:int):void
		{
			setTarget(tX, tY);			
			var pr:Flame = world.create(Flame) as Flame;					
			pr.init(GI,centerX, centerY, tX, tY, projectileSpeed / 2, range, energyCost, fx);	
			Image(pr.graphic).angle = Image(graphic).angle;
			pr.blockedByStructure = true;
			//pr.color = projectileColor;
			GI.sfx["player_orb"].play();
			isOnCooldown = true;
		}		
	}

}