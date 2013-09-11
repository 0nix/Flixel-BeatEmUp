package  
{
	import beat.FlixelEcosystem;
	import beat.Registry;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	[SWF(width = "320", height="240", backgroundColor="#DDDDDD")]
	public class Start extends Sprite 
	{
		
		public function Start() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAdded);
		}
		
		private function onAdded(e:Event):void 
		{
			this.removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			Registry.pushLevelInfo("../lib/level.csv");
			var fxe:FlixelEcosystem = new FlixelEcosystem(stage.stageWidth, stage.stageHeight,2);
			this.addChild(fxe);
		}
		
	}

}