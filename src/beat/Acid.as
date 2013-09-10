package beat 
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxTimer;
	/**
	 * ...
	 * @author 
	 */
	public class Acid extends FlxSprite 
	{
		private var _hurtsPlayer:Boolean;
		private var _timer:FlxTimer;
		private var _toDestroy:Boolean = false;
		public function Acid(X:Number=0, Y:Number=0,SimpleGraphic:Class=null) 
		{
			super(X, Y, SimpleGraphic);
		}
		public function init(timer:Number, width:int, height:int,x:Number = 0, y:Number = 0, hurtsPlayer:Boolean = false,visible:Boolean = true):void
		{
			this.x = x;
			this.y = y;
			this.makeGraphic(width, height, FlxG.PINK);
			_hurtsPlayer = hurtsPlayer;
			this.visible = visible;
			_timer = new FlxTimer();
			_timer.start(timer, 1, onTimer);
			
		}
		private function onTimer(Timer:FlxTimer):void
		{
			_toDestroy = true;
		}
		public function get hurtsPlayer():Boolean 
		{
			return _hurtsPlayer;
		}
		
		public function get toDestroy():Boolean 
		{
			return _toDestroy;
		}
		
		public function set toDestroy(value:Boolean):void 
		{
			_toDestroy = value;
		}
		
	}

}