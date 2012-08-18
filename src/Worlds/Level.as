package Worlds 
{
	import Grid.*;
	import Projectiles.*;
	import Points.*;
	import Shooter.*;
	import Structures.*;
	import UI.*;
	import Creeps.*;
	import Weapons.*;
	import Utils.*;
	import Pickups.*;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.*;

	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;
	import net.flashpunk.World;
	import net.flashpunk.utils.*;
	import net.flashpunk.FP;

	public class Level extends WorldMenu
	{
		public var data:LevelData;
		//does the map use diagonals or only up down left right
		private var diagonals:Boolean = true;
		//the grid with the structures
		private var grid:Array2D;
		//the menu entity that contains buttons
		public var menu:Menu;
		//the cursor entity
		public var cursor:Cursor;		
		//the background entity with the grid painted on
		private var ground:Ground;
		//private var bg:Entity;
		//the player entity
		public var player:Player;
		//the current mode (shoot or build)
		public var playMode:int;
		//the amount of creeps that made it through
		private var amountPassed:int;
		//the amount of enrgy available for shooting and building
		//private var energy:Number;
		//how much time between deployment of new squad
		private var deploymentTimer:Number;
		private var currentDeploymentTime:Number;
		//counts the frames
		private var timer:Number;
		//flag for map update
		private var mapShouldBeUpdated:Boolean;
		//amount of waves deployed so far
		private var waveCount:int;		
		//is the game paused?
		public var gameIsPaused:Boolean;
		private var help:Label;
		private var shouldReset:Boolean = false;
		private var currentWave:Vector.<CreepSquad>;
		private var amountKilled:int;
		private var creepDeathReward:Boolean;
		private var creepEnergyDrainSpeed:Number;

		private var collectedUpgradePoints:int;
		private var exit:GroundPoint;
		private var followPlayer:Boolean;
		private var helpLabel:Label;		
		private var lastSelectedUpgrade:int;
		private var gameIsOver:Boolean;
		public function Level(g:GameInfo)
		{
			super(g);
		}

		override public function begin():void
		{	
			super.begin();
			bg.moving = false;
			
			GI.stopAllSounds();
			GI.sfx["background_01"].loop(0.6);
			FP.rate=1;
			data = GI.currentLevelData;	
			
			//setup grid
			grid = new Array2D(G.gridWidth, G.gridHeight);
			grid.fill(0);
			
			data.maxCreeps *= Stats.data.getStat("creepsallowedthrough").modifier;
			//ambientRechargePS = G.defaultAmbientRecharge * Math.pow(A.currentLevelData.stat("ambientrecharge").modifier,10);
			//paused = false;			
			timer = 0;				
			followPlayer = true;
			collectedUpgradePoints = 0;
			currentWave = new Vector.<CreepSquad>();
			creepDeathReward = false;
			creepEnergyDrainSpeed = 15;
			gameIsOver = false;
			amountKilled = 0;
			lastSelectedUpgrade = 0;
			waveCount = 0;
			mapShouldBeUpdated = true;	

			amountPassed = 0;			
			playMode = G.modeShoot;

			
			currentDeploymentTime = deploymentTimer = 0;
			
			//add all the entities from the data
			for each(var structure:Structure in data.structures)
			{
				//add them to grid and world without noting it isnt done ingame
				addStructure(structure, false, false);				
			}
			//add the traps
			for each(var trap:Trap in data.traps)
			{
				Trap(add(trap));
			}
			//add player
			player = data.player;
			add(player);
			player.energy = data.startEnergy;
			//trace(player.energy);
			//add the background
			ground = new Ground(GI);
			add(ground);
			
			//make the menu and add it
			menu = new Menu(GI,data.upgrades);			
			add(menu);				
			//make cursor and add it
			cursor=new Cursor(GI);			
			add(cursor);			
			
			//add entrance and exitpoints
			for (var i:int = 0; i < data.entryPoints.length; i++) 
			{
				SpawnPoint(add(new SpawnPoint()))._init(GI,"Entrance",data.entryPoints[i].x,data.entryPoints[i].y);	
			}
			exit=GroundPoint(add(new GroundPoint()))._init(GI,"scientist_01", data.exitPoint.x, data.exitPoint.y, 0xff0000);	
			for (var j:int = 0; j < data.rechargePoints.length; j++) 
			{
				add(data.rechargePoints[j]);
			}	
			if (data.tutorial.hasContent())
			{
				add(data.tutorial);
				data.tutorial.start();
				gameIsPaused = true;
			}
		}
		override public function clean():void 
		{
			GI.stopAllSounds();
			grid = null;
			menu = null;
			cursor = null;
			player = null;
			help = null;
			for (var i:int = 0; i < currentWave.length; i++) 
			{
				currentWave[i] = null;
			}
			currentWave = null;		
			helpLabel = null;
			super.clean();
		}


//--------------------------------------------------------------------------------------------------------------------------------------------------		
//----------------------------------------------------------------------- update -------------------------------------------------------------------

		override public function update():void
		{		
			super.update();			
			handleInput();
			handleTutorial();
			if (!gameIsPaused)
			{				
				timer += FP.elapsed;			
				handleStructures();
				handleCreeps();
				handleCursor();
				handlePlayer();			
				menu.setInfo("press space for menu\nwaves left:" + String(data.waves.length-waveCount)+ "\npoints:" + player.upgradePoints);
			}
		}

		private function handleTutorial():void
		{
			if (data.tutorial.hasContent())
			{
				if (!data.tutorial.reachedEnd)
				{
					data.tutorial.update();
				}				
				else
				{				
					remove(data.tutorial);	
					gameIsPaused = false;
				}			
			}
		}		


		private function handleInput():void
		{
			if (Input.pressed(Key.X))
			{
				killAllCreeps();
				waveCount = data.waves.length;
				player.x = exit.x;
				player.y = exit.y;
			}
			if (Input.pressed(Key.F1))
			{
				killAllCreeps();
			}	
		
			if (Input.check(Key.SPACE))
			{	
				if(!gameIsOver)
					showMenu();				
			}		
			if (Input.released(Key.SPACE))
			{
				hideMenu();
			}
			if (Input.pressed(Key.Q))
			{	
				setUpgrade(lastSelectedUpgrade);
			}
			if (Input.pressed(Key.L))
			{
				trace(DM.map().dump());
				trace(grid.dump());
			}				
			if (Input.pressed(Key.NUMPAD_ADD))
			{
				FP.rate *=1.1;
			}
			if (Input.pressed(Key.NUMPAD_SUBTRACT))
			{
				FP.rate *= (1 / 1.1);
			}	
			handleUpgradeSelection();
		}
		public function showMenu():void
		{
			gameIsPaused = true;
			menu.showButtons(true);
			cursor.alpha = 0.2;			
		}
		public function hideMenu():void		
		{
			gameIsPaused = false;
			menu.showButtons(false);
			cursor.alpha = 1;			
		}
		public function handleCreeps():void
		{	
			if(waveCount<data.waves.length)
				deploymentTimer = data.wavesTiming[waveCount];
			//update wave timer
			menu.waveTimer.setFilled( currentDeploymentTime / deploymentTimer);
			
			//deploy squad if timer or f
			if (waveCount<data.waves.length &&(currentDeploymentTime>deploymentTimer || Input.pressed(Key.F)))			
			{
				GI.sfx["wave_new_01"].play();
				//make new squad with am creeps and hitpoints based on waves so far
				currentDeploymentTime = 0;
				deploymentTimer = data.wavesTiming[waveCount];
				currentWave = data.waves[waveCount];
				waveCount++;				
			}
			
			//update the static map with current grid
			if(mapShouldBeUpdated)
				DM.update(grid, data.exitPoint, true);
				
			//go check all creeps
			var allCreeps:Array = [];
			getType("creep", allCreeps);
			
			var amCreeps:int = allCreeps.length;
			var creepCount:int = amCreeps;
			for (var i:int = 0; i < amCreeps; i++) 
			{
				var crp:Creep = allCreeps[i] as Creep;
				if (crp.collideWith(player, crp.x, crp.y) != null)
				{
					player.energy -= crp.drainAmount*FP.elapsed;
				}
				if (mapShouldBeUpdated)
				{
					//give creep a new path if necessary
					crp.path = DM.path(crp.centerX, crp.centerY);
				}				
				if (crp.reachedGoal)
				{	
					recycle(crp);
					GI.sfx["creep_01_escape_01"].play();
					//update ampassed and rangehole
					amountPassed++;
					menu.shieldStatus.setFilled(1 - (amountPassed / (data.maxCreeps)), data.maxCreeps - amountPassed);					
					creepCount--;
				}
				if (crp.gotDestroyed)
				{
					var dropType:String = FP.choose("upgrade","energy");
					CreepDrop(create(CreepDrop)).setup(GI,crp.x, crp.y, crp.reward,dropType);					
					amountKilled++;
					ground.makeStain(crp.x,crp.y)
					recycle(crp);
					GI.zombieMoan();
					//update energy with reward
					if(creepDeathReward)
						player.energy += crp.reward;
						
					creepCount--;
				}				
			}
			mapShouldBeUpdated = false;
			//remove fully deployed squads
			for (var j:int = 0; j < currentWave.length; j++) 
			{
				currentWave[j].update();
				if (currentWave[j].undeployed<=0)
					currentWave.splice(j, 1);
			}
			//reduce timer if there are no creeps left
			var empty:Boolean = (creepCount == 0 && currentWave.length == 0);
			
			if (empty)
			{
								
				if (waveCount == data.waves.length)
				{
					gameOver(false);									
				}
					
			}
			currentDeploymentTime+=FP.elapsed;	
		}		

		private function handleCursor():void
		{
			var teleports:Boolean = playMode == G.modeTeleport;
			if (teleports)
				playMode = G.modeBuild;
			var anywayBlocked:Boolean=((player.energy < cursor.energyCost) ||
				(playMode==G.modeBuild && player.distanceToPoint(mouseX, mouseY, true) > player.currentWeapon.range) ||
				(playMode==G.modeBuild && player.collideWith(cursor, player.x, player.y) != null) ||
				(menu.collidePoint(menu.x, menu.y, mouseX, mouseY)));			
			if (!anywayBlocked)
			{
				if (playMode == G.modeBuild)
				{
					if (cursor.isOnNewGridPoint)
					{
						var gridblocked:Boolean = false;
						for (var i:int = 0; i < cursor.gridSizeX; i++) 
						{
							for (var j:int = 0; j < cursor.gridSizeY; j++) 
							{					
								if (!grid.inside(cursor.gridPosX + i, cursor.gridPosY + j)||(grid.get(cursor.gridPosX + i, cursor.gridPosY + j) != 0))						
								{
									gridblocked = true;
								}
							}					
						}
						var pathblocked:Boolean = gridblocked;
						if (!pathblocked && !teleports)
						{
							grid.setBlock(cursor.gridPosX, cursor.gridPosY, cursor.gridSizeX, cursor.gridSizeY, 1);
							if (DM.pointIsBlockedOnGrid(data.entryPoints, grid))
							{
								pathblocked = true;
							}
							grid.setBlock(cursor.gridPosX, cursor.gridPosY,cursor.gridSizeX,cursor.gridSizeY, 0);							
						}
						cursor.isOnNewGridPoint = false;
						cursor.isBlocked = pathblocked;
					}
				}
				else
					cursor.isBlocked = false;
			}
			else
				cursor.isBlocked = true;
				
			if (teleports)
				playMode = G.modeTeleport;	
		
			cursor.visible = (!Input.check(Key.SHIFT));			
		}	
		
		public function handleStructures():void
		{
			if (Input.mouseDown && timer > 0.5)			
			{
				if (!Input.check(Key.SHIFT))
				{
					if(!cursor.isBlocked && playMode==G.modeBuild)
						putDownStructure(cursor.className, cursor.gridPosX, cursor.gridPosY,true);						
				}
				else
				{
					var str:Structure = collidePoint("structure", mouseX, mouseY) as Structure;
					if (str != null)
					{
						sellStructure(str);
					}					
				}				
			}			
		}
		
		public function setUpgrade(nr:int):void
		{			
			cursor.updateCursor(data.upgrades[nr].name);
			if (data.upgrades[nr].type == "weapon")
			{
				lastSelectedUpgrade = nr;
				var classname:Class = data.upgrades[nr].getClass();
				player.setWeapon(new classname(GI));
				playMode = (player.currentWeapon.properName == "Teleporter")?G.modeTeleport:G.modeShoot;
				
			}
			else
			{	
				player.setWeapon(new NoWeapon(GI));
				playMode = G.modeBuild;
			}			
		}
		public function handleUpgradeSelection():void 
		{
			for (var i:int = 0; i < data.upgrades.length; i++) 
			{
				if (Input.pressed(Key.DIGIT_1 + i))
				{
					setUpgrade(i);
				}
			}
		}
		public function handlePlayer():void
		{
			player.handleInput();
			if (followPlayer)
			{
				camera.x = Math.floor(player.centerX - (FP.halfWidth));
				camera.y = Math.floor(player.centerY - (FP.halfHeight));
			}	
			player.handleEnergyRecharge();
			player.handlePickups();
			if(!cursor.isBlocked &&  !Input.check(Key.SHIFT))
				handleMouseInputForPlayer();
			if (amountPassed >= data.maxCreeps )				
			{
				gameOver(true);				
			}

		}
		private function handleMouseInputForPlayer():void
		{	
			if (Input.mousePressed)//mouse was just clicked
			{		
				if (player.currentWeapon.name == "Teleporter")
				{
					player.startCharging();
				}
			}
			else if (Input.mouseDown)//mouse is down
			{
				if (player.currentWeapon.name != "Teleporter" && !player.currentWeapon.isOnCooldown)
				{
					player.fire();
				}
			}
			else if (Input.mouseReleased)//mouse was just released
			{
				if (player.currentWeapon.name == "Teleporter")
				{
					player.stopCharging();
				}
			}
			else //no buttons pressed
			{
				
			}			
		}
		private function gameOver(dead:Boolean):void
		{
			gameIsOver = true;
			if (dead)
			{				
				GI.sfx["game_over"].play();	
				data.result.dead = dead;
				data.result.pointsCollected = player.upgradePoints;					
				FP.world = new ResultMenu(GI);
			}
			else
			{
				trace("jhgghhhgy");
				if(Input.pressed(Key.SPACE))
				{
					data.result.dead = dead;
					data.result.pointsCollected = player.upgradePoints * Stats.data.getStat("upgradepointbonus").modifier;					
					FP.world = new ResultMenu(GI);						
				}
			}
		}		
//--------------------------------------------------------------------------------------------------------------------------------------------------	
		//public function reset():void
		//{
			//FP.world = A.worlds["StartMenu"];
		//}
		public function sellStructure(str:Structure):void
		{
			if (str.canBeSold)
			{
				G.updateGridWithStructure(grid, str, true);
				recycle(str);
				mapShouldBeUpdated = true;
				player.energy += str.energyCost;							
			}			
		}

		public function addStructure(str:Structure, byPlayer:Boolean = true, sellable:Boolean = true):void
		{
			add(str);
			G.updateGridWithStructure(grid, str, false);
			if (byPlayer)
			{
				str.canBeSold = true;
				GI.sfx["tower_01_new_01"].play();
				mapShouldBeUpdated = true;
				player.energy -= str.energyCost;		
			}				
		}		
		public function putDownStructure(className:Class, px:int, py:int, byPlayer:Boolean):void			
		{
			var str:Structure =  Structure(new className(GI));
			str.setPos(px, py);
			add(str);
			G.updateGridWithStructure(grid, str, false);
			if (byPlayer)
			{
				str.canBeSold = true;
				GI.sfx["tower_01_new_01"].play();
				mapShouldBeUpdated = true;
				player.energy -= cursor.energyCost;				
				cursor.isOnNewGridPoint = true;
			}			
		}

		private function focusOnGridPoint(nx:int, ny:int):void
		{
			camera.x = Math.floor((G.offsetX+(nx*G.size)+G.halfSize) - (FP.halfWidth));
			camera.y = Math.floor((G.offsetY+(ny*G.size)+G.halfSize) - (FP.halfHeight));			
		}
		
		private function helpOnPoint(str:String, nx:int, ny:int):void
		{
			focusOnGridPoint(nx, ny);
			helpLabel = Label(create(Label)).setup(GI,str, FP.halfWidth + G.halfSize, FP.halfHeight + G.halfSize, 300, 200,10);
			gameIsPaused = true;
			followPlayer = false;			
		}

		private function killAllCreeps():void
		{
			var allCreeps:Array = [];
			getType("creep", allCreeps);
			var amCreeps:int = allCreeps.length;
			for (var i:int = 0; i < amCreeps; i++) 
			{
				Creep(allCreeps[i]).gotDestroyed = true;
			}
		}
	}
}