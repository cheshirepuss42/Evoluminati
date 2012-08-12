package Pickups 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;

	public class Pickup extends Entity implements IPickup
	{	
		public var img:Image;
		public var name:String;
		public var GI:GameInfo;
		public function Pickup() 
		{
			//image or animation
			//a name which is shown as textspark on pickup, name in menu, and textspark on use
			//
		}
		
		public function init(g:GameInfo,gridposX:int, gridposY:int):void
		{
			GI = g;
			
		}
		
	}

}