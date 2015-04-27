package me.rainssong.tools 
{
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOptions;
	import flash.printing.PrintUIOptions;
	
	/**
	 * @date 2015/4/17 6:59
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class SimplePrinter 
	{
		
		public function SimplePrinter() 
		{
			
		}
		
		static public function startPrint(content:Sprite,orientation:String=PrintJobOrientation.LANDSCAPE):void 
		{
			var myPrintJob:PrintJob = new PrintJob();
			var uiOptions:PrintUIOptions = new PrintUIOptions();
			
			//含bitmap则必须设置PrintJobOptions
			var printJobOptions:PrintJobOptions = new PrintJobOptions(true);
			
			var originScale:Number = content.scaleX;
			
			myPrintJob.orientation = orientation;
			
			var scaleXY:Number = Math.min(myPrintJob.pageWidth / content.width, myPrintJob.pageHeight / content.height);
			content.scaleX = content.scaleY = scaleXY;
			
			if (myPrintJob.start2(null,false))
			{
				try
				{
					myPrintJob.addPage(content,null,printJobOptions); 
				}
				catch (e:Error)
				{
					powerTrace(e);
				}
				myPrintJob.send();
			}
			
			content.scaleX = content.scaleY = originScale;
		}
		
	}

}