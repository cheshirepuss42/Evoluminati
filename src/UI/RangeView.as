package UI 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;	
	import net.flashpunk.utils.*;	
	import flash.display.BitmapData;

	public class RangeView extends Entity
	{
		private var range:Number;
		private var outline:Image;
		private var img:Image;
		private var col:uint;
		private var alpha:Number;
		
		public function RangeView(cX:int,cY:int,range:Number,color:uint,alpha:Number=0.1) 
		{
			layer = G.layerRangeView
			setPos(cX, cY);	
			col = color;
			this.alpha = alpha;
			setRange(range)
			
		}
		public function setColor(col:uint):void
		{
			img.color = col;
		}
		public function setAlpha(alpha:Number):void
		{
			img.alpha = alpha;
		}
		public function setPos(cx:int, cy:int):void
		{
			x = cx - range;
			y = cy - range;
		}
		public function setRange(rng:Number):void
		{			
			range = rng;
			var bitmapData:BitmapData = new BitmapData(range*2,range*2, true,0);
			graphic = null;
			Draw.setTarget(bitmapData);
			Draw.circlePlus(centerX +range, centerY+range, range, 0xffffff, 0.5, false, 1);
			Draw.resetTarget();
			outline = new Image(bitmapData);
			img = Image.createCircle(range, col, alpha);
			addGraphic(outline);
			addGraphic(img);
		}		
	}
}

