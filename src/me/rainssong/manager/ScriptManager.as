package me.rainssong.manager
{
	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;
	import r1.deval.D;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public dynamic class ScriptManager extends EventDispatcher
	{
		public var count:int = 0;
		
		public var xmlName:String="";
		public var scriptDic:Dictionary = new Dictionary(true);
		private var _keyDic:Dictionary = new Dictionary(true);
		
		public function ScriptManager()
		{
		}
		
		public function reset():void
		{
			count = 0;
		}
		
		public function runScript(line:*=null,xmlName:String=null):void
		{
			//if (xmlName!=null && xmlName!=this.xmlName) 
			//{	
				//this.xmlName = xmlName;
				//count = 0;
			//} 
			var changeXml:Boolean = false;
			if (xmlName!=null && xmlName!=this.xmlName) 
			{	
				this.xmlName = xmlName;
				count = 0;
				changeXml = true;
			}
			
			var xml:XML = scriptDic[this.xmlName];
			var length:int = xml.motion.length();
			
			if(changeXml)
				for (var i:int = 0; i < length; i++ )
					if (xml.motion[i].@key.toString() != null)
						_keyDic[xml.motion[i].@key.toString()] = i;
			
			if (line is Number && line>=0)
			{
				count = line;
			}
			else if(line == null)
			{
				count ++;
			}
			else if (line is String)
			{
				var targetIndex:int = _keyDic[line];
				if (targetIndex > 0)
					count = targetIndex;
				else
					powerTrace("no such key:" + line);
			}
			
			if (count >= length)
			{
				return;
				powerTrace("overload",count)
			}
			
			var motion:String = xml.motion[count].toString();
			powerTrace(motion);
			
			D.eval(motion,ScriptManager,this);
			
		}
		
		public function next():void
		{
			runScript(count+1);
		}
		
	}

}