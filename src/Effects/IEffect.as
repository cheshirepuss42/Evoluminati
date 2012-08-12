package Effects 
{
	import Creeps.Creep;

	public interface IEffect 
	{
		function handleCreep(crp:Creep):void
		function update():void
		//function reset():void
		function get over():Boolean
		function get effectType():String
		function get effectSource():String
		
		
	}
	
}