package Grid 
{
	public class IntGrid 
	{
		private var g:Vector.<int>;
		private var w:int;
		private var h:int;
		private var _neighbours:Vector.<*>;
		private var dirs:Array = [ { x:0, y: -1 }, { x:1, y: -1 }, { x:1, y: 0 }, { x:1, y: 1 }, { x:0, y: 1 }, { x: -1, y: 1 }, { x: -1, y: 0 }, { x: -1, y: -1 } ];
		private var amdirs:int = 8;
		
		public function IntGrid(w:int, h:int) 		
		{
			this.w = w;
			this.h = h;
			g = new Vector.<int>(w * h);
			
		}
		public function Get(x:int, y:int):int 
		{
			return g[(y * w) + x];
		}
		public function Set(x:int, y:int, val:int):void
		{
			g[(y * w) + x] = val;
		}
		public function get neighbours(x:int,y:int):Vector.<*>
		{
			_neighbours = new Vector.<*>(amdirs);
			for (var i:int = 0; i < amdirs; i++) 
			{
				var nx:int = x + dirs[i].x;
				var ny:int = y + dirs[i].y;
				var val:int;
				if (nx >= 0 && nx < w && ny >= 0 && ny < h)
				{
					val = null;
				}
				else
				{
					val = Get(nx, ny);
				}
				_neighbours[i]= { x:nx, y:ny, val:val } ;				
			}
			return _neighbours;			
		}
		public function setBlock(x:int, y:int, w:int, h:int,val:int):void
		{
			for (var i:int = x; i < x+w; i++) 
			{
				for (var j:int = y; j < y+h; j++) 
				{
					if (i >= 0 && i < this.w && j >= 0 && j < this.h)
						Set(i, j, val);
				}
			}
		}
		public function clone():IntGrid
		{
			var gr:IntGrid = new IntGrid(w, h);
			for (var i:int = 0; i < w; i++) 
			{
				for (var j:int = 0; j < h; j++) 
				{
					gr.Set(i, j, Get(i, j));
				}
			}			
			return gr;
		}
	}

}