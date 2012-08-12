package Grid
{
	import flash.geom.Point;
	
	//here a distance-map is stored where every node has the distance to the goal
	public class DistanceTable 
	{
		public var map:Array2D;
		public var diag:Boolean;
		public var goal:Point;
		
		public function DistanceTable(grid:Array2D,goal:Point,diag:Boolean) 
		{
			this.goal = goal;
			this.diag = diag;
			//make a copy of gridmap (0 is empty, -1 is filled)
			map = grid.realClone(0, -1);	
			//fill the map starting from goal
			fillMap();
		}
		
		private function fillMap():void
		{
			//trace("making a new map");
			//set the goalposition to 1;
			map.set(goal.x, goal.y, 1);			
			//make list of unchecked nodes
			var unprocessedNodes:Vector.<Point> = new Vector.<Point>();
			//put the goal-node in the list
			unprocessedNodes.push(goal);
			var val:int = 1;
			//while there are still unprocessed nodes
			while (unprocessedNodes.length > 0)
			{
				//get the node that has been added first (and remove it from the list)
				var node:Point = unprocessedNodes.shift();		
				//find the neighbours of the node
				var neighbours:Vector.<*>=map.getNeighbours(node.x,node.y,false);
				//set the value the neighbours should have
				val = map.get(node.x, node.y) + 1;
				var nl:int = neighbours.length;
				for (var i:int = 0; i < nl; i++) 
				{
					//if the neigbour is empty
					if (neighbours[i].content == 0)
					{
						//if diagonal, make it cost more than normal
						if (neighbours[i].diagonal)
						{
							val += 1;
						}
						//set the value to neighbour
						map.set(neighbours[i].x, neighbours[i].y, val);
						//add neighbour to unprocessed list
						unprocessedNodes.push(new Point(neighbours[i].x, neighbours[i].y));
					}					
				}
			}
		}
		public function getPath(cx:int,cy:int,sizeX:Number=1,sizeY:Number=1,offsetX:int=0,offsetY:int=0,wobble:int=0,randomSize:int=0):Vector.<Point>
		{				
			//prepare vector to store path-points in
			var path:Vector.<Point> = new Vector.<Point>();
			//determine the highest node-content to come across
			var lowest:int = (map.width * map.height) + (map.width * map.height);
			//put current position in vector
			path.push(new Point((cx * sizeX) + offsetX, (cy * sizeY) + offsetY));
			var dir:int;
			//do all this while the lowest is not the goal (1)r
			do
			{
				//collect neighbours on map
				var nb:Vector.<*>=map.getNeighbours(cx,cy,diag);
				dir = -1;
				//check which neighbour has the lowest content ands store it in dir
				var nbl:int = nb.length;
				for (var i:int = 0; i < nbl; i++) 
				{					
					if (nb[i].content < lowest && nb[i].content >0)
					{
						lowest = nb[i].content;	
						dir = i;
					}					
				}			
				//if a lower neighbour was found
				if (dir >= 0)
				{
					//set current position to that and add the point to path
					var nx:int = Math.random() * wobble*2;
					var ny:int = Math.random() * wobble * 2;
					cx = nb[dir].x;
					cy = nb[dir].y;					
					path.push(new Point((cx * sizeX) + offsetX + nx - wobble, (cy * sizeY) + offsetY + ny - wobble));
				}
			}			
			while (lowest != 1 && dir != -1)			
			return path;
		}		
	}
}