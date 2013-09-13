package beat 
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxU;
	import org.flixel.FlxPath;
	/**
	 * ...
	 * @author 
	 */
	public class EnemyGroup extends FlxGroup 
	{
		private var _playerPoint:FlxPoint = new FlxPoint();
		public function EnemyGroup(MaxSize:uint=0) 
		{
			super(MaxSize);
		}
		override public function update():void
		{
			super.update();
			_playerPoint.x = Registry.player.x + Registry.player.width + 10;
			_playerPoint.y = Registry.player.y + Registry.player.height / 2;
			var len:int = members.length;
			for (var i:int = 0; i <= len; i++)
			{
				if (members[i] is Navi)
				{
					var n:Navi = members[i];
					var naviPoint:FlxPoint = new FlxPoint(n.x, n.y);
					var distance:Number = FlxU.abs(FlxU.getDistance(naviPoint, _playerPoint));
					if (distance > 20)
					{
						n.behaviour = Navi.BEHAVIOUR_IDLE;
					}
					if (distance >= 10 && distance < 20)
					{
						n.behaviour = Navi.BEHAVIOUR_PURSUIT;
					}
					if (distance < 10 && !n.isFollowingPath)
					{
						n.behaviour = Navi.BEHAVIOUR_ATTACK;
					}
				}
			}
		}
		public function get playerPoint():FlxPoint 
		{
			return _playerPoint;
		}
		
		public function setplayerPoint(x:Number,y:Number):void 
		{
			_playerPoint.x = x;
			_playerPoint.y = y;
		}
		
	}

}