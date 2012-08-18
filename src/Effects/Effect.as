package Effects 
{
	import Creeps.Creep;
	import flash.filters.ConvolutionFilter;
	import net.flashpunk.FP;

	public class Effect
	{
		public var duration:Number = 0;
		public var timer:Number;
		public var type:String;
		public var oneShot:Boolean = false;
		public var source:String;
		
		public function Effect() 
		{
			
		}
		public function reset():void
		{
			//trace("resetting effect", type);
			timer = duration;
		}
		public function get over():Boolean
		{
			return timer <= 0;
		}
		public function get effectType():String
		{
			return type;
		}	
		public function get effectSource():String
		{
			return source;
		}	
		public function set effectSource(str:String):void
		{
			source = str;
		}		
		public function update():void
		{
			
			if (!over)
			{
				timer-=FP.elapsed;				
			}
		}
		public function clone():Effect
		{
			var ff:Effect = new Effect();
			ff.duration = duration;
			ff.type = type;
			ff.oneShot = oneShot;
			ff.source = source;
			return ff;
		}
		public function handleCreep(crp:Creep):void
		{
			//trace("applying effect");
			
			trace("need to override applyToCreep in effect");
			//return crp;
		}
	}

}