package cn.flashk.controls.support
{
	import flash.display.BitmapData;
	import flash.utils.getDefinitionByName;

	public class SWFDefinition
	{
		public function SWFDefinition()
		{
		}
		/**
		 * 返回文档中给定库链接名字的BitmapData实例
		 */ 
		public static function getDefinitionBitmapDataByName(name:String):BitmapData{
			var bd:BitmapData;
			var ClassReference:Class = getDefinitionByName(name) as Class;
			var instance:Object = new ClassReference();
			bd = instance as BitmapData;
			return bd;
		}
	}
}