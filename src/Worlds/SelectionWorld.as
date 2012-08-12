package Worlds 
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import UI.*;
	
	public class SelectionWorld extends WorldMenu
	{		
		public var infoBox:Label;		
		public var defaultText:String = "";
		public var controls:Vector.<Label>;
		private var hasInfoBox:Boolean;
		private var nt:Newsticker;
		public function SelectionWorld(g:GameInfo,hasInfoBox:Boolean=false) 
		{
			super(g);	
			this.hasInfoBox = hasInfoBox;
		}
		override public function begin():void
		{
			super.begin();
			nt = new Newsticker(0, 0, FP.width, 20);			
			add(nt);			
			var h:int = 150;
			var w:int = 300;
			if(hasInfoBox)
				infoBox=Label(create(Label)).setup(GI,defaultText, FP.halfWidth-(w/2), FP.height -(h+ 50), w, h);
			setupControls();			
		}
		override public function update():void
		{
			super.update();
			nt.scroll();
			if (hasInfoBox)
			{
				var button:Button = Button(collidePoint("button", mouseX, mouseY));
				if (button != null)
				{
					infoBox.text = button.infoTxt;
				}
				else
					infoBox.text = defaultText;	
			}
		}
		
		public function setupControls():void
		{
			controls = new Vector.<Label>();
		}
		override public function clean():void 
		{
			nt.clean();
			nt = null;
			if(hasInfoBox)
				recycle(infoBox);
			for (var i:int = 0; i < controls.length; i++) 
			{
				recycle(controls[i]);
			}			
			super.clean();
		}
	
	}

}