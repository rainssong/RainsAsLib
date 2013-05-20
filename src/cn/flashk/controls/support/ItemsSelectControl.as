package cn.flashk.controls.support
{
	import cn.flashk.controls.List;
	import cn.flashk.controls.interfaces.IListItemRender;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/*
	*/
	public class ItemsSelectControl
	{
		private var view:List;
		private var p1:Point;
		private var p2:Point;
		private var sp:Shape;
		private var items:Sprite;
		private var isMutSelect:Boolean = false;
		
		public function ItemsSelectControl()
		{
		}
		/*
		*/
		public function initViewPanel(
			viewBox:List,itemsBox:Sprite):void
		{
			view = viewBox;
			items = itemsBox;
			view.addEventListener(MouseEvent.MOUSE_DOWN, startShowBox);
		}
		/*
		*/
		public function selectAll():void
		{
			if(view.allowMultipleSelection == false) return;
			var fvItem:IListItemRender ;
			
			for(var i:int=0;i<items.numChildren;i++)
			{
				fvItem = items.getChildAt(i) as IListItemRender;
				fvItem.selected = true;
			}
		}
		/*
		*/
		public function selectNone():void
		{
			var fvItem:IListItemRender ;
			if(isMutSelect == true) return;
			for(var i:int=0;i<items.numChildren;i++)
			{
				fvItem = items.getChildAt(i) as IListItemRender;
				fvItem.selected = false;
			}
		}
		/*
		*/
		private function startShowBox(
			event:MouseEvent):void
		{
			if(view.allowMultipleSelection == false) return;
			if(view.mouseX > view.width-18) return;
			p1 = new Point(view.mouseX, view.mouseY);
			view.stage.addEventListener(MouseEvent.MOUSE_MOVE, showBox);
			view.stage.addEventListener(MouseEvent.MOUSE_UP, clearShow);
			sp = new Shape;
			//sp.x = view.x;
			//sp.y = view.y;
			view.addChild(sp);
			isMutSelect = false;
		}
		/*
		*/
		private function clearShow(
			event:MouseEvent):void
		{
			view.stage.removeEventListener(MouseEvent.MOUSE_UP, clearShow);
			view.stage.removeEventListener(MouseEvent.MOUSE_MOVE, showBox);
			showBox();
			var x1:Number = Math.min(p1.x, p2.x);
			var x2:Number = Math.max(p1.x, p2.x);
			var y1:Number = Math.min(p1.y, p2.y);
			var y2:Number = Math.max(p1.y, p2.y);
			
			//最小有效操作距离10，防止alt多选时鼠标抖动误操作
			if(Math.abs(x2-x1)<10 && Math.abs(y2-y1)<10)
			{
				
			}else
			{
				var fvItem:IListItemRender ;
				for(var i:int=0;i<items.numChildren;i++)
				{
					fvItem = items.getChildAt(i) as IListItemRender;
					if(DisplayObject(fvItem).hitTestObject(sp) == true)
					{
						fvItem.selected = true;
					}else
					{
						fvItem.selected = false;
					}
				}
				isMutSelect = true;
			}
			view.removeChild(sp);
		}
		/*
		*/
		private function showBox(
			event:MouseEvent=null):void
		{
			p2 = new Point(view.mouseX, view.mouseY);
			if(p2.x<0)
			{
				p2.x = 0;
			}
			if(p2.y <0){
				p2.y = 0;
			}
			drawBox(event);
		}
		/*
		*/
		private function drawBox(
			event:MouseEvent):void
		{
			var x1:Number = Math.min(p1.x, p2.x);
			var x2:Number = Math.max(p1.x, p2.x);
			var y1:Number = Math.min(p1.y, p2.y);
			var y2:Number = Math.max(p1.y, p2.y);
			
			sp.graphics.clear();
			sp.graphics.beginFill(0x0099FF, 0.3);
			sp.graphics.lineStyle(0.1, 0x0099FF);
			sp.graphics.drawRect(x1,y1, x2-x1, y2-y1);
		}
	}
}