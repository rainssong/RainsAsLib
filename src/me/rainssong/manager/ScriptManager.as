package manager
{
	import controller.GameController;
	import events.SAGameEvent;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Scene;
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import me.rainssong.display.SmartSprite;
	import me.rainssong.manager.SingletonManager;
	import me.rainssong.text.HtmlText;
	import me.rainssong.utils.superTrace;
	import r1.deval.D;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public dynamic class ScriptManager extends EventDispatcher
	{
		public var count:int = 0;
		
		public var xmlName:String;
		
		
		public function ScriptManager()
		{
		}
		
		public function reset():void
		{
			count = 0;
		}
		
		public function runScript(line:*=-1,xmlName:String=null):void
		{
			
			if (xmlName) 
			{	this.xmlName = xmlName;
				count = 0;
			} 
			
			var length:int = currentXml.motion.length();
			
			if (line is Number && line>=0)
			{
				count = line;
			}
			else if (line is String)
			{
				for (var i:int = 0; i < length; i++ )
				{
					if (currentXml.motion[i].@key.toString() == line)
					{
						count = i;
						break;
					}
				}
			}
			
			if (count >= length)
			{
				return;
				powerTrace("overload",count,xmlName)
			}
			
			var motion:String = currentXml.motion[count].toString();
			powerTrace(motion);
			
			D.eval(motion,ScriptManager,this);
			
		}
		
	}

}