package Auras 
{
	
	import Effects.Effect;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;

	public class Aura extends Entity 
	{
		public var followsPlayer:Boolean = false;
		//public var turnedOn:Boolean = true;
		public var range:Number;
		public var effect:Effect;
		public var mod:Number;
		public var color:uint;
		public function Aura() 
		{
			type = "aura";
			layer = G.layerRangeView;
		}

		public function init(px:int,py:int,_range:Number,modifier:Number=1):void
		{
			mod = modifier;
			range = _range * G.defaultRange;
			setHitbox(range, range);
			
			x = px-range;
			y = py-range;
			graphic = Image.createCircle(range, color, 0.25);
			
		}
		
	}

}