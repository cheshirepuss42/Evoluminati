package UI 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.*;
	/**
	 * Small progressbar for sticking on entities
	 */
	public class HealthBar extends Entity
	{
		private var sizeX:int;
		private var sizeY:int;
		private var bar:Image;
		private var padding:int = 1;
		public function HealthBar(sizeX:int,sizeY:int,col:uint=0xff0000) 
		{
			this.active = false;
			layer = G.layerStatusBars;
			setHitbox(sizeX, sizeY, 0, 0);
			addGraphic(Image.createRect(sizeX, sizeY, 0));
			
			bar = Image.createRect(sizeX - (padding * 2), sizeY - (padding * 2), col);
			bar.x += padding;
			bar.y += padding;
			var img:Image = Image.createRect(bar.width, bar.height, 0xffffff);
			img.x = bar.x;
			img.y = bar.y;
			addGraphic(img);
			addGraphic(bar);
			
			setFilled(1);
		}
		
		public function setFilled(am:Number=1):void
		{
			bar.scaleX = am;
		}
		public function setFilledY(am:Number=1):void
		{
			bar.scaleY = am;
		}		
		
	}

}