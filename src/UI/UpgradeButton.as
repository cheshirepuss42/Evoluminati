package UI 
{
	import net.flashpunk.graphics.Image;
	import Utils.UpgradeStat;
	import Worlds.UpgradeMenu;

	public class UpgradeButton extends ImageButton
	{
		private var rankBoxes:Vector.<Image>;
		private var maxRank:int = 4;
		private var currentRank:int = 0;
		private var upgradeName:String;
		private var available:Boolean;
		public var pointsSpentOnUpgrade:int;
		public var stat:UpgradeStat;
		public function UpgradeButton() 
		{
			//text
			//4 boxes

		}
		public function setupUpgradeButton(g:GameInfo,nx:int, ny:int, w:int, h:int,upgrStat:UpgradeStat):UpgradeButton
		{
			stat = upgrStat;
			//pointsSpentOnUpgrade = 0;
			//this.available = available;
			//upgradeName = txt;
			super.setupImageButton(g,stat.description, nx, ny, w, h, new Function(), "");
			this.txt.y = 0;
			var boxwidth:int = (width - (maxRank * 2)) / maxRank;
			rankBoxes = new Vector.<Image>();
			for (var i:int = 0; i < maxRank; i++) 
			{
				var box:Image = Image.createRect(boxwidth-2, boxwidth-2, 0x00ff00, 0.9);
				box.x = 6+(i * (boxwidth));
				box.y =height-(boxwidth + 10);
				addGraphic(box);
				rankBoxes.push(box);
				
			}	
			rank = stat.ranks;
			//sleeps = !stat.isAvailable;
			return this;		
		}
		public function get upgradeCost():int
		{
			return stat.upgradeCost;//(2 * powerTwo(stat.ranks) * powerTwo(2 * (stat.depth + 1))) / 4;			
		}

		override public function onClick():void 
		{
			super.onClick();
			
			if (stat.isAvailable()&&stat.ranks < maxRank && UpgradeMenu(world).availablePoints>=upgradeCost)	
			{
				UpgradeMenu(world).availablePoints -= upgradeCost;
				//stat.ranks += 1;
				stat.pointsSpent += upgradeCost;				
				rank = stat.ranks+1;
			}			
		}

		override public function update():void 
		{
			//should not be set on 
			super.update();
			rank = stat.ranks;
			greyedOut = !stat.isAvailable();
			//active = true;
			//trace("dskfjdskjfksjdf");
		}
	
		public function set rank(r:int):void
		{
			if (r >= 0 && r <= maxRank)
			{
				stat.ranks = r;
				for (var i:int = 0; i < maxRank; i++) 
				{
					rankBoxes[i].alpha = (i <= stat.ranks-1)?0.9:0.1;				
				}
			}
			//
			txt.text = stat.description + "\n\nupgrade for\n" + upgradeCost;
			if (stat.ranks >= maxRank)
				txt.text = stat.description + "\nupgrade complete";
		}
		public function get rank():int
		{
			return stat.ranks;
		}
	}
}