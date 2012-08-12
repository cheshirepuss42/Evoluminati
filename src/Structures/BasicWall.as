package Structures 
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Tilemap;
	public class BasicWall extends Structure 
	{
		private var tiles:Tilemap;
		public function BasicWall(g:GameInfo) 
		{
			super(g,"BasicWall");
			energyCost = 10;
			name = "BasicWall";
			infoText= "A sturdy wall";
			properName = "BasicWall";
			setSize(1, 1);
		}
		public function setPosAndSize(px:int, py:int, sx:int, sy:int):BasicWall
		{
			tiles = new Tilemap(GI.gfx["BasicWall"], sx * G.size, sy * G.size, G.size, G.size);
			graphic = tiles;
			tiles.setRect(0, 0, sx, sy);
			setPos(px, py);
			setSize(sx, sy);
			return this;
		}

		
	}
}