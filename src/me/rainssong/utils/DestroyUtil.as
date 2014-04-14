package me.rainssong.utils
{		
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.net.URLLoader;
	import flash.utils.ByteArray;

	/**
	 * 销毁对象助手 。
	 */
	public class DestroyUtil
	{
		/**
		 * 销毁方法名。
		 */
		public static var DestroyMethodName:String = "destroy";
		
		/**
		 * 销毁指定的对象。
		 * 如果对象实现了 IDestroy 接口，调用接口方法。
		 * 如果对象中有 destroyMethodName 方法，调用该方法。
		 * 如果对象是影片剪辑，停止播放。
		 * 如果对象是位图，调用位图的 destroy 方法。
		 * 如果对象是 loader，尝试关闭流，调用 unloadAndStop 方法。
		 * 
		 * @param object 销毁的对象。
		 */		
		public static function destroyObject(object:Object):void
		{	
			if(object != null)
			{
				if(object is IDestroy)
				{
					object.destroy();
				}
				else if(object is URLLoader)
				{
					try
					{
						object.close();
					} 
					catch(error:Error) 
					{
						// Do nothing
					}
				}
				else if (object is Loader)
				{
					try
					{
						object.close();
					}
					catch (error:Error)
					{
						// Do nothing
					}
					object.unloadAndStop();
				}
				else if (object is Bitmap)
				{
					if (object.bitmapData != null)
					{
						object.bitmapData.dispose();
						object.bitmapData = null;
					}
				}
				else if (object is BitmapData)
				{
					object.dispose();
				}
				else if (object is MovieClip)
				{
					object.stop();
				}
				else if(object is ByteArray)
				{
					object.clear();
				}
				else if (DestroyMethodName in object)
				{
					object[DestroyMethodName]();
				}
				else
				{
					// Do nothing
				}
			}
		}
		
		/**
		 * 销毁数组。
		 * 
		 * @param array 要销毁的数组。
		 * 
		 * @return	 返回入参。
		 */		
		public static function destroyArray(array:Array):Array
		{
			if (array != null)
			{
				var length:int = array.length;
				
				for(var i:int = length - 1; i >= 0; i--)
				{
					destroyObject(array[i]);
					array[i] = null;
				}
				
				array.length = 0;
			}
			
			return array;
		}
		
		/**
		 * 销毁键值map。
		 * 
		 * @param map	指定销毁的map。
		 * 
		 * @return 返回入参。
		 */		
		public static function destroyMap(map:Object):Object
		{
			if (map != null)
			{
				for(var key:Object in map)
				{
					destroyObject(map[key]);
					destroyObject(key);
					delete map[key];
				}
			}
			
			return map;
		}
		
		/**
		 * 断开数组和每个元素之间的引用。
		 * 
		 * @param array 指定操作的数组。
		 * 
		 * @return 返回入参。
		 */		
		public static function breakArray(array:Array):Array
		{
			if (array != null)
			{
				var length:int = array.length;
				
				for(var i:int = 0; i < length; i++)
				{
					array[i] = null;
				}
				
				array.length = 0;
			}
			
			return array;
		}
		
		/**
		 * 断开map与每个元素之间的引用。
		 * 
		 * @param map 指定操作的map。
		 */		
		public static function breakMap(map:Object):Object
		{
			if (map != null)
			{
				for(var key:Object in map)
				{
					delete map[key];
				}
			}
			
			return map;
		}
		
		/**
		 * 移除并销毁容器中所有的显示对象。
		 * 
		 * @param	container
		 * 
		 * @return	 返回入参。
		 */
		public static function removeDestroyChildren(container:DisplayObjectContainer):DisplayObjectContainer
		{
			if(container != null)
			{
				var numberChildren:int = container.numChildren;
				
				for (var i:int = 0; i < numberChildren; i++) 
				{
					destroyObject(container.removeChildAt(0));
				}
			}
			
			return container;
		}
		
		/**
		 * 删除容器中的所有内容
		 * 
		 * @param	container
		 * 
		 * @return
		 */
		public static function removeChildren(container:DisplayObjectContainer):DisplayObjectContainer
		{
			if (container != null)
			{
				var numberChildren:int = container.numChildren;
				
				for (var i:int = 0; i < numberChildren; i++) 
				{
					container.removeChildAt(0);
				}
			}
			
			return container;
		}
		
		public static function addChild(child:DisplayObject, parent:DisplayObjectContainer, index:int = -1, addRepeating:Boolean = false):void
		{
			if(child == null || parent == null)
			{
				return;
			}
			
			if(child.parent != parent || (child.parent == parent && addRepeating))
			{
				if(index == -1)
				{
					parent.addChild(child);
				}
				else
				{
					parent.addChildAt(child, index);
				}
			}
		}
		
		public static function removeChild(child:DisplayObject, parent:DisplayObjectContainer):void
		{
			if(child == null || parent == null)
			{
				return;
			}
			
			if(child.parent == parent)
			{
				parent.removeChild(child);
			}
		}
		
		/**
		 * 断开 Vector 对象和每个元素之间的引用
		 * 
		 * @param	v
		 * 
		 * @return
		 */
		public static function breakVector(v:Object):Object
		{
			if (v != null)
			{
				var length:int = v.length;
				for (var i:int = 0; i < length; i++)
				{
					v[i] = null;
				}
				v.length = 0;
				
				return v;
			}
			else
			{
				return null;
			}
		}
		
		/**
		 * 销毁 Vector 中的每一个元素
		 * 
		 * @param	v
		 * 
		 * @return
		 */
		public static function destroyVector(v:Object):Object
		{
			if (v != null)
			{
				var length:int = v.length;
				for (var i:int = 0; i < length; i++)
				{
					destroyObject(v[i]);
					v[i] = null;
				}
				v.length = 0;
				
				return v;
			}
			else
			{
				return null;
			}
		}
	}
}