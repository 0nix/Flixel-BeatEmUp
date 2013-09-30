package beat 
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import org.flixel.FlxPoint;
	import org.flixel.FlxTilemap;
	/**
	 * ...
	 * @author 
	 */
	public class Registry 
	{
		private static var levelCSV:Vector.<Object> = new Vector.<Object>();
		private static var levelID:Vector.<int> = new Vector.<int>();
		public static var player:Player;
		public static var hitGroup:HitGroup;
		public static var enemyGroup:EnemyGroup;
		public static var tilemap:FlxTilemap;
		public static var upperLimit:int = 0;
		public static var lowerLimit:int = 0;
		public static var drawDistance:int;
		public static var generalScript:XML;
		public static const TILESIZE:int = 8;
		public static function getLevel(level:int):String
		{
			if (levelID.indexOf(level) >= 0)
			{
				return levelCSV[levelID.indexOf(level)].data as String;
			}
			else 
			{
				return null;
			}
		}
		private static function urloader_complete(e:Event):void 
		{
			levelCSV.push(e.target);
		}
		public static function pushLevelInfo(url:String,index:int):void
		{
			levelID.push(index);
			var urlreq:URLRequest = new URLRequest(url);
			var urloader:URLLoader = new URLLoader(urlreq);
			urloader.addEventListener(Event.COMPLETE, urloader_complete);
		}
		public static function getLevelIdByIndex(index:int):int
		{
			return levelID[index];
		}
		public static function getLevelLength():int
		{
			return levelID.length;
		}
		public static function levelExists(levelid:int):Boolean
		{
			if (levelID.indexOf(levelid) >= 0)
				return true;
			else 
				return false;
		}
		public function Registry() 
		{
			
		}
		
	}

}