package UI 
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import Worlds.*;
	
	public class MapButton extends ImageButton
	{
		public var targetMap:String;
		public function MapButton() 
		{

			
		}
		public function setupMapButton(g:GameInfo,txt:String,nx:int,ny:int,w:int,h:int,callback:Function,infoTxt:String,_image:Image,map:String):MapButton
		{
			super.setupImageButton(g,txt, nx, ny, w, h, callback, infoTxt, _image);
			targetMap = map;
			return this;
		}

		override public function onClick():void 
		{
			MapSelector(world).selectedMap = targetMap;
			super.onClick();
		}
	}
}