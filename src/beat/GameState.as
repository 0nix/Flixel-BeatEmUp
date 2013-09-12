package beat 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author 
	 */
	public class GameState extends FlxState 
	{
		private var tilemap:FlxTilemap;
		private var player:Player;
		private var hits:HitGroup;
		private var enemies:EnemyGroup;
		private var upperLimit:int;
		private var lowerLimit:int;
		override public function create():void
		{
			super.create();
			//generals
			FlxG.bgColor = FlxG.BLUE;
			//field objects
			Registry.tilemap = new FlxTilemap().loadMap(Registry.getCurrentLevel(), FlxTilemap.ImgAuto, 0, 0, FlxTilemap.AUTO);
			Registry.hitGroup = new HitGroup(20);
			Registry.enemyGroup = new EnemyGroup(20);
			this.add(Registry.tilemap);
			this.add(Registry.hitGroup);
			this.add(Registry.enemyGroup);
			
			//interactive objects
			Registry.player = new Player(40, 60, 40);
			this.add(Registry.player);
			this.followSprite(Registry.player);
			Registry.enemyGroup.add(new Navi(80, 50));
			//limits
			upperLimit = 6;
			lowerLimit = 12;
		}
		override public function update():void
		{
			super.update();
			// Check for player boundaries
			if (Registry.player.y + Registry.player.height*(1 - Registry.player.shadowSize) <= Registry.TILESIZE*upperLimit)
			{
				Registry.player.y = Registry.TILESIZE * upperLimit - Registry.player.height * (1 - Registry.player.shadowSize);
			}
			else if (Registry.player.y +Registry.player.height >= Registry.TILESIZE * lowerLimit)
			{
				Registry.player.y = Registry.TILESIZE * lowerLimit - Registry.player.height;
			}
			//COLLISIONS
			FlxG.collide(Registry.tilemap, Registry.enemyGroup);
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
		public function GameState()
		{
			
		}
	}

}