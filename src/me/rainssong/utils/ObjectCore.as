package me.rainssong.utils
{
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class ObjectCore
	{
		
		public function ObjectCore()
		{
		
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
	}
}