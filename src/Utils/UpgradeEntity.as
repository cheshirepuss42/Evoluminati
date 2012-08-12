package Utils 
{
	import net.flashpunk.Entity;

	public class UpgradeEntity extends Entity
	{
		public static var name:String;
		public var infoText:String;
		public var properName:String;
		public var energyCost:int;
		public var snapsToGrid:Boolean;
		public var gfx:String;
		public var GI:GameInfo;
		public function UpgradeEntity(g:GameInfo) 
		{
			GI = g;
		}
		public function setInfoText(txt:String):void
		{
			
			
		}
		public function getInfo():String
		{
			return infoText + "\ncost: " + energyCost;
		}


	}

}