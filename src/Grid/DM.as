package  Grid
{
	import flash.geom.Point;

	//this is a static version of DistanceTable
	public class DM 
	{
		private static var dt:DistanceTable;
		//private static var goal:Point;
		private static var diagonals:Boolean;
		public static var updatesCalled:int = 0;
		public static var pathsMade:int = 0;
		//update must be called in the init phase
		public static function update(grid:Array2D, end:Point, diag:Boolean):void
		{
			diagonals = diag;
			dt = new DistanceTable(grid, end, diagonals);
			updatesCalled++;
		}
		
		public static function map():Array2D
		{
			return dt.map;
		}
		
		//use this to check if the path from start to goal is possible on supplied obstaclegrid
		public static function pointIsBlockedOnGrid(points:Vector.<Point>, obstacleGrid:Array2D):Boolean
		{
			//make a test-distancemap from obstacle-grid
			var testMap:DistanceTable = new DistanceTable(obstacleGrid, dt.goal, dt.diag);
			//if start posistion == unreachable from goal the grid the paths are blocked
			var pl:int = points.length;
			for (var i:int = 0; i < pl; i++) 
			{
				if (testMap.map.get(points[i].x,points[i].y) <= 0)
				{
					return true;
				}
			}
			return false;			
		}
		public static function randomPath(x:int, y:int, length:int):Vector.<Point>
		{
			pathsMade++;
			return dt.getPath(int((x - G.offsetX) / G.size),int((y - G.offsetY) / G.size),G.size,G.size,G.offsetX,G.offsetY,G.size/2,length);			
		}
		//expensive function, generates new path for a creep		
		public static function path(x:int, y:int):Vector.<Point>
		{
			pathsMade++;
			return dt.getPath(int((x - G.offsetX) / G.size),int((y - G.offsetY) / G.size),G.size,G.size,G.offsetX,G.offsetY,G.size/2);			
		}

	}
}