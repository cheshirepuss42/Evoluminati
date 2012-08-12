package Utils 
{
	public class LevelResult 
	{
		public var text:String;
		public var dead:Boolean;
		public var pointsLeftAfterUpgrade:int;
		public var pointsCollected:int;
		public var pointTotal:int;
		public var levelID:int;
		public var upgrades:UpgradeStats;
		public function LevelResult() 
		{
			upgrades = new UpgradeStats();
		}
		public function content():String
		{
			var str:String = "LevelResult: ";
			str += "\nid:" + levelID;
			str += "\npoints:" + pointsCollected;
			str += "\nstats:\n" + upgrades.content();
			return str+"\n";
		}
		
		
	}

}