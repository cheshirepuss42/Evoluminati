package Utils 
{
	import flash.utils.Dictionary;
	
	public class UpgradeStats 
	{
		public var stats:Dictionary = new Dictionary();
		
		public var player_damage:String = "player_damage";
		public var tower_damage:String = "tower_damage";
		public var tower_range:String = "tower_range";
		public var player_range:String = "player_range";
		public var flamer:String = "flamer";
		public var sniper_tower:String = "sniper_tower";
		public var creepsallowedthrough:String = "creepsallowedthrough";
		public var slow:String = "slow";
		public var damageovertime:String = "damageovertime";
		public var upgradepointbonus:String = "upgradepointbonus";
		public var ambientrecharge:String = "ambientrecharge";
		
		public function UpgradeStats()
		{
			stats[player_damage] = new UpgradeStat();
			stats[player_range] = new UpgradeStat();
			stats[flamer] = new UpgradeStat();
			stats[tower_range] = new UpgradeStat();
			stats[tower_damage] = new UpgradeStat();
			stats[sniper_tower] = new UpgradeStat();
			stats[creepsallowedthrough] = new UpgradeStat();
			stats[upgradepointbonus] = new UpgradeStat();
			stats[ambientrecharge] = new UpgradeStat();
			stats[damageovertime] = new UpgradeStat();
			stats[slow] = new UpgradeStat();	
			
		
			for(var key:Object in stats)
			{
				this.stats[key].description = String(key);
			}			
			
			stats[player_damage].add(stats[player_range]);
			stats[player_range].add(stats[flamer]);
			
			stats[tower_damage].add(stats[tower_range]);
			stats[tower_range].add(stats[sniper_tower]);
			
			stats[creepsallowedthrough].add(stats[slow]);
			stats[slow].add(stats[damageovertime]);
			
			stats[creepsallowedthrough].add(stats[upgradepointbonus]);
			stats[upgradepointbonus].add(stats[ambientrecharge]);
		}
		
		public function bfList():Vector.<UpgradeStat>
		{
			var list:Vector.<UpgradeStat> = new Vector.<UpgradeStat>();
			list.push(stats[player_damage]);
			list.push( stats[tower_damage]);
			list.push( stats[creepsallowedthrough]);
			list.push( stats[player_range]);
			list.push(stats[tower_range]);
			list.push( stats[slow]);
			list.push( stats[upgradepointbonus]);
			list.push( stats[flamer]);
			list.push( stats[sniper_tower]);
			list.push( stats[damageovertime]);
			list.push( stats[ambientrecharge]);
			return list;
		}
		public function setRank(variable:String, rank:int):void
		{
			stats[variable].ranks = rank;
		}
		public function getStat(name:String):UpgradeStat
		{
			return stats[name];
		}
		public function content():String
		{
			var str:String = "";
			for(var key:Object in stats)
			{
				str += stats[key].content();
			}
			return str;		
		}
		
		public function copyRanks(source:UpgradeStats):void
		{
			//trace("copying ranks to upgrademenu of new level");
			for(var key:Object in stats)
			{
				//trace(key, stats[key].ranks," = ",source.stats[key].ranks);
				stats[key].ranks = source.stats[key].ranks;
				stats[key].pointsSpent = source.stats[key].pointsSpent;
			}
		}
		
		public function resetRanks():int
		{
			var points:int = 0;
			for(var key:Object in stats)
			{
				points += this.stats[key].pointsSpent;
				this.stats[key].ranks = 0;
				this.stats[key].pointsSpent = 0;
			}
			return points;
		}

	
	}

}