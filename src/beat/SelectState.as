package beat 
{
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxButton;
	import org.flixel.FlxText;
	import com.greensock.TweenLite;
	/**
	 * ...
	 * @author 
	 */
	public class SelectState extends FlxState 
	{
		private var buttonList:Vector.<FlxButton> = new Vector.<FlxButton>();
		private var notFound:FlxText;
		override public function create():void 
		{
			super.create();
			FlxG.bgColor = FlxG.BLACK;
			for (var i:int = 0; i < Registry.getLevelLength(); i++)
			{
				var b:FlxButton = new FlxButton(0, 20*i, Registry.getLevelIdByIndex(i).toString(), onClick);
				this.add(b);
				buttonList.push(b);
			}
			notFound = new FlxText(0, FlxG.height - FlxG.height / 10, FlxG.width, "Level info not found");
			this.add(notFound);
			notFound.alpha = 0;
		}
		
		private function onClick():void 
		{
			var hasLevelInfo:Boolean = false;
			var selected:int = -1;
			// figure out what level index was selected
			for each(var fxb:FlxButton in buttonList)
			{
				if (fxb.status == FlxButton.PRESSED)
				{
					selected = Registry.getLevelIdByIndex(buttonList.indexOf(fxb)); 
				}
			}
			// check if there's ingame information for that particular level id
			for (var i:int = 0; i < Registry.generalScript.ingame.length(); i++)
			{
				if (int(Registry.generalScript.ingame[i].@id) == selected)
				{
					hasLevelInfo = true;
					break;
				}
			}
			// if there's in-game level information, parse a ScriptEntry vector
			if (hasLevelInfo)
			{
				var levelRawScript:XMLList = Registry.generalScript.ingame.(@id == selected);
				var levelParsedScript:Vector.<ScriptEntry> = new Vector.<ScriptEntry>();
				var length:int = levelRawScript.sprite.length();
				var playerTagExists:Boolean = false;
				for (var j:int = 0; j < length; j++)
				{
					var s:String = Registry.generalScript.ingame.sprite[j].@type;
					switch(s)
					{
						case "player":
							if (!playerTagExists)
							{
								playerTagExists = true;
								levelParsedScript.push(new ScriptEntry(s, int(Registry.generalScript.ingame.sprite[j].@x), int(Registry.generalScript.ingame.sprite[j].@y)));
							}
							break;
						case "navi":
							levelParsedScript.push(new ScriptEntry(s, int(Registry.generalScript.ingame.sprite[j].@x), int(Registry.generalScript.ingame.sprite[j].@y)));
							break;
						/*case "upperLimit":
							
							break;
						case "lowerLimit":
							
							break;*/
						default:
							//this.dispatchEvent( new IOErrorEvent("TAG NOT RECOGNIZED",true,false,"Script tag wasn't recognized"));
							break;	
					}
				}
				//finally, hide the mouse and switch to the GameState, passing the selected level id and the gamescript
				FlxG.mouse.hide();
				FlxG.switchState(new GameState(selected, levelParsedScript));
			}
			// if not, simply flash the level not found text blurb
			else
			{
				notFound.alpha = 1;
				TweenLite.to(notFound, 0.4, {delay:1, alpha:0} );
			}
		}
		public function SelectState() 
		{
			super();
		}
		
	}

}