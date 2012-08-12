package Worlds 
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import UI.*;
	import net.flashpunk.FP;
	import Utils.LevelData;
	
	public class MapSelector extends SelectionWorld
	{
		public var selectedMap:String;		
		public function MapSelector(g:GameInfo)
		{
			super(g,true);
		}
		override public function setupControls():void
		{
			//A.showStatics();
			super.setupControls();
			defaultText = "Choose your next level";
			var w:int = 60;
			var h:int = 60;
			var amx:int = 5;
			var amy:int = 5;
			var pad:int=20;
			var totalw:int = (amx * w) + (pad * (amx - 1));
			var totalh:int = (amy * h) + (pad * (amy - 1));
			var offsetx:int = FP.halfWidth - (totalw / 2);
			var offsety:int = FP.halfHeight - (totalh / 2)-25;
			var i:int = 0;
						
			for (var name:Object in GI.lvl)
			{	
				//trace(name, A.lvl[name].settings.@logo);
				var logo:String = GI.lvl[name].settings.@logo;
				var button:MapButton=MapButton(create(MapButton)).setupMapButton(GI,"Map " + (i + 1),
																		offsetx + ((i % amx) * (w + pad)),
																		offsety + ((int(i / amx) % amy) * (h + pad)),
																		w,
																		h,
																		mapClick,
																		"",
																		new Image(GI.gfx[logo]),
																		String(name));
				if (i > GI.currentSaveGame.highestLevel)
				{
					button.infoTxt = "Proceed with the game to unlock this level";
					button.sleeps = true;
				}
				else
				{
					if (i == 0)
						button.infoTxt = "The start of the game";
					else
					{
						button.infoTxt = "collected " + GI.currentSaveGame.results[i].pointTotal + " points so far";
					}
				}
				//controls.push(
				//backButton=Button(create(Button)).setupButton("to start", 0, FP.height - 50, 200, 50, backClick);
				controls.push(Button(create(Button)).setupButton(GI,"to start", 0, FP.height - 50, 200, 50, backClick));
				i++;
			}	
		}
		private function backClick():void
		{
			if(GI.currentLevelData!=null)
				GI.currentLevelData.dispose();
			FP.world = new StartMenu(GI);
		}
		private function mapClick():void
		{
			//before this is called selectedmap is set
			GI.currentLevelData = new LevelData(GI,selectedMap);
			FP.world = new ConversationPlayer(GI);
		}		
	}

}