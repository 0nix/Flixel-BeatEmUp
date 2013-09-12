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
		private var hits:FlxGroup;
		private var enemies:FlxGroup;
		private var upperLimit:int;
		private var lowerLimit:int;
		private var navi:FlxSprite;
		private var isNaviFollowingPath:Boolean = false;
		override public function create():void
		{
			super.create();
			//generals
			FlxG.bgColor = FlxG.BLUE;
			//field objects
			tilemap = new FlxTilemap().loadMap(Registry.getCurrentLevel(),FlxTilemap.ImgAuto,0,0,FlxTilemap.AUTO);
			this.add(tilemap);
			hits = new FlxGroup(20);
			this.add(hits);
			enemies = new FlxGroup(20);
			this.add(enemies);
			//interactive objects
			Registry.player = new Player(40, 60, 40,hits);
			this.add(Registry.player);
			this.followSprite(Registry.player);
			navi = new FlxSprite(30, 40);
			navi.makeGraphic(5, 5, FlxG.GREEN);
			this.add(navi);
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
			// Check for expired hits
			for ( var i:int = 0; i <= hits.members.length; i++)
			{
				if (hits.members[i] is Acid && Acid(hits.members[i]).toDestroy)
				{
					hits.remove(hits.members[i], true);
				}
			}
			FlxG.collide(tilemap, navi);
			startFollow();
			if (isNaviFollowingPath && navi.pathSpeed == 0)
			{
				navi.stopFollowingPath();
				isNaviFollowingPath = false;
				navi.velocity.x = navi.velocity.y = 0;
			}
			//overlap checks
			FlxG.overlap(player, hits, onOverlap);
			FlxG.overlap(navi, hits, onOverlap);
		}
		
		private function startFollow():void 
		{
			//check for navi - player distance
			var pointNavi:FlxPoint = new FlxPoint(navi.x, navi.y);
			var pointPlayer:FlxPoint = new FlxPoint(Registry.player.x, Registry.player.y);
			var distance:Number = FlxU.abs(FlxU.getDistance(pointNavi, pointPlayer));
			if (distance >= 30 && !isNaviFollowingPath)
			{
				var path:FlxPath = tilemap.findPath(pointNavi, pointPlayer,true,true);
				navi.followPath(path,35);
				isNaviFollowingPath = true;
			}
		}
		private function onOverlap(o1:FlxBasic, o2:FlxBasic):void
		{
			if (o1 is Player && o2 is Acid && Acid(o2).hurtsPlayer)
			{
				trace("test");
			}
			if (o1 is FlxSprite && o2 is Acid)
			{
				this.remove(navi, true);
			}
		}
		private function setCameraBounds():void
		{
			FlxG.camera.setBounds(0, 0, tilemap.width, tilemap.height);
			FlxG.worldBounds = new FlxRect(0, 0, tilemap.width, tilemap.height);
		}
		private function followSprite(s:FlxSprite):void
		{
			if (s)
			{
				FlxG.camera.follow(s);
				setCameraBounds();
			}
		}
		private function onCollide(i:FlxBasic,b:FlxBasic):void 
		{
			trace("hahaderp");
		}
		public function GameState()
		{
			
		}
	}

}