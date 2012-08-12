package Worlds 
{

	import UI.*;
	import net.flashpunk.FP;
	import net.flashpunk.utils.*;
	import net.flashpunk.graphics.*;
	
	public class ConversationPlayer extends WorldMenu
	{
		private var currentPanel:int = 1;
		private var skipButton:Button;
		public function ConversationPlayer(g:GameInfo) 
		{
			super(g);
		}
		override public function begin():void
		{
			super.begin();
			loadPanels();
		}
		public function loadPanels():void
		{
			currentPanel = 1;
			for (var i:int = 0; i < GI.currentLevelData.conversation.length; i++) 
			{				
				GI.currentLevelData.conversation[i].scrY = FP.height;
				add(GI.currentLevelData.conversation[i]);
			}
			skipButton = Button(create(Button)).setupButton(GI,"skip", FP.width - 100, FP.height - 50, 100, 50, moveOn, "", 16);
			showNextPanel();	
		}
		override public function update():void
		{
			super.update();
			if (Input.mousePressed)			
			{
				if(currentPanel <= GI.currentLevelData.conversation.length)
					showNextPanel();
				else
				{
					moveOn();
				}
			}
		}
		private function moveOn():void
		{
			if (GI.currentLevelData.levelID <= 1)
			{
				FP.world = new Level(GI);
			}
			else
			{
				FP.world = new UpgradeMenu(GI);
			}
		}
		public function showNextPanel():void
		{	
			GI.sfx["menu_select_01"].play();
			for (var i:int = 0; i < currentPanel; i++) 
			{
				
				var panel:ConversationPanel = GI.currentLevelData.conversation[i];
				
				if (panel.scrY < FP.height)				
				{
					panel.slideFromTo(panel.scrX, panel.scrY, 0, -1 * (panel.height), 0.2);						
				}
				else
					panel.slideFromTo(panel.scrX, FP.height, 0, -1 * (FP.halfHeight + panel.halfHeight), 0.2);
			}
			currentPanel++;	
		}	
		override public function end():void
		{
			for (var i:int = 0; i < GI.currentLevelData.conversation.length; i++) 
			{
				remove(GI.currentLevelData.conversation[i]);
			}	
			super.end();
		}
	}
}