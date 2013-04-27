package me.rainssong.controls
{


	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import me.rainssong.display.SmartSprite;



	public class RainCheckBox extends Sprite implements IToggleBtn
	{
		private var _unselectView:DisplayObject;
		private var _selectView:DisplayObject;
		private var _selected:Boolean = false;
		
		
		
		public function RainCheckBox(unselectView:DisplayObject,selectView:DisplayObject,selected:Boolean=false)
		{
			// constructor code
			_unselectView = unselectView;
			_selectView = selectView;
			addChild(_unselectView);
			addChild(_selectView);
			
			this.selected = selected;
			
			this.addEventListener(MouseEvent.CLICK, onClick);
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemove);

		}
		
		

		protected function onClick(e:MouseEvent):void
		{
			switchStatus();
		}

		protected function onRemove(e:Event):void
		{
			_unselectView = null;
			_selectView = null;
			this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
			this.removeEventListener(MouseEvent.CLICK, onClick);
		}

		public function switchStatus():void
		{
			selected = !_selected;
		}


		public function select():void
		{
			selected = true;
		}
		
		public function unselect():void
		{
			selected = false;
		}

		public function get selected():Boolean
		{
			return _selected;
		}
		
		public function set selected(value:Boolean):void
		{
			_selected = value;
			_selectView.visible = value;
			_unselectView.visible = !value;
		}

		public function get label():String
		{
			if (["labelTF"])
			{
				return this["labelTF"].text;
			}
			else
			{
				return "";
			}
		}

		public function set label(content:String):void
		{
			if (["labelTF"])
			{
				this["labelTF"].text = content;
			}

		}


	}

}