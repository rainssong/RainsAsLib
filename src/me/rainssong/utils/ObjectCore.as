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
		
		public static function toDictionary(obj:Object,weakKeys:Boolean=false):Dictionary
		{
			var dic:Dictionary = new Dictionary(weakKeys) ;
			for (var i:String in obj)
			{
				dic[i] = obj[i];
			}
			return dic;
		}
		
		public static function isSimple(object:Object):Boolean {
			switch (typeof(object)) {
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
			if (data == null) return;
			for (var prop:String in data) 
				if (target.hasOwnProperty(prop)) 
					try
					{
						target[prop] = data[prop];
					}
					catch (e:Error) { };
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
		
		public static function getClassName( target:* ):String {
			return getQualifiedClassName( target ).split( "::" ).pop();
		}
		
		public static function getClassPath( target:* ):String {
			return getQualifiedClassName( target ).replace( new RegExp( "::", "g" ), "." );
		}
		
		public static function getPackage( target:* ):String {
			return getQualifiedClassName( target ).split( "::" ).shift();
		}
		
		//public static function isDynamic( target:* ):Boolean {
			//return Boolean( StringUtil.toProperType( describeType( target ).attribute( "isDynamic" ) ) );
		//
		//}
		
		
		public static function isExtended( target:*, cls:Class ):Boolean {
			return Object( target ).constructor == cls;
		}
		
		/**
		 * 克隆对象（深复制）
		 * @param source:Object — 源对象，克隆对象的主体
		 * @return * — 源对象的克隆对象
		 */
		public static function clone(source:Object):*
		{
			var bytes:ByteArray = new ByteArray();
			var className:String = getQualifiedClassName(source);
			var cls:Class = getDefinitionByName(className) as Class;
			
			registerClassAlias(className, cls);
			bytes.writeObject(source);
			bytes.position = 0;
			return bytes.readObject();
		}
		
		/**
		 * 该方法并不严谨
		 * @param	a
		 * @param	b
		 * @return
		 */
		static public function isContentEqual(a:*,b:*):Boolean 
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
	}
}