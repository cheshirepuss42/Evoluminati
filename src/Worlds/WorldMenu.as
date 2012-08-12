package Worlds 
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.*;
	import UI.*;

	public class WorldMenu extends World
	{
		protected var bg:Background;
		public var GI:GameInfo;
		//private var backButton:Button;
		//private var hasBackButton:Boolean = false;
		
		public function WorldMenu(gameInfo:GameInfo) 
		{			
			GI = gameInfo;
			//this.hasBack = hasBack;

		}
		override public function begin():void
		{			
			//this.active = false;
			//Input.
			//A.save.clear();
			//A.showStatics();
			//FP.console.log(A.currentSaveGame.content());

			if(!GI.sfx["background_02"].playing)
				GI.sfx["background_02"].loop(0.2);
						
			FP.rate = 1;

			bg=Background(add(new Background(GI)));
			//if (hasBack)
			//{
				//backButton=Button(create(Button)).setupButton("to start", 0, FP.height - 50, 200, 50, backClick);
			//}
			Input.clear();
			Input.mousePressed = false;
			Input.mouseReleased = false;
			
			//FP.alarm(50, activate);		
		}
		override public function update():void 
		{
			if (Input.pressed(Key.ENTER))
			{
				FP.console.visible = !FP.console.visible;
			}	
			//mute on m
			if (Input.pressed(Key.M))
			{				
				FP.volume = (FP.volume == 0)?0.25:0;
			}				
			super.update();
		}

		override public function end():void
		{
			clean();			
		}
		public function clean():void
		{
			bg = null;
			removeAll();
			Input.clear();	
			//A.currentLevelData.dispose();
		}
	}

}