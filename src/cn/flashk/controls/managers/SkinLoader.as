package cn.flashk.controls.managers
{
	import cn.flashk.controls.skin.SkinThemeColor;
	import cn.flashk.conversion.ColorConversion;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.utils.getDefinitionByName;

	public class SkinLoader
	{
		public static const eventDispatcher:EventDispatcher = new EventDispatcher();
		public static var isSelfFile:Boolean = false;
		private static var ldr:Loader;
		
		public function SkinLoader()
		{
		}
		public static function loadSkinFile(path:String):void{
			ldr = new Loader();
			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE,initSkinSet);
			ldr.load(new URLRequest(path));
		}
		public static function getClassFromSkinFile(name:String):Class{
			try{
				if(isSelfFile == false){
					return ldr.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
				}
				return getDefinitionByName(name) as Class;
			}catch(e:Error){
				
			}
			return null;
		}
		public static function getBitmapData(name:String):BitmapData{
			var classRef:Class;
			try{
				if(isSelfFile == false){
					classRef =  ldr.contentLoaderInfo.applicationDomain.getDefinition(name) as Class;
				}else{
					classRef =  getDefinitionByName(name) as Class;
				}
				var dis:DisplayObject = new classRef() as DisplayObject;
				var bd:BitmapData = new BitmapData(dis.width,dis.height,true,0);
				bd.draw(dis);
				return bd;
			}catch(e:Error){
				
			}
			return null;
		}
		public static function setSkinStyle(xml:XML):void{
			DefaultStyle.buttonOutTextColor = xml.buttonTextColor;
			DefaultStyle.buttonOverTextColor = xml.buttonOverTextColor;
			DefaultStyle.buttonDownTextColor = xml.buttonPressTextColor;
			DefaultStyle.menuBackgroundColor = xml.menuBackgroundColor;
			SkinThemeColor.border = ColorConversion.transformWebColor(xml.borderColor);
		}
		protected static function initSkinSet(event:Event):void
		{
			SkinManager.isUseDefaultSkin = false;
			var obj:Object = ldr.content;
			var xml:XML = obj.skinSet as XML;
			setSkinStyle(xml);
			eventDispatcher.dispatchEvent(new Event("skinLoaded"));
			isSelfFile = false;
		}
	}
}