package me.rainssong.rainMVC.view
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.FocusEvent;
	import flash.text.TextField;
	import me.rainssong.rainMVC.view.Mediator;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class TipTextFieldMediator extends Mediator
	{
		private var _tipContent:String = "";
		//提示颜色
		private var _tipColor:uint = 0x000000;
		//内容颜色
		private var _contentColor:uint = 0x999999;
		private var _isFoucesed:Boolean = false;
		
		
		public function TipTextFieldMediator(view:DisplayObject)
		{
			super(view);
		}
		
		override protected function onRegister():void
		{
			super.onRegister();
			myTextField.addEventListener(FocusEvent.FOCUS_IN, focusInHandler);
			myTextField.addEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
			_isFoucesed = false;

		}
		
		override public function destroy():void 
		{
			myTextField.removeEventListener(FocusEvent.FOCUS_IN, focusInHandler);
			myTextField.removeEventListener(FocusEvent.FOCUS_OUT, focusOutHandler);
			super.destroy();
		}
		
		public function setDefaultStyle(tipContent:String = "", contentColor:uint = 0x000000, tipColor:uint = 0x999999):void
		{
			_tipContent = tipContent;
			_contentColor = contentColor;
			_tipColor = tipColor;
			myTextField.text = "";
			refreash();
			//if (myTextField.stage.focus == myTextField) trace("!!!");
		}
		
		public function refreash():void
		{
			_isFoucesed?focusInHandler():focusOutHandler();
		}
		
		private function focusOutHandler(e:FocusEvent=null):void
		{
			if (myTextField.text == "")
			{
				myTextField.textColor = _tipColor;
				myTextField.text = _tipContent;
			}
			_isFoucesed = false;
		}
		
		private function focusInHandler(e:FocusEvent=null):void
		{
			if (myTextField.text == _tipContent && myTextField.textColor == _tipColor  )
			{
				myTextField.text = "";
				
			}
			myTextField.textColor = _contentColor;
			_isFoucesed = true;
		}
		
		public function get myTextField():TextField
		{
			return _viewComponent as TextField;
		}
		
		public function get text():String
		{
			if (myTextField.text == _tipContent && myTextField.textColor == _tipColor)
			{
				return "";
			}
			return myTextField.text as String;
		}
		
		public function get isFoucesed():Boolean 
		{
			return _isFoucesed;
		}
		
		
		public function get tipColor():uint 
		{
			return _tipColor;
		}
		
	
		public function get contentColor():uint 
		{
			return _contentColor;
		}
		
		public function get tipContent():String 
		{
			return _tipContent;
		}
		
		
	
	
	}

}