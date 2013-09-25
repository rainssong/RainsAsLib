package me.rainssong.utils
{


	import flash.utils.describeType;
	import flash.utils.Dictionary;
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
			for (var i:String = 0 in obj)
			{
				dic[i] = obj[i];
			}
			return dic;
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
		
		/**
		 * <span lang="ja">対象のクラスに final 属性が設定されているかどうかを返します。</span>
		 * <span lang="en">Returns if the final attribute is set to the class object.</span>
		 * 
		 * @param target
		 * <span lang="en">final 属性の有無を調べる対象です。</span>
		 * <span lang="en">The object to check if the final attribute is set or not.</span>
		 * @return
		 * <span lang="en">final 属性があれば true を、違っていれば false を返します。</span>
		 * <span lang="en">Returns true if final attribute is set, otherwise return false.</span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		//public static function isFinal( target:* ):Boolean {
			//return Boolean( StringUtil.toProperType( describeType( target ).attribute( "isFinal" ) ) );
		//}
		
		/**
		 * <span lang="ja">対象のインスタンスが指定されたクラスを継承しているかどうかを返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @param target
		 * <span lang="ja">継承関係を調査したいインスタンスです。</span>
		 * <span lang="en"></span>
		 * @param cls
		 * <span lang="ja">継承関係を調査委したいクラスです。</span>
		 * <span lang="en"></span>
		 * @return
		 * <span lang="ja">継承されていれば true を、それ以外の場合には false を返します。</span>
		 * <span lang="en"></span>
		 * 
		 * @example <listing version="3.0">
		 * </listing>
		 */
		public static function isExtended( target:*, cls:Class ):Boolean {
			return Object( target ).constructor == cls;
		}
	}
}