package Structures 
{
	import Creeps.Creep;
	import flash.geom.Point;
	import Worlds.Level;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import Weapons.*;


	public class Tower extends Structure
	{
		public var range:Number;
		public var weapon:Weapon;
		
		public function Tower(g:GameInfo,gfx:String) 
		{			
			super(g,gfx);
			setSize(2, 2);	
			//range = G.defaultRange;
		}
		public function setWeapon(w:Weapon):void
		{
			weapon = w;
			weapon.cooldown = 1;
			weapon.followsMouse = false;
			weapon.weaponHolder = "tower";
			range = weapon.range;			

			weapon.collidesWithStructures = false;
		}
		override public function setPos(px:int, py:int):void
		{
			super.setPos(px, py);			
			weapon.x = centerX;
			weapon.y = centerY;
		}
		override public function added():void
		{
			world.add(weapon);
		}
		override public function removed():void
		{
			world.remove(weapon);
		}
		override public function update():void
		{
			if (Level(world).gameIsPaused)
			return;
			super.update();		
			if (!weapon.isOnCooldown)
			{
				var allCreeps:Array = [];
				world.getType("creep", allCreeps);	
				var amcreeps:int = allCreeps.length;
				for (var i:int = 0; i < amcreeps; i++) 
				{
					if (distanceFrom(allCreeps[i]) < range)
					{	
						weapon.fireAt(allCreeps[i].centerX, allCreeps[i].centerY);
						break;
					}
				}
			}			
		}		
	}
}