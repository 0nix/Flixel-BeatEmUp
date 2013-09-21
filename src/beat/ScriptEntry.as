package beat 
{
	/**
	 * ...
	 * @author 
	 */
	public class ScriptEntry 
	{
		private var _type:String;
		private var _posX:int;
		private var _posY:int;
		public function ScriptEntry(type:String, x:int = 0,y:int = 0) 
		{
			_type = type;
			_posX = x;
			_posY = y;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function set type(value:String):void 
		{
			_type = value;
		}
		
		public function get posX():int 
		{
			return _posX;
		}
		
		public function get posY():int 
		{
			return _posY;
		}
		
	}

}