package beat 
{
	import org.flixel.FlxGroup;
	
	/**
	 * ...
	 * @author 
	 */
	public class HitGroup extends FlxGroup 
	{
		
		public function HitGroup(MaxSize:uint=0) 
		{
			super(MaxSize);
			
		}
		override public function update():void
		{
			super.update();
			//check for expired hits
			for ( var i:int = 0; i <= members.length; i++)
			{
				if (members[i] is Acid && Acid(members[i]).toDestroy)
				{
					remove(members[i], true);
				}
			}
		}
	}

}