package  
{
	import flash.display.*;
	import flash.events.*;	
	import flash.media.Sound;
	import flash.net.*;
	import net.flashpunk.Sfx;
	import flash.utils.*;
	import UI.ConversationPanel;
	import Utils.*;
	import Weapons.*;
	import Structures.*;
	import Creeps.*;
	import Worlds.*;
	
	public class AssetLoader extends EventDispatcher
	{
		//loaders for all the different types of stuff
		private var loader:URLLoader = new URLLoader();
		private var creepLoader:URLLoader = new URLLoader();
		private var characterLoader:URLLoader = new URLLoader();
		private var upgradeLoader:URLLoader = new URLLoader();
		private var levelLoader:URLLoader = new URLLoader();
		private var picLoader:Loader = new Loader();
		//the place where all the assets are stored
		private var baseUrl:String = "assets/";
		//place to store the list of assets to be loaded
		private var assetsToLoad:Vector.<XML> = new Vector.<XML>();
		//the assetindex to use while looping through all assets to be loaded
		public var currentAssetIndex:int = 0;
		//the xml of the asset that is now being loaded
		private var currentAsset:XML;
		//the name of the current asset
		private var currentAssetType:String;
		public var gameInfo:GameInfo;
		public function AssetLoader() 
		{
			//A.save.clear();	
			gameInfo = new GameInfo();
			
			stupidThingsIHaveToDoToMakeThisMotherRun();
		}
		//get the precentage of assets loaded
		public function get progress():Number
		{
			return currentAssetIndex / assetsToLoad.length;
		}
		
		public function stupidThingsIHaveToDoToMakeThisMotherRun():void
		{
			//here i register all the classes i will be using with serializing the savegame-class
			registerClassAlias("SaveGame", SaveGame);
			registerClassAlias("LevelResult", LevelResult);
			registerClassAlias("VecLevelResult", Vector.<LevelResult> as Class);
			registerClassAlias("UpgradeStat", UpgradeStat);			
			registerClassAlias("UpgradeStats", UpgradeStats);			
			registerClassAlias("VecUpgradeStats", Vector.<UpgradeStat> as Class);
			
		}
		
		public function load():void
		{
			//setup eventlisteners for the load-complete events
			loader.addEventListener(Event.COMPLETE, assetXMLLoaded);				
			picLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, picLoaded);
			levelLoader.addEventListener(Event.COMPLETE, levelXMLLoaded);		

			//load the xml with the asset-list
			loader.load(new URLRequest(baseUrl + "assets.xml"));
		}
		
		//process the assetlist
		private function assetXMLLoaded(e:Event):void
		{
			loader.removeEventListener(Event.COMPLETE, assetXMLLoaded);			
			var assetsXML:XML = new XML(e.target.data);
			//put all the assets in the list
			for each(var asset:XML in assetsXML.children())
			{				
				assetsToLoad.push(asset);
			}
			currentAsset = assetsToLoad[currentAssetIndex];
			currentAssetType = String(currentAsset.@name);
			loadNextAsset();				
		}
		
		private function loadNextAsset():void 
		{	
			//trace("loading asset");
			var url:String = String(currentAsset.@file);
			//check for type, then load the url based on currentAsset
			switch(currentAsset.name().toString())
			{
				case "pic":		picLoader.load(new URLRequest(baseUrl+"images/"+url));break;
				case "level":	levelLoader.load(new URLRequest(baseUrl+"levels/"+url)); break;
				case "sound": 	gameInfo.sfx[currentAssetType] = new Sound(new URLRequest(baseUrl+"sounds/"+url)); 								
								Sound(gameInfo.sfx[currentAssetType]).addEventListener(Event.COMPLETE, soundLoaded);																
								break;
			}
		}	
		
		//called when asset is done loading
		private function moveOn():void
		{		
			currentAssetIndex++;	
			//if there are still assets to be loaded
			if (currentAssetIndex < assetsToLoad.length)
			{
				//setup new asset, and send event that asset is laded (for progress)
				currentAsset = assetsToLoad[currentAssetIndex];
				currentAssetType = String(currentAsset.@name);
				dispatchEvent(new Event("assetLoaded"));
				loadNextAsset();
			}
			else
			{
				//add all worlds to static var
				setupWorlds();
				setupCreeps();
				setupCharacters();
				setupArsenal();
				//send 'done' event
				dispatchEvent(new Event("allAssetsLoaded"));			
			}
		}
		private function setupCreeps():void
		{
			gameInfo.creeps["BasicCreep"] = new BasicCreep();
			gameInfo.creeps["FastMover"] = new FastMover();
			gameInfo.creeps["SlowBigCreep"] = new SlowBigCreep();
			gameInfo.creeps["BossOne"] = new BossOne();
			gameInfo.creeps["BigCreep"] = new BigCreep();
			gameInfo.creeps["FastBigCreep"] = new FastBigCreep();
			gameInfo.amountOfCreeps = 6;
		}
		private function setupWorlds():void
		{
			////load all possible worlds in static for easy access
			//gameInfo.worlds["StartMenu"] = new StartMenu();
			//gameInfo.worlds["MapSelector"] = new MapSelector();
			//gameInfo.worlds["ConversationPlayer"] = new ConversationPlayer();
			//gameInfo.worlds["ResultMenu"] = new ResultMenu();
			//gameInfo.worlds["Level"] = new Level();
			//gameInfo.worlds["UpgradeMenu"] = new UpgradeMenu();

			//if there is no object for the saves, make one in the cookie
			if (gameInfo.save.data.saves == undefined)
			{
				gameInfo.save.data.saves = [];
			}
		}	

		public function setupArsenal():void
		{
			gameInfo.upgrades["FreezeGun"] = new FreezeGun(gameInfo);
			gameInfo.upgrades["OrbGun"] = new OrbGun(gameInfo);
			gameInfo.upgrades["FlameThrower"] = new FlameThrower(gameInfo);
			gameInfo.upgrades["PoisonGun"] = new PoisonGun(gameInfo);
			gameInfo.upgrades["Teleporter"] = new Teleporter(gameInfo);
			gameInfo.upgrades["StandardTower"] = new StandardTower(gameInfo);
			gameInfo.upgrades["ColdTower"] = new ColdTower(gameInfo);
			gameInfo.upgrades["PeaShooter"] = new PeaShooter(gameInfo);
			gameInfo.upgrades["BasicWall"] = new BasicWall(gameInfo);
			gameInfo.amountOfUpgrades = 9;
		}
		public function setupCharacters():void
		{
			gameInfo.characters["AI"] = { properName:"Onboard Artificial Intelligence", pic:"AI" };
			gameInfo.characters["Scientist"] = { properName:"Dr. Van Stoffelbacher", pic:"Scientist" };
			gameInfo.characters["Player"] = { properName:"Model I12-B3/2 (you)", pic:"Player" };
			
		}		

		private function levelXMLLoaded(e:Event):void
		{
			gameInfo.lvl[currentAssetType] = new XML(e.target.data);
			gameInfo.amountOfMaps++;
			moveOn();			
		}
		
		private function picLoaded(e:Event):void
		{
			gameInfo.gfx[currentAssetType] = Bitmap(picLoader.content).bitmapData;
			moveOn();
		}
		
		private function soundLoaded(e:Event):void
		{
			Sound(gameInfo.sfx[currentAssetType]).removeEventListener(Event.COMPLETE, soundLoaded);
			gameInfo.sfx[currentAssetType] = new Sfx(Sound(gameInfo.sfx[currentAssetType]));		
			moveOn();
		}
	}
}