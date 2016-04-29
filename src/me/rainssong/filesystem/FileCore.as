package me.rainssong.filesystem
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	import me.rainssong.utils.StringCore;
	
	/**
	 * ...
	 * @author Rainssong
	 */
	public class FileCore
	{
		static public const BYTE_ARRAY:String = "byteArray";
		static public const MULTI_BYTE:String = "multiByte";
		static public const BYTE:String = "byte";
		static public const BOOLEAN:String = "boolean";
		static public const FLOAT:String = "float";
		static public const DOUBLE:String = "double";
		static public const INT:String = "int";
		static public const OBJECT:String = "object";
		static public const SHORT:String = "short";
		static public const UNSIGNED_INT:String = "unsignedInt";
		
		public function FileCore()
		{
		
		}
		
		
		//public static function createFile(content:String, url:String = null):File
		//{
			//var file:File = url ? File.applicationStorageDirectory.resolvePath(url) : File.createTempFile();
			//file.parent.createDirectory();
			//var stream:FileStream = new FileStream());
			//stream.open(file, FileMode.WRITE);
			//stream.writeMultiByte(content, 'utf-8');
		//
			//stream.close();
			//return file;
		//}
		
		
		public static function createFile(content:*,type:String="byteArray", url:String = null,options:Object=null):File
		{
			options ||= { };
			var file:File = url? new File(url) : File.createTempFile();
			file.parent.createDirectory();
			var stream:FileStream = new FileStream();
			var fileMode:String = FileMode.WRITE;
			if(options["fileMode"]!=null)fileMode=options["fileMode"]
			stream.open(file, fileMode);
			
			switch (type) 
			{
				case "byteArray":
					//powerTrace(0 || options["offset"], 0 || options["length"]);
					stream.writeBytes(content,0,0);
				break;
				case "multiByte":
					stream.writeMultiByte(content, options["charSet"] || "utf-8");
				break;
				case "byte":
					stream.writeByte(content);
				break;
				case "boolean":
					stream.writeBoolean(content);
				break;
				case "float":
					stream.writeFloat(content);
				break;
				case "double":
					stream.writeDouble(content);
				break;
				case "int":
					stream.writeInt(content);
				break;
				case "object":
					stream.writeObject(content);
				break;
				case "short":
					stream.writeShort(content);
				break;
				case "unsignedInt":
					stream.writeUnsignedInt(content);
				break;
				
				default:
			}
			
			stream.close();
			return file;
		}
		
		public static function getVideoHtml(videoURL:String, width:String="100%", height:String="100%"):String
		{
			var str:String = "<!DOCTYPE HTML/><html><head><meta charset='UTF-8'/> <meta name='viewport' content='user-scalable=no, width="
			str += width
			str += ", height="
			str += height
			str += ", initial-scale=1.0, maximum-scale=1.0'/></head><body><video id='introVid' width='"
			str += width
			str += "' height='"
			str += height
			str += "' controls autoplay> <source id='videoScurce'  src='"
			str += videoURL
			str += "' type='video/mp4' ></source>Play Video Error! </video></body></html>";
			return str;
		}
	
		public static function getPdfHtml(pdfURL:String, width:String="100%", height:String="100%"):String
		{
			var str:String = "<html><body marginwidth='0' marginheight='0' style='background-color: rgb(38,38,38)'><embed width='"
			str += width;
			str += "'height ='";
			str += height;
			str += "'name = 'plugin' src ='";
			str += pdfURL;
			str += "'type='application/pdf'></body></html>";
			return str;
		}
		
		public static function webToStorage(url:String):File
		{
			return File.applicationStorageDirectory.resolvePath(StringCore.webToLocal(url));
		}
		
		static public function getAllFiles(file:File):Array 
		{
			var files:Array = file.getDirectoryListing();
			for (var i:int = 0; i < files.length; i++) 
			{
				var file2:File = files[i] as File;
				if (file2.isDirectory)
				{
					var arr:Array=getAllFiles(file2)
					files=files.concat(arr);
					//files.push.apply(null,arr);
				}
			}
			
			return files;
		}
		
		
		
	}
}