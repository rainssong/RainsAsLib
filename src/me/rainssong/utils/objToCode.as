

package me.rainssong.utils
{
	import me.rainssong.math.ArrayCore;
	
	/**
	 * ...
	 * @author Rainssong
	 * Object to Code
	 * 2013/7/9 17:46
	 */
	
	public function objToCode(obj:*):String
	{
		if (obj == null) return "";
		var className:String = obj.constructor.toString();
		className = className.slice(7, -1);
		var result:String = "";
		var i:*;
		
		if (obj is Number ||  obj is Boolean )
		{
			result += obj ;
		}
		else if (obj is String)
		{
			result += "\""+obj+ "\"" ;
		}
		else if (obj.constructor == Array )
		{
			result +="[";
			for (i in obj)
			{
				result+=arguments.callee(obj[i])+",";
			}
			if (result.slice( -1) == ",") result = result.slice(0, -1);
			result +="]\r";
		}
		else if (ArrayCore.isVector(obj) )
		{
			result +=className+"([";
			for (i in obj)
			{
				result+=arguments.callee(obj[i])+",";
			}
			if (result.slice( -1) == ",") result = result.slice(0, -1);
			result += "])\r";
		}
		else if(obj.constructor== Object)
		{
			result += "{";
			
			for (i in obj)
			{
				result += i + ":" +arguments.callee(obj[i]) + ",";
			}
			if (result.slice( -1) == ",") result = result.slice(0, -1);
			result +=  "}";
			
		}
		else
		{
			result +=className+"(";
			
			for (i in obj)
			{
				result += i + ":" +arguments.callee(obj[i]) + ",";
			}
			
			if (result.slice( -1) == ",") result = result.slice(0, -1);
			result +=  ")";
		}
		
		
		return result;
	}
}