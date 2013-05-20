package cn.flashk.controls
{
	import cn.flashk.layout.Align;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.modeStyles.LayoutStyle;
	import cn.flashk.controls.skin.ActionDrawSkin;
	import cn.flashk.controls.skin.ImageSkin;
	import cn.flashk.controls.skin.sourceSkin.ImageSourceSkin;
	import cn.flashk.controls.support.UIComponent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	/**
	 * 图像和边框的边距，默认3px，单位：像素
	 *
	 * @default 3
	 *
	 * @langversion 3.0
	 * @playerversion Flash 9.0
	 */
	[Style(name="padding", type="Number", format="单位：像素")]
	
	/**
	 * Image用来显示一张图像，这个图像可以是一个外部文件、库链接或者原始的BitmapData二进制数据
	 *  
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */

	public class Image extends UIComponent
	{
		/**
		 * 对于大于组件设定宽高的图片，加载后是否缩小以完整显示在容器中，默认缩小
		 */ 
		public var scaleContent:Boolean = true;
		/**
		 * 对于小于组件设定宽高的图片，加载后是否放大填满容器，默认不放大，1:1显示
		 */ 
		public var zoomInContent:Boolean = false;
		/**
		 * 图片是否启用平滑缩放，默认关闭，对于需要缩放的图像，请将此值设为true以获得更好的显示效果
		 */ 
		public var smoothing:Boolean = false; 
		
		protected var ldr:Loader;
		protected var _source:Object;
		protected var bp:Bitmap;
		protected var _clip:Boolean = true;
		
		/**
		 * 创建一个Image组件实例
		 */ 
		public function Image()
		{
			super();
			_compoWidth = 100;
			_compoHeight = 100;
			
			//边距
			styleSet[LayoutStyle.PADDING] = 5;
			
			setSize(_compoWidth, _compoHeight);
		}
		/**
		 * Image 图像的源，可以是一个外部文件、库链接或者原始的BitmapData二进制数据
		 * 
		 * @param value 支持3种格式：外部文件的相对/绝对地址(type:String)、swf文件的库链接名(type:Class)、未压缩的图像二进制数据(type:BitmapData)
		 */ 
		public function set source(value:Object):void{
			_source = value;
			if(value is String){
				loadFile(_source as String);
			}
			if(value is Class){
				var bd:BitmapData = new value() as BitmapData;
				if(bd != null){
					bp = new Bitmap(bd);
					this.addChild(bp);
					alignBP();
				}
			}
			if(value is BitmapData){
				bp = new Bitmap(value as BitmapData);
				this.addChild(bp);
				alignBP();
			}
		}
		public function get source():Object{
			return _source;
		}
		/**
		 * 对于大于组件宽高并且没有设置缩放图像到组件大小的图像是否启用裁剪。组件之外的显示区域将被裁剪，默认true，若要显示完整图像，请将此值设为true(会遮盖边框)
		 */ 
		public function set clip(value:Boolean):void{
			_clip = value;
			
			if(bp != null){
				if(_clip == true){
					bp.scrollRect = new Rectangle(0,0,_compoWidth-styleSet[LayoutStyle.PADDING]*2,_compoHeight-styleSet[LayoutStyle.PADDING]*2);
				}else{
					bp.scrollRect = null;
				}
			}
		}
		public function get clip():Boolean{
			return _clip;
		}
		/**
		 * 设置Image组件边框的透明度，默认1，不透明
		 */ 
		public function set backgroundAlpha(value:Number):void{
			if(skin is ActionDrawSkin){
				skin.skinDisplayObject.alpha = value;
			}else{
				DisplayObject(skin).alpha = value;
			}
		}
		override public function setDefaultSkin():void {
			setSkin(ImageSkin)
		}
		override public function setSourceSkin():void {
			setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.IMAGE));
		}
		override public function setSkin(Skin:Class):void {
			if(SkinManager.isUseDefaultSkin == true){
				skin = new Skin();
				ActionDrawSkin(skin).init(this,styleSet);
			}else{
				var sous:ImageSourceSkin = new ImageSourceSkin();
				sous.init(this,styleSet,Skin);
				skin = sous;
			}
		}
		protected function loadFile(filePath:String):void{
			ldr = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE,getLoaderBitmap);
			ldr.load(new URLRequest(filePath));
		}
		
		protected function getLoaderBitmap(event:Event):void
		{
			bp = ldr.content as Bitmap;
			alignBP();
			this.addChild(bp);
		}
		protected function alignBP():void{
			bp.smoothing = smoothing;
			var maxW:Number = _compoWidth - styleSet[LayoutStyle.PADDING]*2;
			var maxH:Number = _compoHeight - styleSet[LayoutStyle.PADDING]*2;
			
			if(scaleContent == true && (bp.width>maxW || bp.height >maxH) ){
				if(bp.width/maxW > bp.height/maxH){
					bp.width = maxW;
					bp.scaleY = bp.scaleX;
				}else{
					bp.height = maxH;
					bp.scaleX = bp.scaleY;
				}
			}
			if(zoomInContent == true && (bp.width<maxW || bp.height <maxH)){
				if(bp.width/maxW > bp.height/maxH){
					bp.width = maxW;
					bp.scaleY = bp.scaleX;
				}else{
					bp.height = maxH;
					bp.scaleX = bp.scaleY;
				}
			}
			Align.alignToCenter(bp,_compoWidth,_compoHeight);
			if(scaleContent == false && (bp.width>maxW || bp.height >maxH) ){
				bp.x = styleSet[LayoutStyle.PADDING];
				bp.y = styleSet[LayoutStyle.PADDING];
				
				if(_clip == true){
					bp.scrollRect = new Rectangle(0,0,_compoWidth-styleSet[LayoutStyle.PADDING]*2,_compoHeight-styleSet[LayoutStyle.PADDING]*2);
				}else{
					bp.scrollRect = null;
				}
			}
		}
	}
}