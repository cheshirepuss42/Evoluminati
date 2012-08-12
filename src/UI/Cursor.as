package UI
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.*;

	import Structures.*;
	import Weapons.*;
	import Worlds.Level;
	import Utils.UpgradeEntity;

	public class Cursor extends Entity
	{
		public var isBlocked:Boolean;
		public var cursorType:int;
		public var snapsToGrid:Boolean;
		public var gridSizeX:int;
		public var gridSizeY:int;	
		public var gridPosX:int;
		public var gridPosY:int;			
		public var className:Class;
		public var prevGridX:int;
		public var prevGridY:int;
		public var isOnNewGridPoint:Boolean;
		public var isOnSameGridPoint:Boolean;
		public var blocksPath:Boolean;
		public var energyCost:int;
		public var GI:GameInfo;
		
		public function Cursor(g:GameInfo) 
		{
			GI = g;
			blocksPath = false;
			layer = G.layerCursor;
			
		}
		override public function added():void
		{
			Level(world).setUpgrade(0);
		}
		override public function update():void
		{			
			var mod:int = (gridSizeX > 1 || gridSizeY > 1)?G.halfSize:0;
			prevGridX = gridPosX;
			prevGridY = gridPosY;
			gridPosX = int(((world.mouseX-mod) - G.offsetX) / G.size);
			gridPosY = int(((world.mouseY-mod) - G.offsetY) / G.size);
			
			if (!(prevGridX == gridPosX && prevGridY == gridPosY))
			{
				isOnNewGridPoint = true;
			
			}

			
			//set the cursor base on the mouse-position and handle gridsnap
			if (snapsToGrid)
			{
				//graphic.x = -G.halfSize;
				//graphic.y = -G.halfSize;
				x = G.offsetX + (gridPosX * G.size);					
				y = G.offsetY + (gridPosY * G.size);
			}			
			else
			{
				x = world.mouseX;
				y = world.mouseY;
			}			
			//tint the cursor-image if it is blocked
			if (isBlocked)
			{
				Image(graphic).color = 0;
				Image(graphic).tinting = 0.8;
			}
			else
			{
				Image(graphic).color = 0;
				Image(graphic).tinting = 0.2;				
			}				
		}
		public function set alpha(a:Number):void
		{
			Image(graphic).alpha = a;
		}
		public function updateCursor(deployable:String):void
		{
			//set cursor to selected upgrade
			//var classname:Class = upgrade.getClass();
			var upgrade:UpgradeEntity = GI.upgrades[deployable];
			///trace("upgrade",upgrade.energyCost);
			energyCost = upgrade.energyCost;
			snapsToGrid = upgrade.snapsToGrid;
			
			var img:Image;
			if (upgrade.type == "structure")
			{
				//Level(world).playMode = G.modeBuild;
				//var str:Structure = Structure(upgrade);
				prevGridX=gridSizeX = Structure(upgrade).gridSizeX;
				prevGridY = gridSizeY = Structure(upgrade).gridSizeY;
				//trace(gridSizeX, gridSizeY, upgrade.getClass());
				img = new Image(GI.gfx[upgrade.gfx]);
				//img.scale = (G.size*gridSizeX) / img.width;
				className = upgrade.getClass();
				setHitbox(G.size * gridSizeX, G.size * gridSizeY);
				isOnNewGridPoint = false;
			}
			if (upgrade.type == "weapon")
			{
				//Level(world).playMode = G.modeShoot;
				gridSizeX = 1;
				gridSizeY = 1;	
				img = new Image(GI.gfx[Weapon(upgrade).cursorGfx]);				
				img.relative = true;
				img.x -= G.halfSize;
				img.y -= G.halfSize;
				setHitbox(G.size, G.size, G.halfSize , G.halfSize );
			}
			img.scaleX = (G.size * gridSizeX) / img.width;
			img.scaleY = (G.size * gridSizeY) / img.height;
			graphic = img;
		}
		//changes cursor view and behavior to building
		//public function setCursorToStructure(strType:Class):void
		//{
			//Level(world).playMode = G.modeBuild;
			//var str:Structure = new strType();
			//strType(str).init(0, 0);
			//energyCost = str.energyCost;
			//snapsToGrid = str.snapsToGrid;			
			//prevGridX=gridSizeX = str.gridSizeX;
			//prevGridY=gridSizeY = str.gridSizeY;
			//graphic = str.graphic;
			//className = strType;
			//setHitbox(G.size * gridSizeX, G.size * gridSizeY);
			//isOnNewGridPoint = false;			
		//}
		//public function setCursorToBasicWall():void
		//{
			//setCursorToStructure(BasicWall);
		//}
		//public function setCursorToTower():void
		//{
			//setCursorToStructure(Tower);
		//}		
		//changes cursor view and behavior to shooting
		//public function setCursorToShoot():void
		//{			
			//Level(world).playMode = G.modeShoot;
			//energyCost = 1;
			//gridSizeX = 1;
			//gridSizeY = 1;
			//snapsToGrid = false;
			//var img:Image = new Image(A.gfx["cursor_gun_01"]);
			//img.scale = G.size / img.width;
			//graphic = img;
			//graphic.relative = true;	
			//graphic.x -= G.halfSize;
			//graphic.y -= G.halfSize;
			//setHitbox(G.size, G.size, G.halfSize , G.halfSize );
		//}	
	}
}