package  
{
	import flash.net.SharedObject;
	import flash.utils.*;
	import net.flashpunk.Sfx;
	import Utils.*;
	
	public class GameInfo 
	{
		[Embed(source = '../bin/assets/fonts/DATACONTROL.ttf', embedAsCFF = "false", fontFamily = 'DATACONTROL')] public static const FONT_DATACONTROL:Class;
		[Embed(source = '../bin/assets/fonts/dynamic.TTF', embedAsCFF = "false", fontFamily = 'DYNAMIC')] public static const FONT_DYNAMIC:Class;
		
		//contains all sound-effects in flashpunk Sfx-format
		public var sfx:Dictionary = new Dictionary();
		//contains all images as bitmapdata
		public var gfx:Dictionary = new Dictionary();
		//contains all leveldata's in XML
		public var lvl:Dictionary = new Dictionary();
		//contains all creeps as Creeps (entities)		
		public var creeps:Dictionary = new Dictionary();
		//contains list of all possible weapons and structures
		public var upgrades:Dictionary = new Dictionary();
		//list of characters to use in conversation
		public var characters:Dictionary = new Dictionary();
		//list of all worlds (level,startmenu, levelpicker, upgrademenu, conversationworld
		public var worlds:Dictionary = new Dictionary();
		//the total amount of levels
		public var amountOfMaps:int = 0;
		//total amount of available upgrades
		public var amountOfUpgrades:int = 0;
		//total amount of different creeps
		public var amountOfCreeps:int = 0;
		//current savegameslot (not yet used)
		public var currentSlot:int = 1;
		//savegame in flashcookie
		public var save:SharedObject = SharedObject.getLocal("savegames");
		//the current savegame
		public var currentSaveGame:SaveGame;
		//the leveldata for this level
		public var currentLevelData:LevelData;	
		
		public function saveGame():void
		{
			//set levelid in result
			currentLevelData.result.levelID = currentLevelData.levelID;
			//put result in current savegame
			currentSaveGame.setLevelResult(currentLevelData.result); 	
			
			//serialize savegame to bytes
			var ba:ByteArray = new ByteArray();
			ba.writeObject(currentSaveGame);
			ba.position = 0;
			
			//put serialized data in cookie
			save.data.saves[currentSlot] = ba;
			save.flush();
		}
		public function loadGame():void
		{		
			//save.clear();
			//save.data.saves = null;
			//if there is no savegame in cookie
			if (save.data.saves == undefined)
			{
				save.data.saves[currentSlot] = null;
			}
			if (save.data.saves[currentSlot] == null)
			{
				//make a new empty savegame
				currentSaveGame = new SaveGame();
			}
			else
			{				
				//else deserialize the cookiedata
				var ba:ByteArray = save.data.saves[currentSlot] as ByteArray;	
				ba.position = 0;
				//and put it in currentsavegame
				currentSaveGame = SaveGame(ba.readObject());

			}	
			//save.clear();
		}
		public function stopAllSounds():void
		{
			for each (var s:Sfx in sfx) 
			{
				s.stop();
			}
		}
		public function showStatics():void
		{
			trace("----------------------------------------------------CurrentSave:");
			//trace("pathsMade",
			trace((currentSaveGame!=null)?currentSaveGame.content():null);
			trace("-------------------------LevelData:");
			trace((currentLevelData!=null)?currentLevelData.content():"null");
		}		
		
		
		
		
		
		
		
		
		
		
		
		//controlling the sounds made by creeps that are hit
		
		public function zombieMoan(chance:Number=0.3):void
		{
			var random:int = Math.random() * (3*(1/chance));
			switch(random)
			{
				case 0:sfx["zombie_moan_01"].play(); break;
				case 1:sfx["zombie_moan_02"].play(); break;
				case 2:sfx["zombie_moan_03"].play(); break;
				case 3:sfx["zombie_moan_04"].play(); break;
			}
		}

		public function zombieBite(chance:Number=0.2):void
		{
			switch(int(Math.random() * 2))
			{
				case 0:sfx["zombie_bite_01"].play(); break;
				case 1:sfx["zombie_bite_02"].play(); break;
			}
		}
		
	}

}