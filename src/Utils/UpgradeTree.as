package Utils 
{
	import Worlds.UpgradeMenu;
	import UI.UpgradeButton;
	public class UpgradeTree 
	{
		//public var startNodes:Vector.<UpgradeTreeNode> = new Vector.<UpgradeTreeNode>();
		public var tree:UpgradeTreeNode;
		public var list:Vector.<UpgradeTreeNode> = new Vector.<UpgradeTreeNode>();
		public var treeWidth:int;
		public var treeDepth:int;
		public var currentNode:UpgradeTreeNode;
		private var counter:int = 0;
		public function UpgradeTree() 
		{
			//a tree with nodes that contain a button
			//when rank is changed, or points are spent
			//walk through tree and set all buttons that should be
			makeList();
			makeTree();
		}
		private function makeList():void
		{
			list.push(new UpgradeTreeNode("player_damage"));
			list.push(new UpgradeTreeNode("player_range"));
			list.push(new UpgradeTreeNode("tower_damage"));
			list.push(new UpgradeTreeNode("tower_range"));
			list.push(new UpgradeTreeNode("flamer"));
			list.push(new UpgradeTreeNode("sniper tower"));
			list.push(new UpgradeTreeNode("creepsallowedthrough"));
			list.push(new UpgradeTreeNode("slow"));
			list.push(new UpgradeTreeNode("damageovertime"));
			list.push(new UpgradeTreeNode("upgradepointbonus"));
			list.push(new UpgradeTreeNode("ambientrecharge"));
			
		}
		private function makeTree():void
		{
			tree = new UpgradeTreeNode();

			
			tree.addNode(list[0]);
			list[0].addNode(list[2]);
			list[2].addNode(list[4]);
			
			tree.addNode(list[1]);
			list[1].addNode(list[3]);
			list[3].addNode(list[5]);			
			
			tree.addNode(list[6]);
			list[6].addNode(list[7]);
			list[7].addNode(list[8]);
			
			list[6].addNode(list[9]);
			list[9].addNode(list[10]);
			
			//list[0].available = true;
			//list[1].available = true;
			//list[6].available = true;			
			
			treeDepth = 3;
			treeWidth = 4;
			//trace(tree.show());
						
		}
		private var unresearchedNodeQueue:Vector.<UpgradeTreeNode>;
		private var finalList:Vector.<UpgradeTreeNode>;
		private var curr:UpgradeTreeNode;
		private function getBreadthFirstList(node:UpgradeTreeNode=null):void
		{
			
			if (node == null)
			{
				curr = tree;
				finalList = new Vector.<UpgradeTreeNode>();
				unresearchedNodeQueue=new Vector.<UpgradeTreeNode>();
			}	
			else
				curr = node;
			
			for (var i:int = 0; i < curr.children.length; i++) 
			{	
				unresearchedNodeQueue.push(curr.children[i]);				
			}
			if (unresearchedNodeQueue.length > 0)
			{
				var n:UpgradeTreeNode = unresearchedNodeQueue.shift();
				finalList.push(n);
				getBreadthFirstList(n);
			}			
		}
		public function bfList():Vector.<UpgradeTreeNode>
		{
			getBreadthFirstList();
			return finalList;
		}
		
		public function controls():Vector.<UpgradeButton>
		{
			getBreadthFirstList();
			var ctrls:Vector.<UpgradeButton> = new Vector.<UpgradeButton>();
			var amnodes:int = finalList.length;
			for (var i:int = 0; i <amnodes ; i++) 
			{
				ctrls.push(finalList[i].button);
			}
			return ctrls;
		}
	}
}
