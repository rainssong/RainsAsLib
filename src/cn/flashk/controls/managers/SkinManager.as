package cn.flashk.controls.managers 
{
	import cn.flashk.controls.support.UIComponent;
	/**
	 * ...
	 * @author flashk
	 */
	public class SkinManager 
	{
		public static var isUseDefaultSkin:Boolean = true;
		
		public function SkinManager() 
		{
			
		}
		public static function loadNewSkin(skinFileURL:String):void {
			
		}
		public static function updateAllComponentsSkin():void {
			for (var i:int = 0; i < ComponentsManager.allRefs.length; i++) {
				UIComponent(ComponentsManager.allRefs[i]).updateSkin();
			}
		}
		/**
		 * 使用SWF文件本身的Skin主题，这样可以在单个的swf文件内使用位图Skin，使仅有一个文件的swf同时使用和外部skin文件一样的效果
		 * 
		 * @see #setSkinStyle()
		 */ 
		public static function useSelfFileSkin():void{
			SkinLoader.isSelfFile = true;
			isUseDefaultSkin = false;
		}
		/**
		 * 当使用自身文件的皮肤时，设定皮肤的文字颜色的样式。具体xml的内容参见位图皮肤XML设定部分
		 * 
		 * @see #useSelfFileSkin()
		 */ 
		public static function setSkinStyle(xml:XML):void{
			SkinLoader.setSkinStyle(xml);
		}
	}

}