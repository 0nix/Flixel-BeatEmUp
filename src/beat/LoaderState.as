package beat 
{
	import org.flixel.FlxState;
	
	/**
	 * ...
	 * @author 
	 */
	public class LoaderState extends FlxState 
	{
		private var idToLoad:int;
		override public function create():void
		{
			super.create();
			
		}
		public function LoaderState(level_id:int) 
		{
			idToLoad = level_id;
		}
		
	}

}