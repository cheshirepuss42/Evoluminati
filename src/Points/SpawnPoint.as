package Points 
{
	/**
	 * ...
	 * @author 
	 */
	import net.flashpunk.graphics.Spritemap;
	public class SpawnPoint extends GroundPoint	
	{
		private var sprRecharge:Spritemap;
		public function SpawnPoint() 
		{
			type = "spawnpoint";

		}
		public function init(g:GameInfo,gfx:String, grX:int, grY:int, color:uint = 0x0000ff):SpawnPoint 
		{
			super._init(g,gfx, grX, grY, color);
			sprRecharge = new Spritemap(GI.gfx["Entrance"], G.size, G.size);
			sprRecharge.add("flash", [0, 1, 2, 3,2,1], 0.1, true);
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