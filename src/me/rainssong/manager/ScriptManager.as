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
		private var _thisObj:Object;
		private var _context:Object;
		
		public function ScriptManager()
		{
			_thisObj = this;
			_context = ScriptManager;
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
				{
					powerTrace("no such key:" + line);
					return;
				}
				
			}
			
			if (count >= length)
			{
				return;
				powerTrace("overload", count);
			}
			
			var motion:String = xml.motion[count].toString();
			//powerTrace(motion);
			D.eval(motion,_context,_thisObj);
		}
		
		public function next():void
		{
			runScript(count+1);
		}
		
		public function get thisObj():Object 
		{
			return _thisObj;
		}
		
		public function set thisObj(value:Object):void 
		{
			_thisObj = value;
		}
		
		public function get context():Object 
		{
			return _context;
		}
		
		public function set context(value:Object):void 
		{
			_context = value;
		}
		
	}

}