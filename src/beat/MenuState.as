package beat 
{
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxText;
	/**
	 * ...
	 * @author 
	 */
	public class MenuState extends FlxState 
	{
		
		override public function create():void
		{
			super.create();
			FlxG.bgColor = FlxG.BLACK;
			var s:FlxText = new FlxText(0, 0, FlxG.width, "A Beat 'Em Up Prototype in Flixel by Onix");
			this.add(s);
			var t:FlxText = new FlxText(0, s.height*4/3 + s.y, FlxG.width,"Control character with arrows");
			this.add(t);
			var u:FlxText = new FlxText(0, t.height + t.y, FlxG.width,"Spacebar to attack");
			this.add(u);
			var v:FlxText = new FlxText(0, u.height + u.y, FlxG.width, "D to activate debug view");
			this.add(v);
			var w:FlxText = new FlxText(0, v.height + v.y, FlxG.width, "Press X to start the demo");
			this.add(w);
		}
		override public function update():void
		{
			super.update();
			if (FlxG.keys.X)
			 {
				 FlxG.switchState( new GameState());
			 }
		}
		public function MenuState() 
		{
			super();
		}
		
	}

}