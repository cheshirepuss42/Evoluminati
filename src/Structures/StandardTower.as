package Structures 
{
	import Weapons.PeaShooter;

	public class StandardTower extends Tower
	{
		
		public function StandardTower(g:GameInfo) 
		{
			super(g,"StandardTower");
			setWeapon(new PeaShooter(GI,"tower"));
			//trace("setting weapon",weapon.weaponHolder);
			infoText= "Shoots standard bullets";
			properName = "Pea Shooter";	
			name = "StandardTower";
			energyCost = 100;
		}
		
	}

}