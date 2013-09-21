package  
{
	import beat.FlixelEcosystem;
	import beat.ScriptEntry;
	import beat.Registry;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	/**
	 * ...
	 * @author 
	 */
	[SWF(width = "320", height = "240", backgroundColor = "#DDDDDD")]
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
			this.addEventListener("START_GAME", onStartGame);
			var scriptLoader:URLLoader = new URLLoader(new URLRequest("../lib/script.xml"));
			scriptLoader.addEventListener(Event.COMPLETE, onScriptLoader);
			scriptLoader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			this.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
		}
		
		private function onIOError(e:IOErrorEvent):void 
		{
			trace(e.text);
		}
		
		private function onStartGame(e:Event):void 
		{
			var fxe:FlixelEcosystem = new FlixelEcosystem(stage.stageWidth, stage.stageHeight,2);
			this.addChild(fxe);
		}
		
		private function onScriptLoader(e:Event):void 
		{
			var script:XML = new XML(e.target.data);
			Registry.ingame = new Vector.<ScriptEntry>();
			Registry.pregame = script.pregame;
			var ilen:int = script.ingame.sprite.length();
			for (var j:int = 0; j < ilen; j++)
			{
				Registry.ingame.push(new ScriptEntry(script.ingame.sprite[j].@type, int(script.ingame.sprite[j].@x), int(script.ingame.sprite[j].@y)));
			}
			var plen:int = Registry.pregame.arg.length();
			for (var i:int = 0; i < plen; i++)
			{
				var t:String = Registry.pregame.arg[i].@type;
				switch(t)
				{
					case "pushLevel":
						Registry.pushLevelInfo(Registry.pregame.arg[i].@val);
						break;
					case "upperLimit":
						Registry.upperLimit = int(Registry.pregame.arg[i].@val);
						break;
					case "lowerLimit":
						Registry.lowerLimit = int(Registry.pregame.arg[i].@val);
						break;
					case "drawDistance":
						Registry.drawDistance = int(Registry.pregame.arg[i].@val);
						break;
					case "start":
						this.dispatchEvent( new Event("START_GAME"));
						break;
					default:
						this.dispatchEvent( new IOErrorEvent("TAG NOT RECOGNIZED",true,false,"Script tag wasn't recognized"));
						break;
				}
			}
		}
		
	}

}