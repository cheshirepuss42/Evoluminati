package Weapons 
{
	import Effects.DamageEffect;
	import Effects.Effect;
	import UI.RangeView;
	import Utils.UpgradeEntity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import Projectiles.*;
	
	public class Weapon extends UpgradeEntity
	{
		
		public var cursorGfx:String;
		public var range:Number;
		public var cooldown:Number;
		public var cooldownTimer:Number;
		public var projectileType:String;
		public var projectileSpeed:Number;
		public var isOnCooldown:Boolean;
		public var rangeView:RangeView;
		public var targetX:int;
		public var targetY:int;
		public var followsMouse:Boolean;
		public var damageType:String;
		public var collidesWithStructures:Boolean;

		public var damage:Number;
		public var fx:Vector.<Effect>;
		public var weaponHolder:String;
		public var projectileColor:uint;
		public function Weapon(g:GameInfo,gfx:String, rng:Number = 1,holder:String="player" ) 		
		{
			super(g);
			fx = new Vector.<Effect>();
			weaponHolder = holder;			
			type = "weapon";
			this.gfx = gfx;
			cursorGfx = "ShootingCursor";
			if (gfx != "")
			{
				graphic = new Image(GI.gfx[gfx]);
				Image(graphic).centerOO();
			}
			followsMouse = true;
			
			cooldown = 0.3;
			cooldownTimer = 0;
			isOnCooldown = false;
			energyCost = 1;
			projectileSpeed = 500;
			damageType = "normal";
			range = G.defaultRange*rng;			
			rangeView = new RangeView(centerX, centerY, range, 0,0.09);
			collidesWithStructures = true;
			//charger = 0;
			//maxCharge = 3;
			damage = 45;
			//isChargable = false;
			layer = G.layerWeapons;
			projectileColor = 0xff0000;
		}
		override public function added():void
		{
			var mod:Number;
			switch (weaponHolder)
			{
				case "player": mod = Stats.data.getStat("player_range").modifier; break;
				case "tower": mod = Stats.data.getStat("tower_range").modifier; break;
			}
			
			range *= mod;
			rangeView.setRange(range);
			world.add(rangeView);
			switch (weaponHolder)
			{
				case "player": break;
				case "tower": rangeView.setColor(0xff0000); rangeView.setAlpha(0.05); break;
			}			
		}
		override public function removed():void
		{
			world.remove(rangeView);
		}
		
		override public function update():void
		{	
			if (followsMouse)
				setTarget(world.mouseX, world.mouseY);
			if (isOnCooldown)
			{
				cooldownTimer += FP.elapsed;
				if (cooldownTimer >= cooldown)
				{
					isOnCooldown = false;
					cooldownTimer = 0;
				}
			}	
			rangeView.setPos(centerX, centerY);
		}
		public function setTarget(tx:int, ty:int):void
		{			
			targetX = tx;
			targetY = ty;
			Image(graphic).angle = -90 + FP.angle(centerX, centerY, targetX, targetY);
		}

		public function fireAt(tX:int, tY:int):void
		{
			setTarget(tX, tY);			
			var pr:Bullet = world.create(Bullet) as Bullet;			
			pr.init(GI,centerX, centerY, tX, tY, projectileSpeed, range, 1, fx);	
			pr.color = projectileColor;
			if (collidesWithStructures)
				pr.blockedByStructure = true;
			GI.sfx["player_shoot"].play();
			//reset timers
			isOnCooldown = true;
		}		

	}


}