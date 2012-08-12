package Points 
{
	import net.flashpunk.graphics.Spritemap;

	public class RechargePoint extends GroundPoint
	{
		private var sprRecharge:Spritemap;
		public function RechargePoint() 
		{
			type = "rechargepoint";

		}
		public function init(g:GameInfo,gfx:String, grX:int, grY:int, color:uint = 0x0000ff):RechargePoint 
		{
			super._init(g,gfx, grX, grY, color);
			sprRecharge = new Spritemap(GI.gfx["rechargepoint_02"], G.size, G.size);
			sprRecharge.add("flash", [0, 1, 2, 3,2,1], 0.2, true);
			graphic = sprRecharge;
			return this;
		}
		public function flash():void
		{
			sprRecharge.play("flash");
		}
		public function stopFlash():void
		{
			sprRecharge.setFrame();
		}
		
	}

}