package UI 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;
	import net.flashpunk.FP;

	public class ConversationPanel extends Label
	{
		public var img:Image;
		public var side:int;
		//protected var txt:Text;
		private var nameLabel:Text;
		//protected var bg:Image;
		//protected var border:Image;
		//
		//public var scrX:int;
		//public var scrY:int;
		//private var padding:int = 10;
		//private var borderSize:int = 4;
		//private var slideX:Number;
		//private var slideY:Number;
		//private var timer:Number;
		
		public function ConversationPanel() 				
		{			
			//type = "conversationpanel";
			//var char:*= A.characters[character];
			//img = new Image(A.gfx[String(char.pic)]);
			//txt = new Text("");
			//txt.size = 22;
			//var txtWidth:int = 350;
			//setHitbox(img.width + (borderSize * 2) + (padding * 3) + txtWidth, img.height + (padding * 2) + (borderSize * 2));			
			//border = Image.createRect(width, height, 0xffff00, 0.7);
			//bg = Image.createRect(width - (borderSize * 2), height - (borderSize * 2), 0, 0.7);
			//bg.x = bg.y = borderSize;
			//img.x = bg.x + padding;
			//img.y = bg.y + padding;
			//txt.x = bg.x + (padding * 2) + img.width;
			//txt.y = bg.y + padding;
//
			//
			//txt.height = bg.height - (2 * padding);
//
			//txt.text = text;			
			//
			//graphic =  new Graphiclist(border, bg, txt,img);
			//layer = G.layerCursor;
			//this.scrX = 0;
			//this.scrY = 100;	
			
		}
		public function setupPanel(g:GameInfo,character:String, text:String, left:Boolean):ConversationPanel
		{
			var padding:int = 10;
			type = "conversationpanel";
			var txtWidth:int = 350;			
			var char:*= g.characters[character];
			img = new Image(g.gfx[String(char.pic)]);
			var w:int = img.width + (borderSize * 2) + (padding * 3) + txtWidth;
			var h:int = img.height + (padding * 2) + (borderSize * 2);
						
			super.setup(g,text, 0, 100, w, h, 15);
			
			Graphiclist(graphic).add(img);
			txt.width = txtWidth;
			img.x = borderSize + padding;
			img.y = borderSize + padding;
			txt.x = borderSize + (padding * 2) + img.width;
			txt.y = borderSize + padding			
			if (!left)
			{
				txt.x = borderSize + padding;
				img.x = txt.x + txt.width + padding;
				scrX = FP.width - w;
			}			
			return this;
		}
		
	}

}