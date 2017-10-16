package me.rainssong.display 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * @date 2016/6/11 4:47
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class DisplayCore 
	{
		
		public function DisplayCore() 
		{
			
		}
		
		
		static public function remove(child:DisplayObject):Boolean
		{
			if (child.parent)
			{
				child.parent.removeChild(child);
				return true;
			}
			else
			return false;
		}
		
		static public function moveWithPosition(targetView:DisplayObject,to:DisplayObjectContainer):void
		{
			if (targetView.parent != null)
			{
				var p:Point = new Point(targetView.x, targetView.y);
				p = targetView.parent.localToGlobal(p);
				p = to.globalToLocal(p);
				targetView.x = p.x;
				targetView.y = p.y;
			}
			
			to.addChild(targetView);
		}
		
		static public function findChildByClass(base:DisplayObjectContainer,cls:Class):DisplayObject
		{
			var result:Array = getChildren(base);
			while (result.length)
			{
				var d:DisplayObject = result.pop();
				if (d as cls)
				{
					return d;
				}
				
				if (d as DisplayObjectContainer)
				{
					result = result.concat(getChildren(d as DisplayObjectContainer));
				}
			}
			
			return null;
		}
		
		static public function findChildByClassName(base:DisplayObjectContainer,clsName:*):DisplayObject
		{
			var result:Array = getChildren(base);
			while (result.length)
			{
				var d:DisplayObject = result.pop();
				if (getQualifiedClassName(d).indexOf(clsName)>=0)
				{
					return d;
				}
				
				if (d as DisplayObjectContainer)
				{
					result = result.concat(getChildren(d as DisplayObjectContainer));
				}
			}
			
			return null;
		}
		
		static public function getChildren(d:DisplayObjectContainer):Array
		{
			var searchArr:Array=[];
			for (var i:int = 0; i < d.numChildren; i++) 
			{
				searchArr.push(d.getChildAt(i));
			}
			
			return searchArr;
		}
		
	}

}