package UI 
{
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Tilemap;
	public class Label extends Entity
	{
		
		public var txt:Text;
		//protected var bg:Image;
		//protected var border:Image;
		//protected var glist:Graphiclist;
		public var scrX:int;
		public var scrY:int;
		public var borderSize:int;
		private var slideX:Number;
		private var slideY:Number;
		private var timer:Number;
		private var bg:Tilemap;
		public var defaultColor:uint;
		public var GI:GameInfo;
		public function Label() 				
		{

			
		}
		public function setup(g:GameInfo,str:String,scrX:int,scrY:int, w:int, h:int, txtSize:int=15,txtColor:uint = 0xffffff, bgColor:uint = 0x444444, bgAlpha:Number = 0.95, borderSize:int = 2):Label
		{
			GI = g;
			type = "label";
			this.borderSize = borderSize;
			this.scrX = scrX;
			this.scrY = scrY;
			txt = new Text("");
			txt.size = txtSize;
			setHitbox(w, h);
			var border:Image = Image.createRect(width + borderSize, height + borderSize, 0xffffff, bgAlpha/4);
			//border.x -= 1;
			//border.y -= 1;
			var bmd:BitmapData = new BitmapData(width, 1, true, 0);
			var img:Image = new Image(GI.gfx["labelgradient"]);
			img.alpha = bgAlpha;
			img.color =defaultColor= bgColor;
			img.scaleX = width / 64;
			//img.angle =180;
			img.centerOrigin();
			img.x += (width / 2);
			img.render(bmd, FP.zero, FP.zero);
			bg = new Tilemap(bmd, width, height, width, 1);
			//bg.color = defaultColor = 0xffff00;
			
			bg.setRect(0, 0, 1, height);
			//var bg:Image = Image.createRect(w - (borderSize * 2), h - (borderSize * 2), bgColor, bgAlpha);
			bg.x = bg.y = borderSize;
			txt.color = txtColor;
			txt.width = bg.width;
			txt.height = bg.height;
			txt.align = "center";	
			txt.wordWrap = true;
			txt.y = (bg.height / 2) - (txt.textHeight / 2);
			if (graphic != null)
				Graphiclist(graphic).removeAll();
			addGraphic(border);
			addGraphic(bg);
			addGraphic(txt);
			//glist = new Graphiclist(border, bg, txt);
			//graphic = glist;
			layer = G.layerOverlayMenu;
			text = str;
			return this;
		}
		override public function render():void
		{
			if (timer > 0)
			{
				//trace("sliding",scrX,scrY,slideX,slideY);
				
				scrX += slideX * FP.elapsed;
				scrY += slideY * FP.elapsed;
				timer -= FP.elapsed;
			}			
			x = world.camera.x + scrX;
			y = world.camera.y + scrY;
			super.render();
		}

		override public function removed():void
		{

			//super.removed();
			//Graphiclist(graphic).removeAll();// = null;
			graphic = null;
			txt = null;
			bg = null;

		}
		public function slideTo(difX:int, difY:int, time:Number):void
		{
			slideX = difX/time;
			slideY = difY/time;
			timer = time;
		}
		public function slideFromTo(nx:int, ny:int, difX:int, difY:int, time:Number):void
		{
			scrX = nx;
			scrY = ny;
			slideTo(difX, difY, time);
		}
		public function set text(str:String):void
		{
			//txt.clear();
			txt.text = str;
			txt.y = halfHeight - (txt.textHeight / 2);
		}
		public function get text():String
		{
			
			return txt.text;
		}
	}

}