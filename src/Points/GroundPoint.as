package Points 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	public class GroundPoint extends Entity
	{
		public var GI:GameInfo;
		public function GroundPoint() 		
		{			
			type = "groundpoint";		
			layer = G.layerGroundPoints;
			setHitbox(G.size, G.size);			
		}
		
		public function _init(g:GameInfo,gfx:String,grX:int,grY:int,color:uint=0x0000ff):GroundPoint
		{
			GI = g;
			x = G.offsetX + (grX * G.size);
			y = G.offsetY + (grY * G.size);			
			graphic = (gfx == "")?Image.createCircle(G.halfSize, color, 0.8):new Image(GI.gfx[gfx]);			
			return this;
		}		
	}

}