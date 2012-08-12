package Structures 
{
	import Weapons.FreezeGun;
	/**
	 * ...
	 * @author 
	 */
	public class ColdTower extends Tower
	{
		
		public function ColdTower(g:GameInfo) 
		{
			super(g,"ColdTower");
			setWeapon(new FreezeGun(GI,"tower"));
			//this.weapon.weaponHolder ="tower" ;
			infoText = "freezing tower";
			properName = "Freezer";
			weapon.rangeView.setColor(0x0000ff);
			name = "ColdTower";
			energyCost = 150;
		}
		
	}

}