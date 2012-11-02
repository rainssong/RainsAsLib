package me.rainssong.air 
{
	/**
	 * ...
	 * @author Rainssong
	 */
	public class AirManager 
	{
		public static var rotate
		
		public function AirManager() 
		{
			
		}
		
		
		
		
		private function onOrientationChange(event:StageOrientationEvent):void
		{
			
			switch (event.afterOrientation)
			{
				case StageOrientation.DEFAULT: 
					event.preventDefault();

					break;
				case StageOrientation.ROTATED_RIGHT: 

					break;
				case StageOrientation.ROTATED_LEFT:
					

					break;
				case StageOrientation.UPSIDE_DOWN: 
					event.preventDefault();

					break;
			}
		
		}
	}

}