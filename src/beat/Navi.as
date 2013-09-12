package beat 
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxPath;
	/**
	 * ...
	 * @author 
	 */
	public class Navi extends FlxSprite 
	{
		private var _pathVelocity:Number;
		private var _isFollowingPath:Boolean;
		public function Navi(X:Number=0, Y:Number=0, pathVelocity:Number = 35) 
		{
			super(X, Y,null);
			this.makeGraphic(5, 5, FlxG.GREEN);
			_pathVelocity = pathVelocity;
		}
		public function startFollow(point:FlxPoint):void
		{
			if (!_isFollowingPath)
			{
				var path:FlxPath = Registry.tilemap.findPath(new FlxPoint(this.x,this.y), point,true,true);
				this.followPath(path,_pathVelocity);
				_isFollowingPath = true;
			}
		}
		public function stopFollow():void
		{
			if (_isFollowingPath)
			{
				this.stopFollowingPath();
				_isFollowingPath = false;
				velocity.x = velocity.y = 0;
			}
		}
		public function get isFollowingPath():Boolean 
		{
			return _isFollowingPath;
		}
		
		public function set isFollowingPath(value:Boolean):void 
		{
			_isFollowingPath = value;
		}
		
	}

}