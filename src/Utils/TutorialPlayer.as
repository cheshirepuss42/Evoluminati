package Utils 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;
	import UI.Label;
	import net.flashpunk.FP;
	import net.flashpunk.utils.*;


	public class TutorialPlayer extends Label
	{
		private var panels:Vector.<*>=new Vector.<*>();
		public var currentPanel:int = 0;
		public var reachedEnd:Boolean = false;
		public function TutorialPlayer(g:GameInfo) 
		{
			GI = g;
			active = false;
		}

		public function addPanel(px:int, py:int, mess:String):void
		{
			panels.push( { x:px, y:py, content:mess } );
		}
		override public function update():void
		{
			if (Input.mousePressed)
			{				
				if (currentPanel == panels.length)
				{	
					reachedEnd = true;			
				}
				else
					showNextPanel();
			}
		}
		override public function render():void 
		{			
			super.render();
			if (!reachedEnd)
				Draw.circlePlus(x-G.halfSize, y-G.halfSize, G.halfSize, 0xff0000, 1, false, 3);			
		}
		public function hasContent():Boolean
		{
			return panels.length > 0;
		}
		public function start():void
		{			
			currentPanel = 0;
			if(panels.length>0)
				showNextPanel();
			else
				reachedEnd = true;
		}
		public function showNextPanel():void
		{
			var data:*= panels[currentPanel];
			focusOnGridPoint(data.x, data.y);
			setup(GI,data.content, FP.halfWidth + G.halfSize, FP.halfHeight + G.halfSize, 250, 120, 12);
			currentPanel++;					
		}
		
		private function focusOnGridPoint(nx:int, ny:int):void
		{
			//trace("positioning tutorial panel at", nx, ny);
			FP.camera.x = Math.floor((G.offsetX+(nx*G.size)+G.halfSize) - (FP.halfWidth));
			FP.camera.y = Math.floor((G.offsetY+(ny*G.size)+G.halfSize) - (FP.halfHeight));			
		}	
	}
}	
