package me.rainssong.utils
{
	
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.describeType;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class ObjectCore
	{
		
		public function ObjectCore()
		{
		
		}
		
		static public function getValue(obj:*, expression:String):*
		{
			if (obj == null)
				return null;
			
			var arr:Array = expression.split(".");
			
			var result:*= obj;
			
			for (var i:int = 0; i < arr.length; i++) 
			{
				if(result.hasOwnProperty(arr[i]))
					result = result[arr[i]];
				//if (!result == null || result==undefined)
					//return result;
				else
					return null;
			}
			
			return result;
		}
		
		static public function traceProps(obj:*):void
		{
			powerTrace(getQualifiedClassName(obj));
			for (var i:* in obj)
			{	
				trace(i , ":" , typeof(i) , " = " , obj[i]);
			}
		}
		
		public static function toDictionary(obj:Object, weakKeys:Boolean = false):Dictionary
		{
			var dic:Dictionary = new Dictionary(weakKeys);
			for (var i:String in obj)
			{
				dic[i] = obj[i];
			}
			return dic;
		}
		
		public static function isSimple(object:Object):Boolean
		{
			switch (typeof(object))
			{
				case "number": 
				case "string": 
				case "boolean": 
					return true;
				case "object": 
					return (object is Date) || (object is Array);
			}
			
			return false;
		}
		
		public static function setData(target:Object, data:Object):void
		{
			if (data == null)
				return;
			for (var prop:String in data)
				if (target.hasOwnProperty(prop))
					try
					{
						target[prop] = data[prop];
					}
					catch (e:Error)
					{
					}
		}
		
		public static function concatObjects(... args):Object
		{
			var finalObject:Object = {};
			var currentObject:Object;
			for (var i:int = 0; i < args.length; i++)
			{
				currentObject = args[i];
				for (var prop:String in currentObject)
				{
					if (currentObject[prop] == null)
					{
						// delete in case is null
						delete finalObject[prop];
					}
					else
					{
						finalObject[prop] = currentObject[prop];
					}
				}
			}
			return finalObject;
		}
		
		public static function getClassPath(target:*):String
		{
			return getQualifiedClassName(target).replace(new RegExp("::", "g"), ".");
		}
		
		public static function getPackage(target:*):String
		{
			return getQualifiedClassName(target).split("::").shift();
		}
		
		//public static function isDynamic( target:* ):Boolean {
		//return Boolean( StringUtil.toProperType( describeType( target ).attribute( "isDynamic" ) ) );
		//
		//}
		
		/**
		 * Get the <code>String</code> name of any <code>Object</code>.
		 * 
		 * @param	Obj		The <code>Object</code> object in question.
		 * @param	Simple	Returns only the class name, not the package or packages.
		 * 
		 * @return	The name of the <code>Class</code> as a <code>String</code> object.
		 */
		static public function getClassName(Obj:Object,Simple:Boolean=false):String
		{
			var string:String = getQualifiedClassName(Obj);
			string = string.replace("::",".");
			if(Simple)
				string = string.substr(string.lastIndexOf(".")+1);
			return string;
		}
		
		public static function isExtended(target:*, cls:Class):Boolean
		{
			return Object(target).constructor == cls;
		}
		
		/**
		 * 克隆对象（深复制）,会丢失复杂类型
		 * @param source:Object — 源对象，克隆对象的主体
		 * @return * — 源对象的克隆对象
		 */
		public static function clone(source:Object):*
		{
			var bytes:ByteArray = new ByteArray();
			var className:String = getQualifiedClassName(source);
			var cls:Class
			try{
				cls = getDefinitionByName(className) as Class;
			}
			catch(e:Error)
			{
				return null;
			}
			registerClassAlias(className, cls);
			bytes.writeObject(source);
			bytes.position = 0;
			return bytes.readObject();
		}
		
		//public static function simpleClone(source:Object):*
		//{
			//for (var name:String in source) 
			//{
				//if(source[name] is )
			//}
		//}
		
		/**
		 * 该方法并不严谨
		 * @param	a
		 * @param	b
		 * @return
		 */
		static public function isContentEqual(a:*, b:*):Boolean
		{
			for (var name:String in a)
			{
				if (a[name] == b[name])
					continue;
				else
					return false;
			}
			for (name in b)
			{
				if (a[name] == b[name])
					continue;
				else
					return false;
			}
			
			return true;
		}
		
		static public function setParams(fromObj:Object, toObj:Object):Object
		{
			for (var prop:String in fromObj)
			{
				if (toObj.hasOwnProperty(prop))
				{
					toObj[prop] = fromObj[prop];
				}
			}
			return toObj;
		}
		
		static public function printObjToCode(obj:*):void
		{
			powerTrace(objToCode(obj));
		}
	}
}