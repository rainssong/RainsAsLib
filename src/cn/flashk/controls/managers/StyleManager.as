package cn.flashk.controls.managers 
{
	/**
	 * ...
	 * @author flashk
	 */
	public class StyleManager 
	{
		
		public function StyleManager() 
		{
			
		}
		public static function setThemeGradientMode(value:uint):void {
			ThemesSet.GradientMode = value;
		}
		
	}

}