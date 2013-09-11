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
		private var upperLimit:int;
		private var lowerLimit:int;
		override public function create():void
		{
			super.create();
			//generals
			FlxG.bgColor = FlxG.BLUE;
			//field objects
			tilemap = new FlxTilemap().loadMap(Registry.getCurrentLevel(),FlxTilemap.ImgAuto,0,0,FlxTilemap.AUTO);
			this.add(tilemap);
			hits = new FlxGroup();
			this.add(hits);
			//interactive objects
			Registry.player = new Player(40, 60, 30,hits);
			this.add(Registry.player);
			this.followSprite(Registry.player);
			upperLimit = 6;
			lowerLimit = 12;
		}
		override public function update():void
		{
			super.update();
			///FlxG.collide(player, tilemap);
			if (Registry.player.y + Registry.player.height*(1 - Registry.player.shadowSize) <= Registry.TILESIZE*upperLimit)
			{
				Registry.player.y = Registry.TILESIZE * upperLimit - Registry.player.height * (1 - Registry.player.shadowSize);
			}
			else if (Registry.player.y +Registry.player.height >= Registry.TILESIZE * lowerLimit)
			{
				Registry.player.y = Registry.TILESIZE * lowerLimit - Registry.player.height;
			}
			for ( var i:int = 0; i <= hits.members.length; i++)
			{
				if (hits.members[i] is Acid && Acid(hits.members[i]).toDestroy)
				{
					hits.remove(hits.members[i], true);
				}
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