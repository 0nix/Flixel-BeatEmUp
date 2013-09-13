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
		public static const BEHAVIOUR_IDLE:int = 0;
		public static const BEHAVIOUR_PURSUIT:int = 1;
		public static const BEHAVIOUR_ATTACK:int = 2;
		private var _behaviour:int;
		public function Navi(X:Number=0, Y:Number=0, pathVelocity:Number = 35) 
		{
			super(X, Y,null);
			this.makeGraphic(5, 5, FlxG.GREEN);
			_pathVelocity = pathVelocity;
		}
		override public function update():void
		{
			super.update();
			if (behavior == BEHAVIOUR_IDLE)
			{
				//do random shit
			}
			if (behaviour == BEHAVIOUR_PURSUIT && !_isFollowingPath && Registry.player)
			{
				startFollow(new FlxPoint(Registry.player.x + Registry.player.width + 10, 
										Registry.player.y + Registry.player.height / 2));
				_isFollowingPath = true;
			}
			if (behaviour == BEHAVIOUR_PURSUIT && pathSpeed == 0)
			{
				stopFollow();
				velocity.x = velocity.y = 0;
				_isFollowingPath = false;
			}
			if (behaviour == BEHAVIOUR_ATTACK && !_isFollowingPath)
			{
				//attack the player!!!
				trace("I am attacking, fear me!!!");
			}
		}
		public function startFollow(point:FlxPoint):void
		{
			if (!_isFollowingPath)
			{
				var path:FlxPath = Registry.tilemap.findPath(new FlxPoint(this.x,this.y), point,true,true);
				this.followPath(path,_pathVelocity);
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
		
		public function get behaviour():int 
		{
			return _behaviour;
		}
		
		public function set behaviour(value:int):void 
		{
			_behaviour = value;
		}
		
	}

}