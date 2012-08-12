package UI 
{
	import net.flashpunk.graphics.Image;

	public class ImageButton extends Button
	{
		protected var image:Image;
		private var padding:int = 20;
		public function ImageButton() 
		{

		}
		public function setupImageButton(g:GameInfo,txt:String, nx:int, ny:int, w:int, h:int, callback:Function, infoTxt:String, buttonImage:Image=null):ImageButton
		{
			super.setupButton(g,txt, nx, ny, w, h, callback, infoTxt);
			this.txt.size = 11;
			if (buttonImage != null)
			{
				image = buttonImage;
				image.scale = (w - padding) / image.width;
				addGraphic(image);
				image.x = halfWidth - (image.scaledWidth / 2);
				image.y = padding / 4;			
			}
			this.txt.y = int(height - this.txt.textHeight);
			this.txt.x = int(halfWidth - (this.txt.width / 2));		
			return this;
		}
		override public function removed():void 
		{
			super.removed();
			//image.clear();//
			image= null;
		}
		
	}

}