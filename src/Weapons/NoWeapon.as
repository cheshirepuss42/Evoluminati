package Weapons 
{
	/**
	 * ...
	 * @author 
	 */
	public class NoWeapon extends Weapon
	{
		
		public function NoWeapon(g:GameInfo) 
		{
			super(g,"");
			isOnCooldown = true;
			rangeView.visible = true;
		}
		override public function update():void
		{
			rangeView.setPos(centerX, centerY);
		}
		override public function fireAt(tX:int, tY:int):void
		{

		}		
	}

}