package UI 
{
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;	
	import net.flashpunk.graphics.Graphiclist;

	public class Background extends Entity
	{
		public var moving:Boolean;
		public var GI:GameInfo;
		public function Background(g:GameInfo,moves:Boolean=true ) 
		{			
			GI = g;
			moving = moves;
		}
		override public function added():void
		{
			setupBGs();
			layer = G.layerBackground;
		}
		public function setupBGs(am:int = 3):void
		{
			for (var i:Number = 1; i <am; i++) 
			{
				var bg:Backdrop = new Backdrop(GI.gfx["stars"+(i).toString()], true, true);				
				bg.alpha =  0.9-( (i)/am);
				bg.scrollX = ((0.7 / am) * i);
				bg.scrollY =  ((0.7 / am) * i);
				bg.x += FP.random * bg.width;
				bg.y += FP.random * bg.height;
				this.addGraphic(bg);				
			}			
		}
		override public function update():void 
		{
			super.update();

		}
		override public function render():void
		{
			super.render();
			if (moving)
			{
				moveBG(0.5, 0.2);
			}	
			
		}
		public function moveBG(nx:Number, ny:Number):void
		{
			var glist:Graphiclist = Graphiclist(graphic);
			var l:int = Graphiclist(graphic).children.length;
			for (var i:int = 0; i < l; i++) 
			{
				glist.children[i].x += nx * (1.6 - Number(i / l));
				glist.children[i].y += ny * (1.6 - Number(i / l));	
				
			}			
		}
		override public function removed():void
		{
			super.removed();
			for (var i:int = 0; i < Graphiclist(graphic).children.length; i++) 
			{
				Graphiclist(graphic).children[i] = null;				
			}			
			graphic = null;
		}
		
	}

}