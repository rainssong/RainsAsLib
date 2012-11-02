package me.rainssong.air 
{
	/**
	 * ...
	 * @author Rainssong
	 */
	public class AirManager 
	{
		public static var rotateDefaultEnable:Boolean=true;
		public static var rotateRigthEnable:Boolean=true;
		public static var rotateLeftEnable:Boolean=true;
		public static var rotateUpsideDownEnable:Boolean=true;
		
		
		public function AirManager() 
		{
			
		}
		
		
		
		
		private function onOrientationChange(event:StageOrientationEvent):void
		{
			
			switch (event.afterOrientation)
			{
				case StageOrientation.DEFAULT: 
					if(rotateDefaultEnable)event.preventDefault();

					break;
				case StageOrientation.ROTATED_RIGHT: 
					if(rotateRigthEnable)event.preventDefault();
					break;
				case StageOrientation.ROTATED_LEFT:
					if(rotateLeftEnable)event.preventDefault();

					break;
				case StageOrientation.UPSIDE_DOWN: 
					if(rotateUpsideDownEnable)event.preventDefault();

					break;
			}
		
		}
	}

}