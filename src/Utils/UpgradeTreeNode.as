package Utils 
{
	import UI.UpgradeButton;

	public class UpgradeTreeNode 
	{
		public var parent:UpgradeTreeNode = null;
		public var children:Vector.<UpgradeTreeNode> = new Vector.<UpgradeTreeNode>();
		public var upgradeInfo:String = "";
		public var rank:int = 0;
		public var available:Boolean;
		public var depth:int = 0;
		public var button:UpgradeButton;
		
		public function UpgradeTreeNode(info:String="",rank:int=0) 
		{
			//points = 0;
			upgradeInfo = info;
			this.rank = rank;
			button = new UpgradeButton().setupUpgradeButton(info, 0, 0, 80, 80, null, false);
		}
		//public function get hasChildren():Boolean
		//{
			//return children.length > 0;
		//}
		//public function get hasAvailableNodes():Boolean
		//{
			//for (var i:int = 0; i < children.length; i++) 
			//{
				//if (children[i].available)
				//return true;
			//}
			//return false;
		//}
		public function addNode(node:UpgradeTreeNode):UpgradeTreeNode
		{
			node.parent = this;
			//trace(node.depth,depth)
			node.available = (available && rank >= 2);
			node.button.scrX = button.scrX;
			
			node.button.scrY = button.scrY + button.height;
			node.depth = depth + 1;
			children.push(node);
			return this;
		}
		public function isAvailable():Boolean
		{
			if (parent != null)
			{
				return parent.rank >= 2;
			}
			return true;
		}
		//public function setRank(r:int):void
		//{
//
			//
		//}
		
		
	}

}