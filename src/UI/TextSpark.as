package UI 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	/**
	 * ...
	 * @author 
	 */
	public class TextSpark extends Entity
	{
		private var txt:Text;
		private var speed:Number;
		private var timeLeft:Number;
		public function TextSpark() 
		{
			
		}
		public function setup(x:int, y:int, text:String, col:uint = 0xffff00,size:Number=15, speed:Number = 2):TextSpark
		{
		
			this.speed = 10*speed;
			timeLeft = (1 / speed);
			txt = new Text(text);
			txt.size = size;
			txt.color = col;
			//txt.font = "Arial";
			txt.outlineColor = 0;
			txt.outlineStrength = 2;
			
			//txt.text = text;
			txt.updateTextBuffer();
			//txt.width = 100;
			//txt.height = 100;
			//width = 100;
			//height = 100;
			layer = G.layerStatusBars;
			graphic = txt;
			//trace("txt",txt.textWidth, txt.textHeight);
			this.x = x;
			this.y = y;
			txt.centerOrigin();
			return this;
		}
		override public function update():void 
		{
			super.update();
			txt.alpha -= 1.7 / ( (1/FP.elapsed));
			y -= speed * FP.elapsed*5;
			timeLeft -= FP.elapsed;
			if (timeLeft < 0)
			{
				FP.world.recycle(this);
				//TextSpark(FP.world.create(TextSpark)).setup(50,150,"+50",speed);
			}
			
		}
		
	}

}