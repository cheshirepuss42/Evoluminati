package UI 
{
	import flash.geom.Rectangle;
import net.flashpunk.Entity;
import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.masks.Pixelmask;
	/**
	 * ...
	 * @author 
	 */
	public class Newsticker extends Entity
	{
		private var text:String;
		private var text2:String;
		private var text3:String;
		private var scrollers:Vector.<Text> = new Vector.<Text>();
		private var amscrollers:int;
		private var currentScroller:int = 0;
		private var completeLength:int = 0;
		//private var rect:Rectangle;
		//private var frame:Pixelmask
		public function Newsticker(x:int,y:int,w:int,h:int) 
		{
			var breaktxt:String = "...               ";       
			text = "science: commision finds evolution-stop unrelated to GloboChem FamilyFood"+breaktxt;
			text += "politics: known nopter ridicules complex 12 year deadlock"+breaktxt;			
			text += "sports: illicit lunar pole vaulting accident: 3 missing, presumed dead"+breaktxt;
			text += "safety: 1 in 4 nopters found on tpl (terrorpreventionlist). police advises care"+breaktxt;
			text += "sports: Annualympics Bloodsport Week now in 4D on NetNix"+breaktxt;
			text += "family: are glass windows killing your loved ones? read 'safe' and find out about alternatives"+breaktxt;
			text += "suggestion: find opportunities at GloboChem. Globochem: it rules!"+breaktxt;
			text += "tech: opt-ups will be shorter, less recovery needed" + breaktxt;
			
			text3 = "safety: how not to get on the tpl. ask local peaceforce for personal advice"+breaktxt;
			text3 += "politics: UN-scandal costs Italy Annualympics"+breaktxt;
			text3 += "health: after 'twister'-scandal, surrogate-pregnancies no longer covered by GloboSure"+breaktxt;
			text3 += "science: biolab patents now exceed extinction rate"+breaktxt;
			
			text2 = "error: @#%@d3sd_0x00$93" + breaktxt;
			text2 += "svrrsp: .-.---.-.--.-.----.-.-.----.--..-.--.." + breaktxt;
			text2 += "log: 09:34.245153332.390.[p,2,f]" + breaktxt;
			text2 += "..ed four new fue.%.njectors bef.re..#xt w.e..." + breaktxt;
			text2 += "..t.rn t..d.conta%.na.io###ham.er, ou.br.ak im.ine#t.. " + breaktxt;
			text2 += "let.tt.rr.wetnee#fij%p aokw.jmowppfkp$$$$x$$$$. " + breaktxt;
			
			//todo: fix newsticker shit
			
			
			var result:String = text + text3 + text2;
			var splitpoint:int = 100;
			this.x = x;
			this.y = y;
			
			do 
			{
				var subresult:String = result.substr(0, splitpoint);
				result = result.substr(splitpoint, result.length - splitpoint);
				
				var txt:Text = new Text(subresult);				
				txt.size = 16;
				txt.color = 0xff0000;
				
				//txt.clipRect.x = 0;// G.tickerPos - w;
				txt.updateBuffer(true);
				completeLength += txt.textWidth;
				txt.x = completeLength;
				//trace(completeLength);
				//txt.clipRect.width = txt.textWidth;
				scrollers.push(txt);
				addGraphic(txt);
			}
			while(result.length>splitpoint)
			amscrollers = scrollers.length;
			
			//hier zet ik ze allemaal op een rij

			layer = G.layerOverlayMenu;		
		}
		public function scroll():void
		{
			//hier laat ik ze allemaal scrollen
			for (var i:int = 0; i < amscrollers; i++) 
			{
				scrollers[i].x -= 1.5;
				//scrollers[i].updateBuffer(true);
				if (scrollers[i].x < FP.width && scrollers[i].x+ scrollers[i].textWidth >0)
				{
					scrollers[i].visible = true;
				}
				else
				{
					scrollers[i].visible = false;
				}
				if (i == amscrollers - 1&& scrollers[i].x+ scrollers[i].textWidth <0)
				{
					for (var j:int = 0; j < amscrollers; j++) 
					{
						scrollers[i].x += completeLength;
					}
				}
			}			
		}	
		public function clean():void
		{
			for (var i:int = 0; i < amscrollers; i++) 
			{
				scrollers[i] = null;
			}
			//currentScroller = null;
			scrollers = null;
		}
	}
}
