package 
{
	//import flash.display.Sprite;
	//import flash.events.Event;
	//import Worlds.ConversationPlayer;
	//import Worlds.Level;
	import net.flashpunk.Engine
	import net.flashpunk.FP;
	//import Utils.LevelData;
	//import Worlds.StartMenu;
	//import net.flashpunk.utils.*;
	//import net.flashpunk.graphics.*;
	
	[SWF(width = '800', height = '600', backgroundColor = '#000000', frameRate = '40')]
	
	public class GameController extends Engine 
	{
		
		public function GameController():void 
		{
			super(stage.stageWidth, stage.stageHeight, stage.frameRate, true);	
			
		}
		override public function init():void
		{
			//FP.screen.color = 0x444444;
			FP.world = new Preloader();
		}

	}
	
}