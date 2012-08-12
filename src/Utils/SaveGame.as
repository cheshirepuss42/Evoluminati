package Utils 
{
	import flash.utils.Dictionary;
	public class SaveGame 
	{
		//contains the results of all the levels reached so far
		public var results:Dictionary;
		public var slot:int;
		public var highestLevel:int;
		public function SaveGame() 
		{
			results = new Dictionary();
		}
		public function setLevelResult(res:LevelResult):void
		{
			results[res.levelID] = res;
			highestLevel = (res.levelID > highestLevel)?res.levelID:highestLevel;			
		}
		public function getLevelResult(level:int):LevelResult
		{
			if (results[level] != null)
			{
				return results[level];
			}
			return null;
		}
		public function content():String
		{
			
			var str:String = "SaveGame content: \n";
			var rl:int = results.length;
			for (var i:int = 0; i < rl; i++) 
			{
				if (results[i]!=null)
				{
					str += results[i].content();
				}
			}
			return str;
		}
		
	}

}