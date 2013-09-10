package beat 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author 
	 */
	//[SWF(width="320", height="240", backgroundColor="#DDDDDD")]
	public class FlixelEcosystem extends FlxGame 
	{
		public function FlixelEcosystem(width:int, height:int,zoom:int=1) 
		{
			super(width / zoom, height / zoom, GameState, zoom);
			//FlxG.debug  = true;
			//FlxG.visualDebug = true;
		}
		
	}

}