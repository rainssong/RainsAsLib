package com.codeTooth.actionscript.adt.quadTree
{
	import com.codeTooth.actionscript.lang.exceptions.IllegalOperationException;
	import com.codeTooth.actionscript.lang.exceptions.NullPointerException;
	import com.codeTooth.actionscript.lang.utils.destroy.DestroyUtil;
	import com.codeTooth.actionscript.lang.utils.destroy.IDestroy;
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	public class QuadTree implements IDestroy
	{
		private var _mainNode:Node = null;
		
		private var _treeDepth:uint = 0;
		
		private var _tempDisplayObjects:Vector.<DisplayObject> = null;
		
		private var _tempRect:Rectangle = null;
		
		private var _tempNodes:Vector.<Node> = null;
		
		private var _displayObjects:Vector.<DisplayObject> = null;
		
		public function QuadTree(viewRect:Rectangle, treeDepth:uint = 6)
		{
			if(viewRect == null)
			{
				throw new NullPointerException("Null viewRect");
			}
			
			_mainNode = new Node(viewRect);
			_treeDepth = treeDepth;
			_tempDisplayObjects = new Vector.<DisplayObject>();
			_tempNodes = new Vector.<Node>();
			_tempRect = new Rectangle();
			_displayObjects = new Vector.<DisplayObject>();
			createTree(_mainNode, 0);
		}
		
		public function addDisplayObject(object:DisplayObject):DisplayObject
		{
			return addRemoveExecute(object, true);
		}
		
		public function removeDisplayObject(object:DisplayObject):DisplayObject
		{
			return addRemoveExecute(object, false);
		}
		
		public function getDisplayObjects(x:Number, y:Number, width:Number, height:Number):Vector.<DisplayObject>
		{
			_tempRect.x= x;
			_tempRect.y = y;
			_tempRect.width = width;
			_tempRect.height = height;
			
			_tempNodes.length = 0;
			_tempNodes.push(_mainNode);
			var tempNodesLength:uint = 1;
			
			_displayObjects.length = 0;
			
			while(true)
			{
				var node:Node = _tempNodes.pop();
				tempNodesLength--;
				
				if(node.getViewRect().intersects(_tempRect))
				{
					if(node.isLeafNode())
					{
						var objects:Dictionary = node.getDisplayObjects();
						for each(var object:DisplayObject in objects)
						{
							_displayObjects.push(object);
						}
					}
					else
					{
						var childrenNodes:Vector.<Node> = node.getChildrenNodes();
						for each(node in childrenNodes)
						{
							_tempNodes.push(node);
							tempNodesLength++;
						}
					}
				}
				
				if(tempNodesLength == 0)
				{
					break;
				}
			}
			
			return _displayObjects;
		}
		
		private function addRemoveExecute(object:DisplayObject, isAdd:Boolean):DisplayObject
		{
			if(object == null)
			{
				throw new NullPointerException("Null object");
			}
			
			if(!_mainNode.getViewRect().contains(object.x, object.y))
			{
				return null;
			}
			
			var currNode:Node = _mainNode;
			while(true)
			{
				for(var i:uint = 0;i < Node.NUM_CHILDREN_NODES; i++)
				{
					var childNode:Node = currNode.getChildNode(i);
					if(childNode.isLeafNode())
					{
						if(isAdd)
						{
							childNode.addDisplayObject(object);
							return object;
						}
						// isRemove
						else
						{
							if(childNode.containsDisplayObject(object))
							{
								childNode.removeDisplayObject(object);
								return object;
							}
							else
							{
								return null;
							}
						}
					}
					else
					{
						if(childNode.getViewRect().contains(object.x, object.y))
						{
							currNode = childNode;
							break;
						}
					}
				}
			}
			
			throw new IllegalOperationException("Illegal run to this step");
			return null;
		}
		
		private function createTree(parentNode:Node, depthCount:uint):void
		{
			if(depthCount++ >= _treeDepth)
			{
				return;
			}
			else
			{
				for(var i:uint = 0; i < Node.NUM_CHILDREN_NODES; i++)
				{
					var parentViewRect:Rectangle = parentNode.getViewRect();
					var cellWidth:Number = parentViewRect.width * .5;
					var cellHeight:Number = parentViewRect.height * .5;
					var viewRect:Rectangle = new Rectangle(
						parentViewRect.x + (i == 0 || i == 2 ? 0 : 1) * cellWidth, 
						parentViewRect.y + (i == 0 || i == 1 ? 0 : 1) * cellHeight, 
						cellWidth, cellHeight
					);
					
					var node:Node = new Node(viewRect);
					parentNode.setChildNode(i, node);
					node.setParentNode(parentNode);
					createTree(node, depthCount);
				}
			}
		}
		
		//----------------------------------------------------------------------------------------------------------------------------------
		// 实现 IDestroy 接口
		//----------------------------------------------------------------------------------------------------------------------------------
		
		public function destroy():void
		{
			DestroyUtil.destroyObject(_mainNode);
			_mainNode = null;
			
			DestroyUtil.breakVector(_tempDisplayObjects);
			_tempDisplayObjects = null;
			
			DestroyUtil.breakVector(_tempNodes);
			_tempNodes = null;
			
			_tempRect = null;
			
			DestroyUtil.breakVector(_displayObjects);
			_displayObjects = null;
		}
	}
}