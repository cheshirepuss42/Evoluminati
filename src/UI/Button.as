package UI 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.*;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	
	public class Button extends Label
	{
		public var callback:Function;		
		public var infoTxt:String;
		public var showTxt:Boolean = false;
		public var isActive:Boolean = true;
		
		public function Button()		
		{

		}
		public function setupButton(g:GameInfo,txt:String, nx:int, ny:int, w:int, h:int, callback:Function, infoTxt:String = "", fontSize:int=14,greyedOut:Boolean=false):Button
		{
			super.setup(g,txt, nx, ny, w, h, fontSize)
			sleeps = false;
			isActive = true;
			type = "button";			
			this.callback = callback;
			
			this.infoTxt = infoTxt;	
			showTxt = false;
			//this.active = false;
			//sleeps = !isActive;
			//FP.alarm(20, delayActivation);
			return this;
			
		}
		private function delayActivation():void
		{
			this.active = true;
			sleeps = !isActive;
		}
		public function set sleeps(sleep:Boolean):void
		{
			active = !sleep;

			greyedOut=sleep;
		}		
		public function set greyedOut(on:Boolean):void
		{
			var imgs:Vector.<Graphic> = Graphiclist(graphic).children;
			for (var i:int = 0; i < imgs.length; i++) 
			{
				if (!(imgs[i] is Tilemap))
				{
					if (on)
					{
						Image(imgs[i]).tinting = 0.4;
						Image(imgs[i]).color = 0xff0000;
					}
					else
					{
						Image(imgs[i]).tinting = 0;
						Image(imgs[i]).color =0xFFFFFF;
					}
				}			
				else
				{
					Tilemap(imgs[i]).color = (on)?0xff0000:defaultColor;					
				}
			}			
		}
		public override function update():void
		{			
			
			showTxt = false;
			if (active && collidePoint(x, y, world.mouseX, world.mouseY))
			{	
				//trace(infoTxt);
				showTxt = true;
				//trace("updating menubutton", infoTxt);
				if ( Input.mousePressed && callback != null && active)
				{
					//trace(active, collidable, this.type);
					onClick();
					callback();
				}
				//set flag for showing the infotxt
				
			}
			
		}
		public function onClick():void
		{
			GI.sfx["menu_select_01"].play();			
		}
		override public function removed():void 
		{
			super.removed();
			callback = null;
		}
	}

}