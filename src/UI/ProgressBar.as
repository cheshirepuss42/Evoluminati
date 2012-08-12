package UI 
{
	import net.flashpunk.Entity;
	//import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.*;

	public class ProgressBar extends Label
	{
		private var bar:Image;
		private var progressText:String = "";
		public function ProgressBar() 
		{

			//addGraphic(txt);
		}
		public function setupProgressBar(g:GameInfo,str:String,scrX:int,scrY:int, w:int, h:int, txtSize:int=15,barColor:uint=0xff0000):ProgressBar
		{
			progressText = str;
			super.setup(g,str, scrX, scrY, w, h, txtSize, 0xffff00, 0, 0.8, 2);
			bar = Image.createRect(width-(borderSize),height-(borderSize), barColor, 0.6);
			bar.x = borderSize;
			bar.y = borderSize;
			//glist.remove(txt);
			Graphiclist(graphic).children.splice(2,0,bar);
			//addGraphic(bar);	
			return this;
		}
		public function setFilled(am:Number,nr:int=-1000):void
		{
			if (nr != -1000)
			{
				txt.text = progressText + ": " + nr;
			}
			bar.scaleX = (am>1)?1:am;
		}
		
	}

}