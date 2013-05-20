package cn.flashk.controls.support
{
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	public class BitmapDataText
	{
		public function BitmapDataText()
		{
		}
		public static  function encodeBitmapDataToText(bd:BitmapData,isAlpha:Boolean=true,isCompress:Boolean=true):String{
			trace(bd.width);
			var str:String;
			str = bd.width+",";
			str += bd.height+",";
			for(var y:int=0;y<bd.height;y++){
				for(var x:int=0;x<bd.width;x++){
					str += bd.getPixel32(x,y).toString(16)+",";
				}
			}
			str.toLocaleLowerCase();
			if(isCompress == true){
				str = str.split(",ff").join("x");
				str = str.split("ffffff").join("y");
				str = str.split("0,0,0,").join("z");
				str = str.split("ff").join("s");
				str = str.split("00").join("r");
			}
			var byteArray:ByteArray = new ByteArray();
			byteArray.writeUTFBytes(str);
			trace(byteArray.length);
			byteArray.compress();
			trace(byteArray.length);
			var a:String = byteArray.toString();
			
			trace(str);
			trace(a);
			
			var by2:ByteArray = new ByteArray();
			//by2.writeUTFBytes(a);
			//by2.uncompress();
			trace(by2.length);
			return str;
		}
		public static function decodeTextToBitmapData(text:String,isAlpha:Boolean = true,isCompress:Boolean = true):BitmapData{
			var str:String = text;
			var bd:BitmapData;
			if(isCompress == true){
				str = str.split("s").join("ff");
				str = str.split("r").join("00");
				str = str.split("x").join(",ff");
				str = str.split("y").join("ffffff");
				str = str.split("z").join("0,0,0,");
			}
			var data:Array = str.split(",");
			var wid:uint = uint(data[0]);
			var hei:uint = uint(data[1]);
			trace("BitmapDataText.decode图像宽高"+wid,hei);
			bd = new BitmapData(wid,hei,true,0x00FFFFFF);
			for(var y:int=0;y<hei;y++){
				for(var x:int=0;x<wid;x++){
					bd.setPixel32(x,y,uint(parseInt(data[y*wid+x+2],16)));
				}
			}
			//trace(str);
			return bd;
		}
	}
}