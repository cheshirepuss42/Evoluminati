package Shooter 
{
	import Auras.*;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.*; 
	import Weapons.*;
	import Pickups.*;
	import UI.*;
	import Worlds.Level;
	import Structures.Structure;
	import Projectiles.Projectile;
	import UI.HealthBar;

	public class Player extends Entity
	{
		private var accelarationSpeed:Number = 35;
		public var chargeBar:HealthBar;
		private var friction:Number = 0.1;
		private var speedX:Number = 0;
		private var speedY:Number = 0;
		private var originalX:int;
		private var originalY:int;
		private var body:Image;
		private var gridX:int;
		private var gridY:int;
		public var currentWeapon:Weapon;
		private var currentAura:Aura;
		private var rechargeSpeed:Number;
		private var rechargedSoFar:Number;	
		public var energy:Number;
		private var maxEnergy:Number;
		public var upgradePoints:int;
		private var ambientRechargePS:Number;
		public var GI:GameInfo;
		public function Player(g:GameInfo,_x:int,_y:int) 
		{
			GI = g;
			gridX = _x;
			gridY = _y;
			x = G.offsetX + (G.size * gridX);
			y = G.offsetY + (G.size * gridY);			
			body = new Image(GI.gfx["RobotBody"]);
			body.centerOO();
			body.x = G.size / 2;
			body.y = G.size / 2;									
			addGraphic(body);
			//set hitbox small to let go through paths easily
			setHitbox(G.size * 0.5, G.size * 0.5 , -G.size / 4, -G.size / 4);
			type = "player";
			layer = G.layerPlayer;	
			currentWeapon = new NoWeapon(GI);
			currentAura = new FireRing();
			rechargedSoFar = 0;
			rechargeSpeed = 6;
			upgradePoints = 0;
			maxEnergy = 500;
		}
		//
		public function fire():void
		{
			currentWeapon.fireAt(world.mouseX, world.mouseY);
			energy -= currentWeapon.energyCost;			
		}
		override public function added():void
		{
			ambientRechargePS = G.defaultAmbientRecharge * Math.pow(Stats.data.getStat("ambientrecharge").modifier,10);
			chargeBar = new HealthBar(G.size / 6,G.halfSize*1.5 ,0x99ccff);
			chargeBar.graphic.x = G.size+G.halfSize;
			chargeBar.graphic.y = G.halfSize-chargeBar.halfHeight;
			chargeBar.setFilledY(0);
			chargeBar.visible = false;
			world.add(chargeBar);
			
			world.add(currentWeapon);
			if (Stats.data.getStat("damageovertime").ranks > 0)
			{
				currentAura.init(x, y, 0.5 , Stats.data.getStat("damageovertime").modifier);			
				world.add(currentAura);
			}
			
		}		
		public function setWeapon(weapon:Weapon):void
		{			
			world.remove(currentWeapon);
			currentWeapon = weapon;
			world.add(currentWeapon);
		}
		override public function update():void
		{
			//handleInput();
			if (Level(world).gameIsPaused)
			return;
			move();	
			energy += ambientRechargePS * FP.elapsed;
			energy = (energy < 0)?0:energy;
			energy = (energy > maxEnergy)?maxEnergy:energy;
			Level(world).menu.energyStatus.setFilled(energy / maxEnergy, energy);
			
			//chargeBar.visible = currentWeapon.name == "Teleporter";
		}	
		public function handlePickups():void
		{
			var pickup:CreepDrop = collide("creepdrop", x, y) as CreepDrop;
			if (pickup != null)
			{
				if (pickup.dropType == "upgrade")
				{
					pickup.reward+=Stats.data.getStat("upgradepointbonus").ranks;
					upgradePoints += pickup.reward;
					TextSpark(world.create(TextSpark)).setup(centerX, centerY, "+" + String(int(pickup.reward)),0xff8800,30);
				}
				else
				{
					energy += pickup.reward;					
					TextSpark(world.create(TextSpark)).setup(centerX,centerY, "+" + String(int(pickup.reward)),0xccffcc, 20);
				}	
				GI.sfx["pickup_01_new_01"].play();
				world.recycle(pickup);
			}			
		}
		public function handleEnergyRecharge():void
		{
			var notRecharging:Boolean = true;
			for (var i:int = 0; i < GI.currentLevelData.rechargePoints.length; i++) 
			{
				if (energy <= maxEnergy && collideWith(GI.currentLevelData.rechargePoints[i], x, y)!=null)
				{
					if(!GI.sfx["menu_select_01"].playing)
						GI.sfx["menu_select_01"].loop();	
					GI.currentLevelData.rechargePoints[i].flash();
					rechargedSoFar += rechargeSpeed * FP.elapsed;
					energy += rechargeSpeed * FP.elapsed;
					if (rechargedSoFar > 2)
					{
						TextSpark(world.create(TextSpark)).setup(centerX, centerY, "+" + String(2), 0xccffcc, 20);
						rechargedSoFar -= 2;
					}
					notRecharging = false;
				}
				else
				{
					GI.currentLevelData.rechargePoints[i].stopFlash();
				}
			}
			if (notRecharging)
			{
				GI.sfx["menu_select_01"].stop();				
			}
		}
		public function startCharging():void
		{
			chargeBar.visible = true;
			ChargableWeapon(currentWeapon).startCharging();
		}
		public function stopCharging():void
		{
			chargeBar.visible = false;
			ChargableWeapon(currentWeapon).stopCharging();
		}
		public function set aura(a:Aura):void
		{
			
			currentAura = a;
		}
		public function get aura():Aura
		{			
			return currentAura;
		}
		public function handleInput():void
		{
			//adjust speed based on keyboard input
			if (Input.check(Key.A))
			{
				speedX -= accelarationSpeed;
			}
			if (Input.check(Key.D))
			{
				speedX += accelarationSpeed;
			}
			if (Input.check(Key.W))
			{
				speedY -= accelarationSpeed;
			}
			if (Input.check(Key.S))
			{
				speedY += accelarationSpeed;
			}			
		}
		private function move():void
		{

			//store original position
			originalX = x;
			originalY = y;			
			//set angle if speed is not zero
			if (!(speedX == 0 && speedY == 0))			
				body.angle = -90 + FP.angle(0, 0, speedX, speedY);		
				
			//apply friction and make sure that it slows down and comes to a halt
			speedX = (speedX < 0.01 && speedX >-0.01)?0:speedX * (1-friction);			
			speedY = (speedY < 0.01 && speedY >-0.01)?0:speedY * (1-friction);
		
			//move the player by amount of speed
			var prevx:int = x;
			var prevy:int = y;
			moveBy(speedX * FP.elapsed, speedY * FP.elapsed, "structure");
			if (x == prevx && y == prevy)
			{
				
				speedX = -0.8*speedX;
				speedY = -0.8 * speedY;
				
				moveBy(speedX * FP.elapsed, speedY * FP.elapsed, "structure");
			}
			currentWeapon.x = x + G.halfSize;			
			currentWeapon.y = y + G.halfSize;
			chargeBar.x = x;
			chargeBar.y = y;
			aura.x = x - aura.range + G.halfSize;			
			aura.y = y - aura.range + G.halfSize;				
		}
		private function handleCollision():void
		{
			var st:Structure = collide("structure", x, y) as Structure;

			if (st != null)			
			{
				moveBy(x, y,"structure");
				speedX = speedY = 0;
			}
		}
		private function handleCollision2():void
		{
			//snel om hoeken gaan, door als je bv w en d inhoudt
			
			
			
			var bounceForce:Number = 0.1;
			//find the structure player collides with
			var st:Structure = collide("structure", x, y) as Structure;
			//if there is a structure player collides with
			if (st != null)			
			{
				//move back out of collision
				x=originalX;
				y=originalY;
				//try a bounce direction
				speedX *= -bounceForce;
				//set location after bouncing
				x += speedX * FP.elapsed;				
				y += speedY * FP.elapsed;				
				//if new player location collides				
				if ((st!=null && collideWith(st, x, y) != null))				
				{
					//reverse previous bounce direction
					speedX *= -bounceForce;
					//apply other bounce direction
					speedY *= -bounceForce;                        
				}
				//move back out of bounce
				x = originalX;
				y = originalY;				
			}				
		}
	}
}