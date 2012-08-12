package
{
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	import Worlds.StartMenu;


	public class Preloader extends World
	{

		public var assetLoader:AssetLoader = new AssetLoader();
		
		public function Preloader ()
		{

		}
		public override function begin():void
		{
			assetLoader.load();
		}
		
		public override function render (): void
		{			
			if (assetLoader.progress>=1)
			{
				startup();
			}
			else
			{
				var w: int = FP.width * 0.8;
				
				FP.rect.x = (FP.width - w - 4) * 0.5;
				FP.rect.y = FP.height * 0.5 - 12;
				FP.rect.width = w + 4;
				FP.rect.height = 24;				
				FP.buffer.fillRect(FP.rect, 0xFFFFFFFF);
				FP.rect.x = (FP.width - w) * 0.5;
				FP.rect.y = FP.height * 0.5 - 10;
				FP.rect.width = assetLoader.progress * w;
				FP.rect.height = 20;
				
				FP.buffer.fillRect(FP.rect, 0xFF000000);
			}			
			FP.point.x = 0;
			FP.point.y = 0;			
		}		

		
		private function startup (): void
		{
			//trace("loaded it all");
			Text.font = "DATACONTROL";
			FP.volume = 0.20;
			
			FP.world = new StartMenu(assetLoader.gameInfo);// assetLoader.gameInfo.worlds["StartMenu"];
			
			FP.console.enable();			
			FP.console.visible = false;
		}	
	}
}