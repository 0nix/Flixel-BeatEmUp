package beat 
{
	import flash.utils.Timer;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxTimer;
	/**
	 * ...
	 * @author 
	 */
	public class Player extends FlxSprite 
	{	
		private const ATTACK_REFRESH:Number = 0.7;
		private const ATTACK_DURATION:Number = 0.08;
		private var _shadowSize:Number = 1 / 7;
		private var _hitGroup:FlxGroup;
		private var _attackTimer:FlxTimer;
		private var _canAttack:Boolean = true;
		public function Player(X:Number = 0, Y:Number = 0,velocity:uint = 30,hitGroup:FlxGroup = null, SimpleGraphic:Class = null) 
		{
			super(X, Y, SimpleGraphic);
			var runSpeed:uint = velocity;
			var jumpPower:int = velocity;
			drag.x = runSpeed * 6;
			drag.y = runSpeed * 6;
			maxVelocity.x = runSpeed;
			maxVelocity.y = jumpPower;
			_hitGroup = hitGroup;
			_attackTimer = new FlxTimer();
		}
		override public function update():void
		{
			super.update();
			this.acceleration.x = 0;
			this.acceleration.y = 0;
			if(FlxG.keys.LEFT)
			{
				acceleration.x -= drag.x;
				this.facing = FlxObject.LEFT;
				//this.allowCollisions = FlxObject.LEFT;
			}
			if(FlxG.keys.RIGHT)
			{
				acceleration.x += drag.x;
				this.facing = FlxObject.RIGHT;
				//this.allowCollisions = FlxObject.RIGHT;
			}
			if(FlxG.keys.UP)
			{
				acceleration.y -= drag.y;
			}
			if(FlxG.keys.DOWN)
			{
				acceleration.y += drag.y;
				
			}
			if (FlxG.keys.SPACE && _canAttack)
			{
				if (_hitGroup && this.facing == FlxObject.LEFT)
				{
					(_hitGroup.recycle(Acid) as Acid).init(ATTACK_DURATION, this.width/2, this.height, this.x - this.width/2, this.y);
					summonSickness();
				}
				else if (_hitGroup && this.facing == FlxObject.RIGHT)
				{
					(_hitGroup.recycle(Acid) as Acid).init(ATTACK_DURATION, this.width/2, this.height, this.x + this.width, this.y);
					summonSickness();
				}
			}
		}
		
		private function summonSickness():void 
		{
			_canAttack = false;
			_attackTimer.start(ATTACK_REFRESH, 1, onAttackTimer);
		}
		
		private function onAttackTimer(timer:FlxTimer):void 
		{
			_canAttack = true;
		}
		public function get shadowSize():Number 
		{
			return _shadowSize;
		}
		
		public function set shadowSize(value:Number):void 
		{
			_shadowSize = value;
		}
		
	}

}