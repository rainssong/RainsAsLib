package me.rainui.managers 
{
	import adobe.utils.CustomActions;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import me.rainssong.display.DisplayCore;
	import me.rainssong.utils.Draw;
	import me.rainssong.utils.ScaleMode;
	import me.rainui.RainUI;
	import me.rainui.components.Container;
	import me.rainui.components.DisplayResizer;
	import me.rainui.components.Page;
	
	/**
	 * @date 2015/9/19 2:52
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class PopUpManager 
	{
		static private var _root:DisplayObjectContainer
		private var _overlayView:DisplayObject
		private var _pop:DisplayObject
		
		public function PopUpManager() 
		{
			
		}
		
		static public function addPopUp(popUp:DisplayObject, isModal:Boolean = true, isCentered:Boolean = true):PopUpManager
		{
			var m:PopUpManager = new PopUpManager()
			m.addPopUp(popUp, isModal, isCentered);
			return m;
		}
		
		public function addPopUp(popUp:DisplayObject, isModal:Boolean = true, isCentered:Boolean = true):DisplayObject
		{
			
			if (_root == null)
			{
				_root = RainUI.stage;
			}
			
			if (_root == null)
			{
				powerTrace("no root");
				return null;
			}
			
			if(isModal)
			{
				if(_overlayView == null)
				{
					var p:Page = new Page();
					//var c:Container = new Container({width:100,height:100});
					//c.graphics.beginFill(0, 0.4);
					//c.graphics.drawRect(0, 0, 100, 100);
					//shape.addChild(c)
					
					var b:Bitmap = new Bitmap(new BitmapData(100, 100, true, 0x66000000));
					var dr:DisplayResizer = new DisplayResizer(b, {percentWidth:1, percentHeight:1});
					dr.contentScaleMode=ScaleMode.EXACT_FIT
					p.addChild(dr);
					
					var shape:Shape = new Shape();
					shape.graphics.beginFill(0, 1);
					shape.graphics.drawRect(0, 0, 80, 80);
					shape.cacheAsBitmap = true;
					shape.alpha = 0.4;
					//p.bgSkin.visible =shape;
					
					_overlayView = p;
				}
				
				//_overlayView.width = _root.stage.stageWidth;
				//_overlayView.height =_root.stage.stageHeight;
				_root.addChild(_overlayView);
				//this._popUpToOverlay[popUp] = overlay;
			}
			

			//this._popUps.push(popUp);
			_root.addChild(_pop=popUp);
			popUp.addEventListener(Event.REMOVED_FROM_STAGE, popUp_removedFromStageHandler,false,16);
			
			//if(this._popUps.length == 1)
			//{
				//this._root.stage.addEventListener(ResizeEvent.RESIZE, stage_resizeHandler);
			//}

			//if(FocusManager.isEnabled && popUp is DisplayObjectContainer)
			//{
				//this._popUpToFocusManager[popUp] = new FocusManager(DisplayObjectContainer(popUp));
			//}

			if(isCentered)
			{
				//if(popUp is IFeathersControl)
				//{
					//popUp.addEventListener(FeathersEventType.RESIZE, popUp_resizeHandler);
				//}
				//this._centeredPopUps.push(popUp);
				centerPopUp(popUp);
			}

			return popUp;
		
		}
		
		static public function centerPopUp(popUp:DisplayObject):void
		{
			var stage:Stage = _root.stage;
			popUp.x = (stage.stageWidth - popUp.width) / 2;
			popUp.y = (stage.stageHeight - popUp.height) / 2;
		}
		
		
		public function removePop()
		{
			
		}
		
		/**
		 * @private
		 */
		private function popUp_removedFromStageHandler(event:Event):void
		{
			var popUp:DisplayObject = DisplayObject(event.currentTarget);
			popUp.removeEventListener(Event.REMOVED_FROM_STAGE, popUp_removedFromStageHandler);
			_pop = null;
			//var index:int = this._popUps.indexOf(popUp);
			//this._popUps.splice(index, 1);
			//var overlay:DisplayObject = DisplayObject(this._popUpToOverlay[popUp]);
			if(_overlayView && _overlayView.parent)
			{
				_overlayView.parent.removeChild(_overlayView);
				//delete _popUpToOverlay[popUp];
			}
			
			
			
			//var focusManager:IFocusManager = this._popUpToFocusManager[popUp];
			//if(focusManager)
			//{
				//delete this._popUpToFocusManager[popUp];
				//FocusManager.removeFocusManager(focusManager);
			//}
			//index = this._centeredPopUps.indexOf(popUp);
			//if(index >= 0)
			//{
				//if(popUp is IFeathersControl)
				//{
					//popUp.removeEventListener(FeathersEventType.RESIZE, popUp_resizeHandler);
				//}
				//this._centeredPopUps.splice(index, 1);
			//}

			//if(_popUps.length == 0)
			//{
				//this._root.stage.removeEventListener(ResizeEvent.RESIZE, stage_resizeHandler);
			//}
		}
		
		static public function get root():DisplayObjectContainer 
		{
			return _root;
		}
		
		static public function set root(value:DisplayObjectContainer):void 
		{
			_root = value;
		}
		
		public function get isActive():Boolean
		{
			return _pop != null;
		}
		
	}

}