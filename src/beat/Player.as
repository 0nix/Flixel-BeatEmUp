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
		private var ATTACK_REFRESH:Number = 0.6;
		private var ATTACK_DURATION:Number = 0.35;
		private var _shadowSize:Number = 1 / 7;
		private var _hitGroup:HitGroup;
		private var _attackTimer:FlxTimer;
		private var _canAttack:Boolean = true;
		public function Player(X:Number = 0, Y:Number = 0,velocity:uint = 30, SimpleGraphic:Class = null) 
		{
			super(X, Y, SimpleGraphic);
			var runSpeed:uint = velocity;
			var jumpPower:int = velocity;
			drag.x = runSpeed * 6;
			drag.y = runSpeed * 6;
			maxVelocity.x = runSpeed;
			maxVelocity.y = jumpPower;
			_hitGroup = Registry.hitGroup;
			_attackTimer = new FlxTimer();
			this.health = 100;
		}
		override public function update():void
		{
			super.update();
			this.acceleration.x = 0;
			this.acceleration.y = 0;
			if (_canAttack)
			{
				if (FlxG.keys.Q)
				{
					this.knockback();
				}
				if(FlxG.keys.LEFT)
				{
					acceleration.x -= drag.x;
					this.facing = FlxObject.LEFT;
				}
				if(FlxG.keys.RIGHT)
				{
					acceleration.x += drag.x;
					this.facing = FlxObject.RIGHT;
				}
				if(FlxG.keys.UP)
				{
					acceleration.y -= drag.y;
				}
				if(FlxG.keys.DOWN)
				{
					acceleration.y += drag.y;
					
				}
				if (FlxG.keys.SPACE)
				{
					var modifier:int = 0;
					if (FlxG.keys.UP)
					{
						modifier = -3;
					}
					else if (FlxG.keys.DOWN)
					{
						modifier = 3;
					}
					if (_hitGroup && this.facing == FlxObject.LEFT)
					{
						(_hitGroup.recycle(Acid) as Acid).init(ATTACK_DURATION, 4*this.width/5, this.height, this.x - 4*this.width/5, this.y+modifier);
						summonSickness();
					}
					else if (_hitGroup && this.facing == FlxObject.RIGHT)
					{
						(_hitGroup.recycle(Acid) as Acid).init(ATTACK_DURATION,  4*this.width/5, this.height, this.x + this.width, this.y+modifier);
						summonSickness();
					}
				}
			}
		}
		private function knockback():void
		{
			summonSickness();
			if(this.facing == FlxObject.LEFT)
			{
					acceleration.x += drag.x*900000;
			}
			else if(this.facing == FlxObject.RIGHT)
			{
					acceleration.x -= drag.x*900000;
			}
			FlxG.camera.shake(0.005, 0.2);
			this.flicker(0.01);
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
		override public function hurt(Damage:Number):void
		{
			super.hurt(Damage);
			knockback();
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