package me.rainssong.math
{
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import me.rainssong.utils.DestroyUtil;
	import me.rainssong.utils.IDestroy;

	internal class Node implements IDestroy
	{
		public static const NUM_CHILDREN_NODES:uint = 4;
		
		private var _parentNode:Node = null;
		
		private var _viewRect:Rectangle = null;
		
		private var _childrenNodes:Vector.<Node> = null;
		
		private var _displayObjects:Dictionary/*key DiaplayObject, value DisplayObject*/ = null;
		
		public function Node(viewRect:Rectangle)
		{
			Assert.checkNull(viewRect);
			
			_viewRect = viewRect;
			_childrenNodes = new Vector.<Node>(NUM_CHILDREN_NODES);
			_displayObjects = new Dictionary();
		}
		
		public function isLeafNode():Boolean
		{
			return _childrenNodes == null || 
				(_childrenNodes[0] == null && _childrenNodes[1] == null && _childrenNodes[2] == null && _childrenNodes[3] == null);
		}
		
		public function setParentNode(node:Node):void
		{
			_parentNode = node;
		}
		
		public function getParentNode():Node
		{
			return _parentNode;
		}
		
		public function getViewRect():Rectangle
		{
			return _viewRect;
		}
		
		public function getChildNode(index:uint):Node
		{
			return _childrenNodes[index];
		}
		
		public function setChildNode(index:uint, node:Node):void
		{
			_childrenNodes[index] = node;
		}
		
		public function getChildrenNodes():Vector.<Node>
		{
			return _childrenNodes;
		}
		
		public function addDisplayObject(obj:DisplayObject):void
		{
			_displayObjects[obj] = obj;
		}
		
		public function removeDisplayObject(obj:DisplayObject):void
		{
			delete _displayObjects[obj];
		}
		
		public function containsDisplayObject(obj:DisplayObject):Boolean
		{
			return _displayObjects[obj] != null;
		}
		
		public function getDisplayObjects():Dictionary
		{
			return _displayObjects;
		}
		
		public function destroy():void
		{
			_parentNode = null;
			_viewRect = null;
			
			DestroyUtil.breakMap(_displayObjects);
			_displayObjects = null;
			
			DestroyUtil.destroyVector(_childrenNodes);
			_childrenNodes = null;
		}
		
	}
}