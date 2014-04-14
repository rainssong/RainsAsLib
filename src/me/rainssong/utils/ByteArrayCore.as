package me.rainssong.utils 
{
	import com.adobe.crypto.MD5;
	import com.codeTooth.actionscript.lang.exceptions.NullPointerException;
	import com.codeTooth.actionscript.lang.exceptions.UnknownTypeException;
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	/**
	 * 字节数组助手
	 */
	public class ByteArrayCore 
	{	
		private static var _byteArray:ByteArray = new ByteArray();
		
		/**
		 * 把位图数据写入到字节数组的指定位置
		 * 
		 * @param	byteArray	要添加到的字节数组
		 * @param	index	指定的添加到的索引位置
		 * @param	bmpd	要添加的位图数据
		 * 
		 * @return	返回输入的字节数组
		 */
		public static function writeBitmapDataAt(byteArray:ByteArray, index:uint, bmpd:BitmapData = null):ByteArray
		{
			if (byteArray == null)
			{
				throw new NullPointerException("Null byteArray");
			}
			
			byteArray.position = index;
			// 第一位0，表示位图
			byteArray.writeByte(0);
			if (bmpd == null)
			{
				// 第二位0，表示没有位图数据，null
				byteArray.writeByte(0);
				return byteArray;
			}
			else
			{
				// 第二位1，表示有位图数据
				byteArray.writeByte(1);
				// 写入是否是透明
				byteArray.writeByte(bmpd.transparent ? 1 : 0);
				// 写入宽
				byteArray.writeUnsignedInt(bmpd.width);
				// 写入高
				byteArray.writeUnsignedInt(bmpd.height);
				// 写入位图数据
				var bmpdByteArray:ByteArray = bmpd.getPixels(bmpd.rect);
				byteArray.writeBytes(bmpdByteArray, 0, bmpdByteArray.length);
				
				return byteArray;
			}
		}
		
		/**
		 * 从字节数组的指定位置读取位图数据
		 * 
		 * @param	byteArray	指定的字节数组
		 * @param	index	指定的索引位置
		 * 
		 * @return	返回读取的位图数据
		 */
		public static function readBitmapDataAt(byteArray:ByteArray, index:uint):BitmapData
		{
			if (byteArray == null)
			{
				throw new NullPointerException("Null byteArray");
			}
			
			byteArray.position = index;
			// 第一位是0，表示是位图
			if (byteArray.readByte() != 0)
			{
				throw new UnknownTypeException("Illegal byteArray");
			}
			// 第二位是1，表示有位图数据
			if (byteArray.readByte() != 1)
			{
				return null;
			}
			// 读取是否透明
			var transparent:Boolean = byteArray.readByte() == 0 ? false : true;
			// 读取宽
			var width:int = byteArray.readUnsignedInt();
			// 读取高
			var height:int = byteArray.readUnsignedInt();
			// 创建位图
			var bmpd:BitmapData = new BitmapData(width, height, transparent, 0x00000000);
			var tempByteArray:ByteArray = new ByteArray();
			byteArray.readBytes(tempByteArray, tempByteArray.position, width * height * 4);
			bmpd.setPixels(bmpd.rect, tempByteArray);
			
			return bmpd;
		}
		
		/**
		 * 把多个位图写入到字节数组中
		 * 
		 * @param	byteArray
		 * @param	index
		 * @param	bmpds
		 * @return
		 */
		public static function writeBitmapDatasAt(byteArray:ByteArray, index:uint, bmpds:Vector.<BitmapData>):ByteArray
		{
			if (byteArray == null)
			{
				throw new NullPointerException("Null byteArray");
			}
			
			byteArray.position = index;
			// 第一位是0，表示是位图数组数据
			byteArray.writeByte(0);
			// 判断是不是null。是null的话，写入0，不是null写入1
			if (bmpds == null)
			{
				byteArray.writeByte(0);
				return byteArray;
			}
			else
			{
				byteArray.writeByte(1);
				// 写入位图个数
				byteArray.writeUnsignedInt(bmpds.length);
			}
			// 循环写入所有的位图
			for each(var bmpd:BitmapData in bmpds)
			{
				writeBitmapDataAt(byteArray, byteArray.position, bmpd);
			}
			
			return byteArray;
		}
		
		/**
		 * 从字节数组中读取多个位图
		 * 
		 * @param	byteArray
		 * @param	index
		 * @return
		 */
		public static function readBitmapDatasAt(byteArray:ByteArray, index:uint):Vector.<BitmapData>
		{
			if (byteArray == null)
			{
				throw new NullPointerException("Null byteArray");
			}
			
			byteArray.position = index;
			// 如果第一位是0，表示是位图数组
			if (byteArray.readByte() != 0)
			{
				throw new UnknownTypeException("Illegal byteArray");
			}
			// 读取byte，如果输是0，表示输入的时候是null
			if (byteArray.readByte() == 0)
			{
				return null;
			}
			else
			{
				// 读取位图数量
				var length:uint = byteArray.readUnsignedInt();
				var bmpds:Vector.<BitmapData> = new Vector.<BitmapData>(length);
				for (var i:uint = 0; i < length; i++)
				{
					bmpds[i] = readBitmapDataAt(byteArray, byteArray.position);
				}
				
				
				return bmpds;
			}
		}
		
		/**
		 * 向字节数组的指定位置中写入字节
		 * 
		 * @param	targetByteArray
		 * @param	srcByteArray
		 * @param	index
		 * 
		 * @return
		 */
		public static function writeByteArrayAt(targetByteArray:ByteArray, srcByteArray:ByteArray, index:uint):ByteArray
		{
			if (targetByteArray == null)
			{
				throw new NullPointerException("Null byteArray");
			}
			
			targetByteArray.position = index;
			targetByteArray.writeByte(0);
			if (srcByteArray == null)
			{
				targetByteArray.writeByte(0);
			}
			else
			{
				targetByteArray.writeByte(1);
				targetByteArray.writeUnsignedInt(srcByteArray.length);
				targetByteArray.writeBytes(srcByteArray, 0, srcByteArray.length);
			}
			
			return targetByteArray;
		}
		
		/**
		 * 从字节数组的指定位置读取字节
		 * 
		 * @param	srcByteArray
		 * @param	index
		 * 
		 * @return
		 */
		public static function readByteArrayAt(srcByteArray:ByteArray, index:uint):ByteArray
		{
			if (srcByteArray == null)
			{
				throw new NullPointerException("Null srcByteArray");
			}
			
			srcByteArray.position = index;
			
			if (srcByteArray.readByte() != 0)
			{
				throw new UnknownTypeException("Unknown byteArray");
			}
			if (srcByteArray.readByte() == 0)
			{
				return null;
			}
			else
			{
				var length:uint = srcByteArray.readUnsignedInt();
				var byteArray:ByteArray = new ByteArray();
				srcByteArray.readBytes(byteArray, 0, length);
				
				return byteArray;
			}
		}
		
		/**
		 * 向字节数组中的指定位置写入字符串
		 * 
		 * @param	byteArray
		 * @param	str
		 * @param	index
		 * 
		 * @return
		 */
		public static function writeStringAt(byteArray:ByteArray, str:String, index:uint):ByteArray
		{
			if (byteArray == null)
			{
				throw new NullPointerException("Null byteArray");
			}
			
			byteArray.position = index;
			byteArray.writeByte(0);
			if (str == null)
			{
				byteArray.writeByte(0);
				return byteArray;
			}
			else
			{
				byteArray.writeByte(1);
				byteArray.writeUTF(str);
				
				return byteArray;
			}
		}
		
		/**
		 * 从字节数组中的指定位置地区字符串
		 * 
		 * @param	byteArray
		 * @param	index
		 * 
		 * @return
		 */
		public static function readStringAt(byteArray:ByteArray, index:uint):String
		{
			if (byteArray == null)
			{
				throw new NullPointerException("Null byteArray");
			}
			
			byteArray.position = index;
			if (byteArray.readByte() != 0)
			{
				throw new UnknownTypeException("Unknown byteArray");
			}
			if (byteArray.readByte() == 0)
			{
				return null;
			}
			else
			{
				return byteArray.readUTF();
			}
		}
		
		/**
		 * 获得字符串在字节数组中的长度
		 * 
		 * @param str
		 * 
		 * @return 
		 */
		public static function getStringByteSize(str:String):uint
		{
			_byteArray.clear();
			writeStringAt(_byteArray, str, 0);
			var length:uint = _byteArray.length;
			_byteArray.clear();
			
			return length;
		}
		
		/**
		 * 向字节数组中写入一个矩形
		 * 
		 * @param byteArray
		 * @param rect
		 * @param index
		 * 
		 * @return 
		 */
		public static function writeRectangleAt(byteArray:ByteArray, rect:Rectangle, index:uint):ByteArray
		{
			if(byteArray == null)
			{
				throw new NullPointerException("Null byteArray");
			}
			
			byteArray.position = index;
			byteArray.writeByte(0);
			if(rect == null)
			{
				byteArray.writeByte(0);
				return byteArray;
			}
			else
			{
				byteArray.writeByte(1);
				byteArray.writeDouble(rect.x);
				byteArray.writeDouble(rect.y);
				byteArray.writeDouble(rect.width);
				byteArray.writeDouble(rect.height);
				
				return byteArray;
			}
		}
		
		/**
		 * 从字节数组中读取一个矩形
		 * 
		 * @param byteArray
		 * @param index
		 * 
		 * @return 
		 */
		public static function readRectangleAt(byteArray:ByteArray, index:uint):Rectangle
		{
			if(byteArray == null)
			{
				throw new NullPointerException("Null byteArray");
			}
			
			byteArray.position = index;
			if(byteArray.readByte() != 0)
			{
				throw new UnknownTypeException("Unknown byteArray");
			}
			if(byteArray.readByte() == 0)
			{
				return null;
			}
			else
			{
				return new Rectangle(byteArray.readDouble(), byteArray.readDouble(), byteArray.readDouble(), byteArray.readDouble());
			}
		}
		
		/**
		 * 向字节数组中写入一个点
		 * 
		 * @param byteArray
		 * @param point
		 * @param index
		 * 
		 * @return 
		 */
		public static function writePointAt(byteArray:ByteArray, point:Point, index:uint):ByteArray
		{
			if(byteArray == null)
			{
				throw new NullPointerException("Null byteArray");
			}
			
			byteArray.position = index;
			byteArray.writeByte(0);
			if(point == null)
			{
				byteArray.writeByte(0);
				return byteArray;
			}
			else
			{
				byteArray.writeByte(1);
				byteArray.writeDouble(point.x);
				byteArray.writeDouble(point.y);
				return byteArray;
			}
		}
		
		/**
		 * 从字节数组中读取一个点
		 * 
		 * @param byteArray
		 * @param index
		 * 
		 * @return 
		 */
		public static function readPointAt(byteArray:ByteArray, index:uint):Point
		{
			if(byteArray == null)
			{
				throw new NullPointerException("Null ByteArray");
			}
			
			byteArray.position = index;
			if(byteArray.readByte() != 0)
			{
				throw new UnknownTypeException("Unknown byteArray");
			}
			if(byteArray.readByte() == 0)
			{
				return null;
			}
			else
			{
				return new Point(byteArray.readDouble(), byteArray.readDouble());
			}
		}
		
		/**
		 * 判断是否是PNG图片
		 * 
		 * @param image
		 * 
		 * @return 
		 */
		public static function isPNG(image:ByteArray):Boolean
		{
			if(image == null)
			{
				return false;
			}
			else
			{
				image.position = 0;
				return image.readUnsignedByte() == 0x89 && image.readUnsignedByte() == 0x50 && image.readUnsignedByte() == 0x4E && 
					image.readUnsignedByte() == 0x47 && image.readUnsignedByte() == 0x0D && image.readUnsignedByte() == 0x0A && 
					image.readUnsignedByte() == 0x1A && image.readUnsignedByte() == 0x0A;
			}
		}
		
		/**
		 * 判断是否是JPG图片
		 * 
		 * @param image
		 * 
		 * @return 
		 */
		public static function isJPG(image:ByteArray):Boolean
		{
			if(image == null)
			{
				return false;
			}
			else
			{
				image.position = 0;
				return image.readUnsignedByte() == 0xFF && image.readUnsignedByte() == 0xD8;
			}
		}
		
		/**
		 * 读取PNG图片的尺寸
		 * 
		 * @param png
		 * 
		 * @return 
		 */
		public static function readPNGSize(png:ByteArray):Point
		{
			if(isPNG(png))
			{
				png.readUnsignedInt();
				png.readUnsignedInt();
				
				return new Point(png.readUnsignedInt(), png.readUnsignedInt());
			}
			else
			{
				return null;
			}
		}
		
		/**
		 * 读取JPG图片的尺寸
		 * 
		 * @param jpg
		 * 
		 * @return 
		 */
		public static function readJPGSize(jpg:ByteArray):Point
		{
			if(isJPG(jpg))
			{
				var width:uint = 0;
				var height:uint = 0;
				while(true)
				{
					var head:uint = (jpg.readUnsignedByte() << 8) + jpg.readUnsignedByte();
					if(head == 0xFFC0)
					{
						// length
						jpg.readUnsignedByte();
						jpg.readUnsignedByte();
						
						// precision
						jpg.readUnsignedByte();
						
						height = (jpg.readUnsignedByte() << 8) + jpg.readUnsignedByte();
						width = (jpg.readUnsignedByte() << 8) + jpg.readUnsignedByte();
						break;
					}
					else
					{
						var length:uint = (jpg.readUnsignedByte() << 8) + jpg.readUnsignedByte() - 2;
						for(var i:uint = 0; i < length; i++)
						{
							jpg.readUnsignedByte();
						}
					}
				}
				
				return new Point(width, height);
			}
			else
			{
				return null;
			}
		}
		
		/**
		 * 将tail指定的字节数组放到head指定的字节数组的后面，结果存在buffer中
		 * 
		 * @param buffer
		 * @param head
		 * @param tail
		 * @return 
		 */
		public static function hideTailBytes(buffer:ByteArray, head:ByteArray, tail:ByteArray):ByteArray
		{
			if(buffer == null)
			{
				throw new NullPointerException("Null buffer");
			}
			if(head == null)
			{
				throw new NullPointerException("Null head");
			}
			if(tail == null)
			{
				throw new NullPointerException("Null tail");
			}
			
			buffer.writeBytes(head, 0, head.length);
			buffer.writeBytes(tail, 0, tail.length);
			buffer.writeUnsignedInt(head.length);
			
			return buffer;
		}
		
		/**
		 * 读取buffer中tail的字节数组，结果存在tailBuffer中
		 * 
		 * @param buffer
		 * @param tailBuffer
		 * @return 
		 */
		public static function showTailBytes(buffer:ByteArray, tailBuffer:ByteArray):ByteArray
		{
			if(buffer == null)
			{
				throw new NullPointerException("Null buffer");
			}
			if(tailBuffer == null)
			{
				throw new NullPointerException("Null tail buffer");
			}
			
			buffer.position = buffer.length - 4;
			var headNumBytes:uint = buffer.readUnsignedInt();
			tailBuffer.writeBytes(buffer, headNumBytes, buffer.length - headNumBytes - 4);
			
			return tailBuffer;
		}
		
		/**
		 * 在传入的字节数组末尾添加md5验证内容
		 * 
		 * @param buffer
		 */
		public static function setVerification(bytes:ByteArray):void
		{
			if(bytes == null)
			{
				throw new NullPointerException("Null input buffer parameter.");
			}
			
			var position:uint = bytes.position;
			var md5:String = MD5.hashBytes(bytes);
			var bufferLength:uint = bytes.length;
			bytes.position = bytes.length;
			bytes.writeUTF(md5);
			bytes.writeUnsignedInt(bufferLength);
			bytes.position = position;
		}
		
		/**
		 * 与setVerification方法配套使用。
		 * 检查传入的字节数组是否符合md5的验证。
		 * 
		 * @param bytes
		 * @param restoreBytes 如果通过检测，是否将buffer还原成原始的数据
		 * 
		 * @return 
		 */
		public static function checkVerification(bytes:ByteArray, restoreBytes:Boolean = false):Boolean
		{
			if(bytes == null)
			{
				throw new NullPointerException("Null input buffer parameter.");
			}
			
			// 至少要有6个字节，其中2个字节用于存储md5验证字符串的长度，4个字节用于存储原始字节数组的长度
			if(bytes.length < 6)
			{
				return false;
			}
			else
			{
				try
				{
					var position:uint = bytes.position;
					bytes.position = bytes.length - 4;
					var originalLength:uint = bytes.readUnsignedInt();
					bytes.position = originalLength;
					var prevMD5:String = bytes.readUTF();
					var thisMD5:String = MD5.hashBytes(bytes, 0, originalLength);
					if(prevMD5 == thisMD5)
					{
						if(restoreBytes)
						{
							bytes.length = originalLength;
						}
						bytes.position = position;
						return true;
					}
					else
					{
						bytes.position = position;
						return false;
					}
				}
				catch(error:Error)
				{
					bytes.position = position;
					return false;
				}
				
				bytes.position = position;
				return false;
			}
		}
		
		/**
		 * 对传入的字符串用ByteArray进行压缩，返回压缩后的新字符串
		 * 
		 * @param srcStr
		 * @return 
		 */
		public static function getCompressedString(srcStr:String, fixUnprintableChar:Boolean = false):String
		{
			if(srcStr == null)
			{
				throw new NullPointerException("Null input srcStr parameter.");
			}
			
			_byteArray.clear();
			_byteArray.writeUTFBytes(srcStr);
			_byteArray.compress();
			
			var size:int = _byteArray.length;
			var oStr:String = "";
			var fixValue:int = fixUnprintableChar ? 32 : 0;
			for (var i:int = 0; i < size; i++) 
			{
				oStr += String.fromCharCode(_byteArray[i] + fixValue);
			}
			_byteArray.clear();
			
			return oStr;
		}
		
		/**
		 * 将使用getCompressedString方法压缩得到的字符串，解压会原始的字符串
		 * 
		 * @param compressedStr
		 * @return 
		 */
		public static function getUncompressedString(compressedStr:String, fixUnprintableChar:Boolean = false):String
		{
			if(compressedStr == null)
			{
				throw new NullPointerException("Null input compressedStr parameter.");
			}
			
			_byteArray.clear();
			var fixValue:int = fixUnprintableChar ? 32 : 0;
			var size:int = compressedStr.length;
			for (var i:int = 0; i < size; i++) 
			{
				_byteArray[i] = compressedStr.charCodeAt(i) - fixValue;
			}
			_byteArray.uncompress();
			var oStr:String = _byteArray.readUTFBytes(_byteArray.length);
			_byteArray.clear();
			
			return oStr;
		}
	}
}