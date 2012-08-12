package Effects 
{
	import Creeps.Creep;
	import net.flashpunk.FP;
	
	public class DamageEffect extends Effect
	{
		protected var dmgAmount:int = 0;
		protected var damage:Number;
		public function DamageEffect(sourceType:String,damage:Number,seconds:Number=0) 
		{
			this.damage = damage;
			this.effectSource = sourceType;
			timer=duration = seconds;
			oneShot = duration <= 0;
			type = "damage";
		}
		override public function handleCreep(crp:Creep):void 
		{			
			var modifier:Number = (oneShot)?1:FP.elapsed;
			var upgradeModifier:Number = 1;
			switch (effectSource)
			{
				case "player":upgradeModifier = Stats.data.getStat("player_damage").modifier; break;
				case "tower":upgradeModifier = Stats.data.getStat("tower_damage").modifier;break;
				case "trap":break;
			}
			var dmg:Number = damage * upgradeModifier* modifier;
			crp.applyDamage(dmg);


		}
		override public function clone():Effect
		{
			return new DamageEffect(effectSource, damage, duration);
		}

		
	}

}