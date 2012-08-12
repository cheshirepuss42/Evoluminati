package Utils 
{
	import Creeps.*;
	import Grid.Array2D;
	import net.flashpunk.FP;
	import Shooter.Player;
	
	import flash.geom.Point;
	import Points.*;
	import Structures.*;
	import flash.utils.*;
	import UI.ConversationPanel;
	import Utils.UpgradeEntity;
	
	public class LevelData 
	{		
		public var upgrades:Vector.<UpgradeEntity>;
		public var structures:Vector.<Structure>;
		public var player:Player;
		public var entryPoints:Vector.<Point>;
		public var entryPointIds:Vector.<int>;
		public var exitPoint:Point;
		public var rechargePoints:Vector.<RechargePoint>;
		public var traps:Vector.<Trap>;
		public var waves:Vector.<Vector.<CreepSquad>>;
		public var wavesTiming:Vector.<Number>;
		public var startEnergy:int;
		public var levelID:int;
		public var conversation:Vector.<ConversationPanel>;
		public var tutorial:TutorialPlayer;
		public var result:LevelResult;
		public var maxCreeps:int;
		public var prevPoints:int = 0;
		public var GI:GameInfo;
		public function LevelData(g:GameInfo,level:String)//,level:XML,upgrades:Dictionary) 
		{	
			GI = g;
			setup();
			//load the xml
			var xml:XML = GI.lvl[level];			
			//read general settings
			G.gridWidth = xml.settings.@width;
			G.gridHeight = xml.settings.@height;
			startEnergy = xml.settings.@startenergy;
			levelID = int(level);
			maxCreeps = xml.settings.@maxcreeps;
			result = new LevelResult();
			Stats.data = result.upgrades;
			result.levelID = levelID;
			//read the map-structures
			for each(var structure:XML in xml.structure)
			{				
				var structureClass:Class = Object(GI.upgrades[String(structure.@structureid)]).constructor;
				var str:Structure = new structureClass(GI);
				str.setPos(structure.@x, structure.@y);
				
				if (str is BasicWall)
				{
					BasicWall(str).setPosAndSize(structure.@x, structure.@y,structure.@w, structure.@h);
				}
				structures.push(str);
			}				
			//add surrounding walls
			structures.push(BasicWall(new BasicWall(GI)).setPosAndSize(0, 0, G.gridWidth, 1));
			structures.push(BasicWall(new BasicWall(GI)).setPosAndSize(0, G.gridHeight-1, G.gridWidth, 1));
			structures.push(BasicWall(new BasicWall(GI)).setPosAndSize(0, 1, 1, G.gridHeight-2));
			structures.push(BasicWall(new BasicWall(GI)).setPosAndSize(G.gridWidth - 1, 1, 1, G.gridHeight - 2));
			

			
			//read entrypoints
			for each(var entryPoint:XML in xml.start)
			{
				entryPoints.push(new Point(entryPoint.@x, entryPoint.@y));
				entryPointIds.push(entryPoint.@id);
				//entryPoints[.push(new Point(entryPoint.@x, entryPoint.@y));
			}		
			
			
			//read exitpoint
			exitPoint = new Point(xml.goal.@x, xml.goal.@y);
			
			//read traps
			for each(var trap:XML in xml.trap)
			{
				traps.push(new Trap().setupTrap(GI,int(trap.@x), int(trap.@y),String(trap.@type)));
			}			
			
			//read rechargepoints
			for each(var rechargePoint:XML in xml.recharge)
			{
				var rp:RechargePoint = new RechargePoint().init(GI,"rechargepoint_02", rechargePoint.@x, rechargePoint.@y);
				rechargePoints.push(rp);
			}				
			//read upgrades
			
			for each(var upg:XML in xml.upgrade)
			{				
				var ue:UpgradeEntity = GI.upgrades[String(upg.@id)] as UpgradeEntity;
				upgrades.push(ue);
			}
			//read waves
			for each(var wave:XML in xml.wave)
			{
				waves.push(new Vector.<CreepSquad>());
				wavesTiming.push( Number(wave.@timeout)/1000);
				for each(var squad:XML in wave.children())
				{
					
					waves[waves.length - 1].push(new CreepSquad(GI,entryPoints[entryPointIds.indexOf(squad.@startpointid)], squad.@amount,Number(squad.@spacing)/1000 , squad.@creepid ));					
				}
			}
			//read conversation
			for each(var line:XML in xml.talk)
			{				
				conversation.push(new ConversationPanel().setupPanel(GI,line.@charactername, String(line.@text), (String(line.@side) == "left")?true:false));
			}
			//read tutorial			
			for each(var tut:XML in xml.tutorial)
			{	
				tutorial.addPanel(tut.@x, tut.@y, tut.@text);
			}	
			//read the player
			player = new Player(GI,xml.player.@x, xml.player.@y);			
		}

		
		//public function setResult(text:String,dead:Boolean,points:int):void
		//{
			//
			//trace(result,points);
			//result = new LevelResult();
			//result.text = text;
			//result.dead = dead;
			//if (levelID >1)
				//points += A.currentSaveGame.results[levelID - 1].pointsCollected;
			//result.pointsCollected = points;
		//}
		//public function stat(name:String):UpgradeStat 
		//{
			//return result.upgrades.getStat(name);
		//}
		private function setup():void
		{
			upgrades =  new Vector.<UpgradeEntity>();
			structures=new Vector.<Structure>();		
			entryPoints = new Vector.<Point>();
			entryPointIds=new Vector.<int>();
			rechargePoints = new Vector.<RechargePoint>();
			waves = new Vector.<Vector.<CreepSquad>>();
			wavesTiming = new Vector.<Number>();
			conversation = new Vector.<ConversationPanel>();
			tutorial = new TutorialPlayer(GI);
			traps = new Vector.<Trap>();
			
		}
		public function dispose():void
		{
			FP.world.removeAll();
			upgrades = null;
			structures = null;
			player = null;
			waves = null;
			entryPoints = null;
		}
		public function content():String
		{
			var str:String = "";
			str += " LevelID:" + levelID;
			str += " Result: " +((result != null)?result.content():"null");
			return str;
		}
		
	}
}