package Worlds 
{
	import net.flashpunk.FP;
	import net.flashpunk.utils.*;
	import Utils.*;
	import UI.*;	

	
	
	public class UpgradeMenu extends SelectionWorld
	{
		private var prevLevel:int;
		public var availablePoints:int;
		public function UpgradeMenu(g:GameInfo)
		{
			super(g);
		}
		
		override public function begin():void
		{
			prevLevel = GI.currentLevelData.levelID - 1;

			if (prevLevel < 1)
				FP.world = new Level(GI);// .worlds["Level"];
			else
			{
				availablePoints = GI.currentSaveGame.results[prevLevel].pointsCollected + GI.currentSaveGame.results[prevLevel].pointsLeftAfterUpgrade;
				defaultText = "points: " + availablePoints;
			}
			super.begin();
		}
		
		override public function setupControls():void 
		{
			var bw:int = 150;
			var bh:int = 40;			
			super.setupControls();
			controls.push(Label(create(Label)).setup(GI,"Pick Your Upgrades" + "\npoints left: " + availablePoints, FP.halfWidth - bw, bh, bw * 2, bh * 2, 20));
			
			var offsetx:int = FP.halfWidth - 215;
			var offsety:int = FP.halfHeight - 160;
			if(prevLevel>=1)
				GI.currentLevelData.result.upgrades.copyRanks(GI.currentSaveGame.results[prevLevel].upgrades);
			

			var list:Vector.<UpgradeStat> = GI.currentLevelData.result.upgrades.bfList();
			
			var counter:int = 0;
			for (var i:int = 0; i < list.length; i++) 
			{				
				if (i >= 1 && list[i].depth > list[i - 1].depth)
					counter = 0;	
				controls.push(UpgradeButton(create(UpgradeButton)).setupUpgradeButton(GI, offsetx + (counter * 110), offsety + (list[i].depth * 110), 100, 100,list[i]));				
				counter++;
				if (i == 3)
				{
					controls[i].scrX += controls[i].halfWidth+2;
				}				
			}
			controls.push(add(new Button().setupButton(GI,"reset", FP.halfWidth - (bw / 2), FP.height - (bh * 3), bw, bh, resetPoints, "Reset points")));
			controls.push(add(new Button().setupButton(GI,"continue", FP.halfWidth - (bw / 2), FP.height - (bh*2), bw, bh, startLevel, "Accept your choices and continue")));
			
		}
		override public function update():void 
		{
			super.update();
			if (Input.pressed(Key.NUMPAD_ADD))
			{
				availablePoints += 100;
			}
			controls[0].text = "Pick Your Upgrades" + "\npoints left: " + availablePoints;
		}

		private function startLevel():void
		{
			GI.currentLevelData.result.pointsLeftAfterUpgrade = availablePoints;
			FP.world = new Level(GI);
		}
		private function resetPoints():void
		{
			availablePoints += GI.currentLevelData.result.upgrades.resetRanks();
		}
		
	}

}