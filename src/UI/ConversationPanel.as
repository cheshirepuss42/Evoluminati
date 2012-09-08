package UI 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.*;
	import net.flashpunk.FP;

	public class ConversationPanel extends Label
	{
		public var img:Image;
		public var side:int;
		private var nameLabel:Text;

		
		public function ConversationPanel() 				
		{	
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