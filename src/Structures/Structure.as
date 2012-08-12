package Structures 
{
	//import Grid.Array2D;
	//import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	//import net.flashpunk.utils.*;
	import Utils.UpgradeEntity;


	public class Structure extends UpgradeEntity
	{

		//public var snapsToGrid:Boolean = true;
		//coordinates on the grid
		public var gridPosX:int;
		public var gridPosY:int;
		//size on the grid
		public var gridSizeX:int=1;
		public var gridSizeY:int=1;
		//cost to place

		public var canBeSold:Boolean = false;
		
		
		public function Structure(g:GameInfo,gfx:String) 
		{			
			super(g);
			this.gfx = gfx;
			//img = new Image(A.gfx[gfx]);
			graphic = new Image(GI.gfx[gfx]);			
			type = "structure";			
			layer = G.layerStructures;
			canBeSold = false;
			snapsToGrid = true;
			
		}
		public function setPos(px:int, py:int):void
		{
			gridPosX = px;
			gridPosY = py;
			x = (gridPosX * G.size) + G.offsetX;
			y = (gridPosY * G.size) + G.offsetY;			
		}
		public function setSize(sx:int, sy:int):void
		{
			gridSizeX = sx;
			gridSizeY = sy;	
			//Image(graphic).scaleX = (G.size / Image(graphic).width) * gridSizeX;
			//Image(graphic).scaleY = (G.size / Image(graphic).height) * gridSizeY;			
			setHitbox(G.size * gridSizeX, G.size * gridSizeY);			
		}		
		
	}

}
