package  
{
	import flash.utils.Dictionary;
	import Grid.Array2D;
	import Structures.*;
	import Weapons.PeaShooter;
	
	//Here are the constants and help functions
	public class G 
	{		
		public static const layerBackground:int = 120;
		public static const layerGround:int = 110;		
		public static const layerGroundPoints:int = 100;
		public static const layerBlood:int = 90;
		public static const layerRangeView:int = 80;
		public static const layerAuras:int = 70;		
		public static const layerPickups:int = 60;
		public static const layerStructures:int = 50;
		public static const layerCreeps:int = 40;
		public static const layerPlayer:int = 30;
		public static const layerProjectiles:int = 20;
		public static const layerWeapons:int = 10;
		public static const layerStatusBars:int = 0;
		public static const layerOverlayMenu:int = -10;
		public static const layerCursor:int = -20;		

		//enum for mode
		public static const modeSelect:int = 0;
		public static const modeBuild:int = 1;
		public static const modeShoot:int = 2;
		public static const modeTeleport:int = 3;
		
		//menu size
		//public static const menuWidth:int = 200;
		public static const menuHeight:int = 70;
		
		//public static var maxEnergy:int = 500;
		
		//these determine the dimensions of the grid (amount of possible positions)
		public static var gridWidth:int = 23;
		public static var gridHeight:int = 19;
		
		//this determines the visual width and height of each grid-point
		public static const size:int = 32;
		public static const halfSize:int = size/2;
		public static const defaultRange:Number = size * 4;
		public static const defaultHealth:Number = 50;
		public static const defaultSpeed:Number = 50;
		public static const defaultAmbientRecharge:Number = 0.20;
		public static const creepDropStayTime:Number = 5;
		//this is the offset the grid has
		public static const offsetX:int = 0;
		public static const offsetY:int = 0;
		
		public static const GameTitle:String = "Evoluminati";

		public static var tickerPos:Number = 0;
		public static function updateGridWithStructure(grid:Array2D, ent:Structure, remove:Boolean):void
		{
			grid.setBlock(ent.gridPosX, ent.gridPosY, ent.gridSizeX, ent.gridSizeY, (remove)?0:1);
		}		
	}
}
