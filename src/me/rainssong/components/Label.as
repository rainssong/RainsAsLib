package me.rainssong.components 
{
	import flash.text.TextField;
	/**
	 * ...
	 * @author Rainssong
	 * @timeStamp 2013/12/10 16:16
	 * @blog http://blog.sina.com.cn/rainssong
	 */
	public class Label extends Component 
	{
		protected var _tf:TextField;
		public function Label() 
		{
			super();
			this.mouseChildren = false;
			addChild(_tf);
			_tf.defaultTextFormat = Style.TEXT_FORMAT;
		}
		
		/* DELEGATE flash.text.TextField */
		
		public function get text():String 
		{
			return _tf.text;
		}
		
		public function set text(value:String):void 
		{
			_tf.text = value;
		}
		
		public function get textColor():uint 
		{
			return _tf.textColor;
		}
		
		public function set textColor(value:uint):void 
		{
			_tf.textColor = value;
		}
		
	}

}