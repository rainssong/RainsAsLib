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
		
		private var _xmlName:String="";
		private var _scriptDic:Dictionary = new Dictionary(true);
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
			
			this.xmlName = xmlName;
			
			var xml:XML = scriptDic[this.xmlName];
			var length:int = xml.motion.length();
			
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
				if (targetIndex >= 0)
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
		
		public function get xmlName():String 
		{
			return _xmlName;
		}
		
		public function set xmlName(value:String):void 
		{
			if (value!=null && value!=_xmlName) 
			{	
				_xmlName = value;
				count = 0;
				var xml:XML = _scriptDic[_xmlName];
				var length:int = xml.motion.length();
				
				for (var i:int = 0; i < length; i++ )
					if (xml.motion[i].@key.toString() != null)
						_keyDic[xml.motion[i].@key.toString()] = i;
			}
		}
		
		public function get scriptDic():Dictionary 
		{
			return _scriptDic;
		}
		
		public function set scriptDic(value:Dictionary):void 
		{
			_scriptDic = value;
		}
		
	}

}