package beat 
{
	import org.flixel.FlxParticle;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxTilemap;
	import org.flixel.FlxPath;
	import org.flixel.FlxU;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author 
	 */
	public class Navi extends FlxSprite 
	{
		private var _pathVelocity:Number;
		
		private var _isFollowingPath:Boolean = false;
		private var _isAlert:Boolean = false;
		
		public static const BEHAVIOUR_IDLE:int = 0;
		public static const BEHAVIOUR_PURSUIT:int = 1;
		public static const BEHAVIOUR_ATTACK:int = 2;
		
		public static const PURSUIT_THRESHOLD:int = 40;
		public static const ATTACK_THRESHOLD:int = 5;
		private var _behaviour:int;
		private var myPoint:FlxPoint = new FlxPoint();
		private var playerPoint:FlxPoint  = new FlxPoint();
		public function Navi(X:Number=0, Y:Number=0, pathVelocity:Number = 35) 
		{
			super(X, Y,null);
			this.makeGraphic(5, 5, FlxG.GREEN);
			_pathVelocity = pathVelocity;
		}
		override public function update():void
		{
			super.update();
			myPoint.x = this.x;
			myPoint.y = this.y;
			playerPoint.x = Registry.player.x + Registry.player.width;
			playerPoint.y = Registry.player.y + Registry.player.height / 2;
			
			//Fixed-state Machine determines behaviour phases
			var distance:Number = FlxU.abs(FlxU.getDistance(myPoint, playerPoint));
			if (distance > PURSUIT_THRESHOLD)
			{
				_behaviour = BEHAVIOUR_IDLE;
			}
			if (distance >= ATTACK_THRESHOLD && distance < PURSUIT_THRESHOLD)
			{
				_behaviour = BEHAVIOUR_PURSUIT;
			}
			if (distance < ATTACK_THRESHOLD)
			{
				_behaviour = BEHAVIOUR_ATTACK;
			}
			//If at any time path speed is 0 (which happens everytime the path completes itself) 
			if (pathSpeed == 0)
			{
				_isFollowingPath = false;
			}
			// Reaction to Behaviours
			if (_behaviour == BEHAVIOUR_IDLE)
			{
				if (_isAlert)
				{
					_behaviour = BEHAVIOUR_PURSUIT;
				}
				else
				{
					stop();
				}
			}
			if (_behaviour == BEHAVIOUR_PURSUIT && _isFollowingPath)
			{	
				stopFollow();
			}
			if (_behaviour == BEHAVIOUR_PURSUIT && !_isFollowingPath)
			{
				if (!_isAlert)
					_isAlert = true;
				stop();
				startFollow();
			}
			
			if (_behaviour == BEHAVIOUR_ATTACK && _isFollowingPath)
			{
				stopFollow();
			}
			if (_behaviour == BEHAVIOUR_ATTACK && !_isFollowingPath)
			{
				stop();
			}
		}
		
		private function goRandom():void 
		{
			//(Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum)
			var factor:Number = FlxU.floor(Math.random() * (3 + 1));
			switch(factor)
			{
				//go up
				case 0:
					velocity.y += _pathVelocity/20;
					break;
				//go down
				case 1:
					velocity.y -= _pathVelocity/20;
					break;
				//go left
				case 2:
					velocity.x -= _pathVelocity/20;
					break;
				//go right
				case 3:
					velocity.x += _pathVelocity/20;
					break;
			}
		}
		private function stop():void
		{
			velocity.x = velocity.y = 0;
			acceleration.x = acceleration.y = 0;
		}
		private function startFollow():void
		{
			_isFollowingPath = true;
			var path:FlxPath = new FlxPath();
			path.addPoint(myPoint);
			path.addPoint(playerPoint);
			this.followPath(path, _pathVelocity);
		}
		private function stopFollow():void
		{	
			if (pathSpeed == 0)
			{
				this.stopFollowingPath(true);
				_isFollowingPath = false;
				stop();
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