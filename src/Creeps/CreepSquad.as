package Creeps 
{
	import flash.geom.Point;
	//import Grid.DistanceTable;
	//import Grid.DM;
	//import Worlds.Level;
	//import net.flashpunk.Entity;
	import net.flashpunk.FP;
	
	//this conrolls the behavior of creeps as a squad (entering with intervals)
	public class CreepSquad 
	{
		//the type of creep that will be spawned
		public var creepID:String;
		//amount of yet to be deployed creeps
		public var undeployed:int;
		//amount of update-calls between deployment of new creep
		public var interval:Number;
		//tracks the amount of update calls so far
		public var counter:Number;
		//the point where the new creep spawns
		public var entry:Point;
		//the point where a creep reaches its goal (and gets removed)
		public var exit:Point;
		//the grid where each node has the distance to the goal (so you can pick the lowest neighbour for travelling to goal
		public var level:int;
		public var GI:GameInfo;
		
		public function CreepSquad(g:GameInfo,entryPoint:Point,amount:int,distance:Number,creepID:String,level:int=1) 
		{
			GI = g;
			this.level = level;
			undeployed = amount;
			interval = distance;
			counter = 0;
			this.creepID = creepID;	
			entry = entryPoint;
		}
		
		public function update():void
		{
			counter+=FP.elapsed;
			//if an interval has passed and there are still creeps to be deployed
			if (counter > interval && undeployed > 0)
			{
				//reset counter
				counter = 0;
				
				//add new creep based on established type to flashpunk engine
				var creepType:Class = Object(GI.creeps[creepID]).constructor;
				Spawner(FP.world.create(Spawner)).init(GI,G.offsetX + (entry.x * G.size), 
															G.offsetY + (entry.y * G.size),creepType);
				undeployed--;
			}
		}
	}
}