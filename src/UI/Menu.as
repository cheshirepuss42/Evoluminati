package UI 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.*;
	import Worlds.Level;
	import Utils.UpgradeEntity;
	import net.flashpunk.FP;

	public class Menu extends Entity
	{
		public var GI:GameInfo;
		public var waveTimer:ProgressBar;
		public var shieldStatus:ProgressBar;
		public var energyStatus:ProgressBar;
		private var info:Label;

		private var buttons:Vector.<MenuButton>;
		private var buttonWidth:int;
		private var buttonHeight:int;
		private var upgrades:Vector.<UpgradeEntity>;
		
		public function Menu(g:GameInfo,upgrades:Vector.<UpgradeEntity>) 
		{
			GI = g;
			this.upgrades = upgrades;			
		}

		private function setupButtons():void
		{
			var w:int = 60;
			var h:int = 40;
			var amx:int = 5;
			var amy:int = 2;
			var pad:int=3;
			var totalw:int = (amx * w) + (pad * (amx - 1));
			var totalh:int = (amy * h) + (pad * (amy - 1));
			var offsetx:int = FP.halfWidth - (totalw / 2);			
			var offsety:int = FP.halfHeight - (totalh / 2);			
			buttons = new Vector.<MenuButton>();
			for (var i:int = 0; i < upgrades.length; i++) 
			{
				var ib:MenuButton = new MenuButton().setupMenuButton(GI, upgrades[i].properName, offsetx + ((i % amx) * (w + pad)), offsety + ((int(i / amx) % amy) * (h + pad)), w, h, upgrades[i], i);				
				buttons.push(ib);
				world.add(buttons[i]);
			}		
			showButtons(false);
		}
		
		public function showButtons(vis:Boolean):void		
		{			
			for (var i:int = 0; i < buttons.length; i++) 
			{
				buttons[i].visible = vis;
				buttons[i].active = vis;
			}
		}

		public function setInfo(str:String):void
		{
			info.text = str;			
		}
		override public function render():void
		{			
			x = world.camera.x;
			y = world.camera.y + FP.screen.height - G.menuHeight;
			super.render();
		}
		override public function added():void
		{
			//graphic = Image.createRect(FP.width, G.menuHeight, 0xffffff, 0.2);
			setupHUD();
			setupButtons();
			
		}
		private function setupHUD():void 
		{
			var barHeight:int = 25;
			var menuHeight:int = barHeight * 3;
			layer = G.layerOverlayMenu;
			type = "menu";
			setHitbox(FP.width, menuHeight);
			x = int(world.camera.x);
			y = int(world.camera.y + (FP.height - menuHeight));
			info = new Label().setup(GI,"Info:\n", 0, (FP.height - menuHeight), 200, menuHeight,14);
			waveTimer = new ProgressBar().setupProgressBar(GI,"new wave", 200, FP.height-barHeight , FP.width-info.width, barHeight,18);			
			shieldStatus = new ProgressBar().setupProgressBar(GI,"shield", info.width, FP.height - (barHeight * 2), FP.width - info.width, barHeight, 18, 0x4444ff);
			shieldStatus.setFilled(1, GI.currentLevelData.maxCreeps);
			energyStatus = new ProgressBar().setupProgressBar(GI,"energy", info.width, FP.height - (barHeight * 3), FP.width - info.width, barHeight, 18,0xccffcc);
			world.add(waveTimer);
			world.add(shieldStatus);
			world.add(energyStatus);
			world.add(info); 			
		}
		override public function removed():void
		{
			super.removed();
			world.remove(waveTimer);
			world.remove(shieldStatus);
			world.remove(energyStatus);
			world.remove(info);
			for (var i:int = 0; i < buttons.length; i++) 
			{
				world.remove(buttons[i]);
			}
			buttons.splice(0, buttons.length);
		}
	}
}