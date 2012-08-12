package Worlds 
{	
	//import net.flashpunk.World;
	import net.flashpunk.World;
	import UI.*;
	import Utils.LevelData;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	import net.flashpunk.FP;
	
	public class StartMenu extends SelectionWorld
	{
		//private var header:Label;
		private var bw:int = 200;
		private var bh:int = 50;
		
		public function StartMenu(gameInfo:GameInfo) 
		{
			super(gameInfo);
			//GI.save.clear();
		}
		override public function begin():void
		{
			GI.loadGame();
			super.begin();

			
		}
		override public function setupControls():void 
		{
			super.setupControls();
			var isStart:Boolean = GI.currentSaveGame.highestLevel == 0;
			var isFinished:Boolean = GI.currentSaveGame.highestLevel == GI.amountOfMaps;
			controls.push(Label(create(Label)).setup(GI,G.GameTitle, FP.halfWidth - (bw*1.25), bh, bw * 2.5, bh * 2, 80));
			controls[0].slideFromTo(controls[0].scrX, -controls[0].height, 0, controls[0].height * 2, 0.25);			
			if(isStart)
				controls.push(Button(create(Button)).setupButton(GI,"Start Game", FP.halfWidth - (bw / 2), FP.halfHeight - (bh / 2), bw, bh, startClick, ""));
			else if(!isFinished)
			{
				controls.push(Button(create(Button)).setupButton(GI,"Continue", FP.halfWidth - (bw / 2), FP.halfHeight - (bh / 2), bw, bh, startClick, ""));
			}
			controls.push(Button(create(Button)).setupButton(GI,"Clear Savegame", FP.halfWidth - (bw / 2), (FP.halfHeight - (bh / 2)) + ((bh + 20) * 2), bw, bh, clearSave, ""));
			if (!isStart)
			{
				controls.push(Button(create(Button)).setupButton(GI,"Select Map", FP.halfWidth - (bw / 2), (FP.halfHeight - (bh / 2)) + bh + 20, bw, bh, mapsClick, ""));
				
			}	

		}
		private function startClick():void
		{
			GI.currentLevelData = new LevelData(GI,String(GI.currentSaveGame.highestLevel+1));
			FP.world = new ConversationPlayer(GI);
		}
		private function mapsClick():void
		{
			FP.world = new MapSelector(GI);
		}
		private function clearSave():void
		{
			GI.save.clear();						
		}
	
	}
}