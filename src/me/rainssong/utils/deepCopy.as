package me.rainssong.utils
{
	
	import flash.utils.ByteArray;
	
	
	/**
	* deep copy object
	* @param value Object
	* @return Object
	* @default 
	*/
	public function deepCopy(value:Object):Object
	{
		var buffer:ByteArray = new ByteArray();
		buffer.writeObject(value);
		buffer.position = 0;
		var result:Object = buffer.readObject();
		return result;
	}
	
	
}
	