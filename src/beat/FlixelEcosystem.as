package beat 
{
	import org.flixel.*;
	/**
	 * ...
	 * @author 
	 */
	public class FlixelEcosystem extends FlxGame 
	{
		public function FlixelEcosystem(width:int, height:int,zoom:int=1) 
		{
			super(width / zoom, height / zoom, MenuState, zoom);
			Registry.upperLimit = 0;
			Registry.lowerLimit = 15;
		}
		
	}

}