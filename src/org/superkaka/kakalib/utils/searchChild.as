package org.superkaka.kakalib.utils 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	/**
	 * 搜索容器中指定类型的对象并以数组方式返回
	 * 调试用
	 * @author ｋａｋａ
	 */
		
	public function searchChild(container:DisplayObjectContainer, searchType:Class):Array
	{
		
		var list_child:Array = [];
		
		var i:int = 0;
		var c:int = container.numChildren;
		while (i < c) 
		{
			
			var child:DisplayObject = container.getChildAt(i);
			
			if (child is searchType)
			{
				list_child.push(child);
			}
			else
			if (child is DisplayObjectContainer)
			{
				list_child = list_child.concat(searchChild(child as DisplayObjectContainer, searchType));
			}
			
			i++;
		}
		
		return list_child;
		
	}

}