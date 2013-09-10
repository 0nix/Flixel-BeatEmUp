package beat 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author 
	 */
	public class Registry 
	{
		private static var levels:Vector.<Object> = new Vector.<Object>();
		public static var level:int = 0;
		public static var player:Player;
		public static const TILESIZE:int = 8;
		public static function getCurrentLevel():String
		{
			return levels[level].data as String;
		}
		private static function urloader_complete(e:Event):void 
		{
			levels.push(e.target);
		}
		public static function pushLevelInfo(url:String):void
		{
			var urlreq:URLRequest = new URLRequest(url);
			var urloader:URLLoader = new URLLoader(urlreq);
			urloader.addEventListener(Event.COMPLETE, urloader_complete);
		}
		public function Registry() 
		{
			
		}
		
	}

}