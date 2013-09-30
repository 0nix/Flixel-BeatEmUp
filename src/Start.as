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
		
		private function onStartGame(e:Event=null):void 
		{
			var fxe:FlixelEcosystem = new FlixelEcosystem(stage.stageWidth, stage.stageHeight,2);
			this.addChild(fxe);
		}
		
		private function onScriptLoader(e:Event):void 
		{
			Registry.generalScript = new XML(e.target.data);
			var pregameScript:XMLList = Registry.generalScript.pregame;
			//pre game script parser
			var plen:int = pregameScript.arg.length();
			for (var i:int = 0; i < plen; i++)
			{
				var t:String = pregameScript.arg[i].@type;
				switch(t)
				{
					case "pushLevel":
						if (Registry.levelExists(int(pregameScript.arg[i].@id)) != true)
						{
							Registry.pushLevelInfo(pregameScript.arg[i].@val,int(pregameScript.arg[i].@id));
						}
						break;
					case "drawDistance":
						Registry.drawDistance = int(pregameScript.arg[i].@val);
						break;
					default:
						this.dispatchEvent( new IOErrorEvent("TAG NOT RECOGNIZED",true,false,"Script tag wasn't recognized"));
						break;
				}
			}
			onStartGame();
		}
		
	}

}