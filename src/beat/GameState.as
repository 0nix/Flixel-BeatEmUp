package beat 
{
	import org.flixel.*;
	import com.greensock.TweenMax;
	/*
	 * ...
	 * @author 
	 */
	public class GameState extends FlxState 
	{
		private var tilemap:FlxTilemap;
		private var player:Player;
		private var hits:HitGroup;
		private var enemies:EnemyGroup;
		private var arrayLength:int;
		private var gameScript:Vector.<ScriptEntry>;
		private var lid:int;
		override public function create():void
		{
			super.create();
			//generals
			FlxG.bgColor = FlxG.BLUE;
			
			//field objects
			Registry.tilemap = new FlxTilemap().loadMap(Registry.getLevel(lid), FlxTilemap.ImgAuto, 0, 0, FlxTilemap.AUTO);
			Registry.hitGroup = new HitGroup(20);
			Registry.enemyGroup = new EnemyGroup(20);
			this.add(Registry.tilemap);
			this.add(Registry.hitGroup);
			this.add(Registry.enemyGroup);
		}
		override public function update():void
		{
			super.update();
			if (FlxG.keys.D)
			{
				if (FlxG.debug && FlxG.visualDebug)
					FlxG.debug = FlxG.visualDebug = false;
				else
					FlxG.debug = FlxG.visualDebug = true;
			}
			//script entries processed
			arrayLength = gameScript.length;
			for (var i:int = 0; i < arrayLength; i++)
			{
				switch(gameScript[i].type)
				{
					case "player":
						Registry.player = new Player(gameScript[i].posX, gameScript[i].posY,40);
						this.add(Registry.player);
						this.followSprite(Registry.player);
						gameScript.splice(i, 1);
						arrayLength--;
						break;
					case "upperLimit":
						if ( Registry.player && Registry.player.x+Registry.player.width == gameScript[i].posX)
						{
							//tween goddamnit
							gameScript.splice(i, 1);
							arrayLength--;
						}
					case "lowerLimit":
						if ( Registry.player && Registry.player.x+Registry.player.width == gameScript[i].posX)
						{
							//tween goddamnit
							gameScript.splice(i, 1);
							arrayLength--;
						}
					case "navi":
						if ( Registry.player && FlxU.abs(Registry.player.x+Registry.player.width - gameScript[i].posX) <= Registry.drawDistance)
						{
							Registry.enemyGroup.add(new Navi(gameScript[i].posX, gameScript[i].posY));
							gameScript.splice(i, 1);
							arrayLength--;
						}
						break;
				}
			}
			//COLLISIONS
			FlxG.overlap(Registry.hitGroup, Registry.enemyGroup, onEnemyHit);
		}
		private function onEnemyHit(o1:FlxBasic, o2:FlxBasic):void
		{
			if (o1 is Acid && o2 is Navi)
			{
				Registry.enemyGroup.remove(o2,true);
			}
		}
		private function setCameraBounds():void
		{
			FlxG.camera.setBounds(0, 0, Registry.tilemap.width, Registry.tilemap.height);
			FlxG.worldBounds = new FlxRect(0, 0, Registry.tilemap.width, Registry.tilemap.height);
		}
		private function followSprite(s:FlxSprite):void
		{
			if (s)
			{
				FlxG.camera.follow(s);
				setCameraBounds();
			}
		}
		public function GameState(levelID:int,script:Vector.<ScriptEntry>)
		{
			gameScript = script;
			lid = levelID;
		}
	}

}