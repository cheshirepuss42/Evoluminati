package Utils 
{
	//import flash.events.TimerEvent;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;

	public class Ground extends Entity
	{
		private var _tiles:Tilemap;
		private var bloodLayer:Canvas;
		public function Ground(GI:GameInfo) 
		{
			_tiles = new Tilemap(GI.gfx["floortilesheet"], G.gridWidth*G.size, G.gridHeight*G.size, 32, 32);
			//trace(_tiles.rows, _tiles.columns);
			_tiles.alpha = 0.3;
			
			bloodLayer = new Canvas(G.gridWidth * G.size, G.gridHeight * G.size);// , 0, 0);
			
			addGraphic(_tiles);
			addGraphic(bloodLayer);
			//graphic = _tiles;
			var tileset:int = (FP.random * 4);
			layer = G.layerGround;
			_tiles.setRect(0, 0, G.gridWidth, G.gridHeight, (tileset*4));
			for (var i:int = 0; i < G.gridWidth*G.gridHeight; i++) 
			{
				_tiles.setTile(int(FP.random*G.gridWidth), int(FP.random*G.gridHeight),(tileset*4)+ int(FP.random*4));
			}
			//_tiles.setTile(4, 4, 8);
			x = G.offsetX;
			y = G.offsetY;
			
		}
		public function makeStain(grx:int, gry:int):void
		{
			var am:int = 3 + FP.random * 7;
			for (var i:int = 0; i <am; i++) 
			{
				var blood:Image = Image.createCircle(1+FP.random*3, 0xff0000,0.3+(FP.random*0.35));
				//bloodLayer
				var nx:int = (grx - G.halfSize) + (FP.random * G.size);
				var ny:int = (gry - G.halfSize) + (FP.random * G.size);
				bloodLayer.drawGraphic(nx, ny, blood);				
			}

		}
		
	}

}