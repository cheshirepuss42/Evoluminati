package UI 
{
	import net.flashpunk.FP;
	
	public class MessagePanel extends Label
	{
		//private var showing:Boolean = false;
		public var padding:int;
		public function MessagePanel() 
		{
			

			
		}
		public function setupMessagePanel(g:GameInfo,txt:String,img:String=""):void 
		{
			padding = 50;
			super.setup(g, txt, padding, padding, FP.width - (padding * 2), (FP.halfHeight/1.5) - (padding * 2), 20);
			//optional image in top center
			//text underneath			
		}
		override public function slideFromTo(nx:int, ny:int, difX:int, difY:int, time:Number):void 
		{
			super.slideFromTo(nx, ny, difX, difY, time);
		}
		
	}

}