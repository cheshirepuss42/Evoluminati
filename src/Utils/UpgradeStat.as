package Utils 
{
	public class UpgradeStat 
	{
		public var ranks:int;
		public var pointsSpent:int;
		public var description:String;
		public var varName:String;
		public var parent:UpgradeStat=null;
		public var children:Vector.<UpgradeStat> = new Vector.<UpgradeStat>();
		public var depth:int = 0;
		
		public function UpgradeStat()
		{
		}
		public function get upgradeCost():Number 
		{
			return (4 * powerTwo(ranks) * powerTwo(2 * (depth + 1))) / 4;	
		}
		private function powerTwo(nr:Number):Number
		{
			return Math.pow(2, nr);
		}		
		public function set modifier(nr:Number):void
		{
			modifier = nr;
		}
		public function get modifier():Number
		{
			switch(ranks)
			{
				case 1:return 1.1;
				case 2:return 1.25;
				case 3:return 1.5;
				case 4:return 1.9;
				default:return 1;
			}
		}
		public function isAvailable():Boolean
		{
			if (parent != null)
			{
				return parent.ranks >= 2;
			}
			return true;			
		}
		public function add(upgr:UpgradeStat):UpgradeStat
		{
			upgr.parent = this;
			upgr.depth = depth + 1;
			children.push(upgr);
			return this;
		}

		public function hasChildren():Boolean
		{
			return children.length > 0;
		}
		public function content():String
		{
			return description + "\t ranks:" + ranks +"\t available:" +  isAvailable() + "\n";				
		}
	}


}