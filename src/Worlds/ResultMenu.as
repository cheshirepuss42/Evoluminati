package Worlds 
{	
	import UI.*;	
	import net.flashpunk.FP;
	import net.flashpunk.utils.*;
	import Utils.*;
	public class ResultMenu extends WorldMenu
	{		

		public function ResultMenu(g:GameInfo) 
		{
			super(g);		
		}

		override public function begin():void
		{
			super.begin();			
			var bw:int = 200;
			var bh:int = 50;
			//show result
			var headertext:String = (GI.currentLevelData.result.dead)?"YOU DIED!\n":"YOU MADE IT!!!\n";
			
			add(new Label().setup(GI,headertext+"\n collected points:"+String(GI.currentLevelData.result.pointsCollected), FP.halfWidth - bw, bh, bw * 2, bh * 2, 20));
			if (GI.currentLevelData.result.dead)
			{
				//retry level button
				//back button				
				add(new Button().setupButton(GI,"Retry Level", FP.halfWidth - (bw / 2), FP.halfHeight + (bh / 2), bw, bh, retryLevelClick, ""));
				add(new Button().setupButton(GI,"Back to main menu", FP.halfWidth - (bw / 2), FP.halfHeight + (bh * 1.5), bw, bh, noSaveClick, ""));				
			}
			else
			{
				if (GI.currentLevelData.levelID < GI.amountOfMaps)
				{
					add(new Button().setupButton(GI,"Next Level", FP.halfWidth - (bw / 2), FP.halfHeight - (bh / 2), bw, bh, nextLevelClick, ""));
					add(new Button().setupButton(GI,"Retry Level", FP.halfWidth - (bw / 2), FP.halfHeight + (bh / 2), bw, bh, retryLevelClick, ""));
					add(new Button().setupButton(GI,"Back to main menu", FP.halfWidth - (bw / 2), FP.halfHeight + (bh * 1.5), bw, bh, mainMenuClick, ""));
					add(new Button().setupButton(GI,"Back without saving", FP.halfWidth - (bw / 2), FP.halfHeight + (bh *2.5), bw, bh, noSaveClick, ""));
				}
				else
					add(new Button().setupButton(GI,"Back to main menu", FP.halfWidth - (bw / 2), FP.halfHeight + (bh * 1.5), bw, bh, mainMenuClick, ""));
			}		
		}

		private function retryLevelClick():void
		{
			GI.currentLevelData=new LevelData(GI,String(GI.currentLevelData.levelID));
			FP.world = new ConversationPlayer(GI);
		}
		private function mainMenuClick():void
		{	
			setTotalPoints();
			GI.saveGame();
			noSaveClick();					
		}
		private function noSaveClick():void
		{
			FP.world = new StartMenu(GI);
		}		
		private function nextLevelClick():void
		{
			setTotalPoints();
			GI.saveGame();			
			GI.currentLevelData=new LevelData(GI,String(GI.currentLevelData.levelID + 1));
			FP.world = new ConversationPlayer(GI);		
		}
		private function setTotalPoints():void
		{
			var prevLev:int = GI.currentLevelData.levelID - 1;
			var prevTotal:int = 0;
			if (prevLev > 0)
			{
				prevTotal = GI.currentSaveGame.results[prevLev].pointTotal;
			}			
			GI.currentLevelData.result.pointTotal =GI.currentLevelData.result.pointsCollected+ prevTotal;
		}

	}

}