package Creeps 
{
	import Auras.Aura;
	import Creeps.Traits.Trait;
	import Effects.DamageEffect;
	import Effects.Effect;
	import flash.filters.ConvolutionFilter;
	import flash.geom.Point;
	import Points.Trap;
	import Projectiles.Projectile;
	//import Grid.DistanceTable;
	import Grid.DM;
	import UI.HealthBar;
	import Worlds.Level;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import UI.TextSpark;
	//this is the basic creep class
	public class Creep extends Entity
	{
		//the points of the path to the goal
		public var path:Vector.<Point>;
		//how quickly to move to the next point
		public var defaultSpeed:Number;
		//how much it can resist incoming damage
		public var damageResistance:Number;
		
		public var maxHealth:int;
		//the amount of hitpoints left
		public var health:Number;
		public var speedModification:Number;
		//public var debuffTimer:int;
		public var reward:int;
		public var reachedGoal:Boolean;
		public var gotDestroyed:Boolean;
		public var healthBar:HealthBar;
		public var pic:String;
		public var effects:Vector.<Effect>;
		public var traits:Vector.<Trait>;
		private var img:Image;
		private var wasDamaged:Boolean;
		private var damageSinceLastSpark:Number;
		public var drainAmount:Number;
		private var immunities:Vector.<String>;
		public var isSpawner:Boolean;
		//public var immuneToSlow:Boolean;
		//public var immuneToTraps:Boolean;
		public var aura:Aura;
		public var GI:GameInfo;
		public function Creep() 
		{		
			
			super();
			setHitbox(G.size, G.size);
			layer = G.layerCreeps;
			type = "creep";
			
		}
		public function setImage():void
		{
			img = new Image(GI.gfx[pic]);
			img.centerOO();
			img.x += G.size / 2;
			img.y += G.size / 2;
			graphic = img;			
			
		}
		public function _init(g:GameInfo,startX:int, startY:int, pic:String):void		
		{
			isSpawner = false;
			GI = g;
			traits = new Vector.<Trait>();
			effects = new Vector.<Effect>();
			this.pic = pic;
			reachedGoal = gotDestroyed = false;
			defaultSpeed = G.defaultSpeed;
			damageResistance = 0;
			speedModification = 1;
			wasDamaged = false;
			damageSinceLastSpark = 0;
			reward = 3;
			setImage();
			img.angle = 0;
			this.health =maxHealth= G.defaultHealth;
			x = startX;
			y = startY;				
			path = DM.path(x, y);
			drainAmount = 10;
			aura = null;
			immunities = new Vector.<String>();	
			
		}
		private function applyTraits(timing:String):void
		{
			var tl:int = traits.length;
			for (var i:int = 0; i < tl; i++) 
			{
				if (traits[i].timing == timing)
				{					
					traits[i].applyTo(this);
				}
			}
		}
		override public function added():void
		{
			applyTraits("onstart");
			healthBar = new HealthBar(halfWidth, height / 6);
			healthBar.graphic.x = halfWidth - healthBar.halfWidth;
			healthBar.graphic.y = height - healthBar.height;
			handleHealth();
			if (aura != null)
			{
				world.add(aura);
			}
			world.add(healthBar);
		}
		
		override public function removed():void
		{	
			if (aura != null)
			{
				world.remove(aura);
			}			
			world.remove(healthBar);
			healthBar = null;
		}		

		public function handleEffects():void
		{
			for (var i:int = 0; i < effects.length; i++) 
			{
				effects[i].update();
				effects[i].handleCreep(this);
				if (effects[i].over)
				{
					effects.splice(i, 1);
				}
			}
		}
		public function applyEffect(eff:Effect):void
		{
			//check for immunity
			if (!isImmuneTo(eff.effectType)&&!isImmuneTo(eff.effectSource))
			{
				var isNew:Boolean = true;
				var el:int = effects.length;
				for (var i:int = 0; i < el; i++) 
				{
					if (effects[i].type == eff.type && !eff.oneShot)
					{
						effects[i].timer = eff.duration;
						isNew = false;
						break;
					}
				}
				if (isNew)
				{
					//trace("applying",eff.effectType);
					effects.push(eff);				
				}
			}
		}
		public function effectAndImmunityInfo():String
		{
			var str:String = "";
			var el:int = effects.length;
			for (var i:int = 0; i < el; i++) 
			{
				str += i;
				str += effects[i].effectType;
			}
			var il:int = immunities.length;
			for (var j:int = 0; j < il; j++) 
			{
				str += immunities[j];
			}
			return str;
		}
		public function isImmuneTo(source:String):Boolean
		{
			var il:int = immunities.length;
			for (var i:int = 0; i < il; i++) 
			{
				if (immunities[i] == source)
					return true;
			}
			return false;
		}
		public function addImmunity(imm:String):void
		{
			if(immunities.indexOf(imm)<0)
				immunities.push(imm);			
				//trace("immunities",immunities);
		}
		public function removeImmunity(imm:String):void
		{
			var pos:int = immunities.indexOf(imm);
			if (pos > -1)
			{
				immunities.splice(pos, 1);
			}		
		}
		override public function update():void
		{
			if (Level(world).gameIsPaused)
			return;
			
			move();
			handleProjectiles();
			handleEffects();
			handleTraps();
			handleAuras();
			handleHealth();
			wasDamaged = false;
			
		}
		public function handleHealth():void
		{
			
			if (health <= 0)
				applyTraits("ondeath");				
			healthBar.x = x;
			healthBar.y = y;	
			healthBar.setFilled(health / maxHealth);		
		}
		public function applyDamage(dmg:Number):void
		{
			if (health == maxHealth)
			{
				applyTraits("onfirsthit");
			}
			health -= dmg;
			wasDamaged = true;
			if (health <= 0)
				gotDestroyed = true;
			var switchpoint:int = 10;
			damageSinceLastSpark += dmg;
			var outputDamage:int = 0;
			if (dmg >= switchpoint )
			{
				outputDamage = dmg;				
			}
			else
			{
				if (damageSinceLastSpark >= switchpoint)
				{
					outputDamage = damageSinceLastSpark;
					damageSinceLastSpark = 0;
				}				
			}
			if(outputDamage>0)
				TextSpark(FP.world.create(TextSpark)).setup(centerX, centerY, "-" + String(int(outputDamage)),0xff5555,18);
			
		}
		public function handleTraps():void
		{
			var traps:Array = [];
			collideInto("trap", x, y, traps);
			var tl:int = traps.length;
			for (var i:int = 0; i < tl; i++) 
			{
				applyEffect(traps[i].effect.clone());
			}
		}
		public function handleAuras():void
		{
			var auras:Array = [];
			world.getType("aura", auras);
			var al:int = auras.length;
			for (var i:int = 0; i < al; i++) 
			{				
				if (this.distanceToPoint(auras[i].centerX, auras[i].centerY) < auras[i].range)	
				{
					applyEffect(auras[i].effect.clone());
				}			
			}
		}		
		public function handleProjectiles():void
		{
			var projectiles:Array = [];
			collideInto("projectile", x, y, projectiles);
			var pl:int = projectiles.length;
			for (var i:int = 0; i < pl; i++) 
			{
				var prj:Projectile = projectiles[i] as Projectile;
				GI.zombieMoan();
				for (var j:int = 0; j < prj.effects.length; j++) 
				{
					applyEffect(prj.effects[j]);
				}
				if (prj.blockedByCreep)
				{
					prj.collidable = false;
					world.recycle(prj);
				}
			}
		}
		public function move():void
		{
			applyTraits("onmove");
			var realSpeed:Number = FP.elapsed * defaultSpeed * (speedModification);			
			//if the path has a second point
			if (path.length >= 2)
			{		
				Image(graphic).angle = 90+FP.angle(x, y, path[1].x, path[1].y);
				//step towards second point
				FP.stepTowards(this, path[1].x, path[1].y, realSpeed);
				//if second point is reached
				if (FP.distance(x, y, path[1].x, path[1].y) <= realSpeed)
				{				
					//remove first point (shifting it,second becomes first, third becomes second)
					path.shift();	
				}				
			}
			//if at end of path, mark it for removal
			else	
			{					
				reachedGoal = true;
			}
			if (aura != null)
			{
				aura.x = x - aura.range + G.halfSize;			
				aura.y = y - aura.range + G.halfSize;
			}
		}

	}
}