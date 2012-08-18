package UI 
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import Worlds.*;	
	import Utils.*;

	public class MenuButton extends ImageButton
	{
		
		private var upgrade:UpgradeEntity;
		private var upgradenr:int;
		private var selected:Boolean;
		
		public function MenuButton() 
		{

			//targetMap = map;
		}
		public function setupMenuButton(g:GameInfo,txt:String, nx:int, ny:int, w:int, h:int, upgrade:UpgradeEntity, upnr:int):MenuButton
		{
			upgradenr = upnr;
			this.upgrade = upgrade;
			//this.txt.size = 9;
			super.setupImageButton(g,txt, nx, ny, w, h, null, upgrade.getInfo(),  new Image(g.gfx[upgrade.gfx]));
			image.scale = (h / 2) / image.height;
			image.x = (w / 2)- (image.scaledWidth / 2);
			this.txt.size = 9;	
			this.txt.y = h - this.txt.textHeight;
			selected = false;
			return this;
		}
		public override function update():void
		{
			if (collidePoint(x, y, world.mouseX, world.mouseY))
			{	
				Level(world).menu.setInfo(upgrade.getInfo());// setUpgrade(upgradenr);
				if ( Input.mousePressed )
				{	
					Level(world).setUpgrade(upgradenr);
					
				}
			}	
			super.update();
		}
		
	}

}