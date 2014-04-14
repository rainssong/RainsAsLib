package com.codeTooth.actionscript.algorithm.compressDecompress 
{

	import com.codeTooth.actionscript.lang.exceptions.UnknownTypeException;
	import flash.utils.ByteArray;
	import me.rainssong.utils.StringCore;


	/**
	 * 行程编码（run-length encoding）
	 */
	public class RLE 
	{	
		private static var ASCII_AMX:uint = 0xFF;
		
		private static var _cache:ByteArray = new ByteArray();
		
		/**
		 * 使用行程编码压缩字符串，适用于字符串中有大量重复的连续字符的情况。
		 * 字符串中的单个字符编码值必须是在一个字节可表示的范围内（最大0xFF，一般是ACSII字符）
		 * 
		 * @param	input	输入字符串
		 * @param	sentinel	哨兵字符编码值。哨兵字符编码值应该在一个字节可表示的范围内（0至0xFF）。
		 * 哨兵字符应该尽量不与输入文本中的字符相同，这样可以提升压缩的效果
		 * @param	minBlockLength	指定最小的行程长度。大于这个值的行程才会被压缩
		 * 
		 * @return	返回压缩后的字符串。输入null返回null
		 */
		public static function compressASCII(input:String, sentinel:int = 0xFF, minBlockLength:uint = 3):String
		{
			var tempCharCode:int;
			
			if (input == null)
			{
				return null;
			}
			// 空字符串
			else if (StringCore.isEmpty(input))
			{
				_cache.clear();
				writeCompressASCIIHead(_cache, sentinel);
				_cache.position = 0;
				
				return _cache.readUTFBytes(_cache.bytesAvailable);
			}
			// 字符串值包含一个字符
			else if (input.length == 1)
			{
				_cache.clear();
				writeCompressASCIIHead(_cache, sentinel);
				
				tempCharCode = input.charCodeAt(0);
				if (tempCharCode == sentinel)
				{
					_cache.writeByte(sentinel);
					_cache.writeByte(tempCharCode);
					_cache.writeByte(1);
				}
				else
				{
					_cache.writeByte(tempCharCode);
				}
				
				_cache.position = 0;
				return _cache.readUTFBytes(_cache.bytesAvailable);
			}
			// 包含两个或两个以上字符
			else
			{
				var length:int = input.length;
				var currCharCode:int;
				var lastCharCode:int = int.MIN_VALUE;
				var index:int = 0;
				var j:int;
				_cache.clear();
				writeCompressASCIIHead(_cache, sentinel);
				
				// 遍历
				for (var i:int = 0; i < length; i++)
				{
					currCharCode = input.charCodeAt(i);
					// 当前字符和上一个字符相同
					if (currCharCode == lastCharCode)
					{
						// 如果相同字符的数量大于了上限
						if (i - index == ASCII_AMX)
						{
							// 相同字符数量大于最小行程长度，一次写入
							if (i - index > minBlockLength)
							{								
								_cache.writeByte(sentinel);
								_cache.writeByte(currCharCode);
								_cache.writeByte(i - index);
							}
							// 没有大于最小行程长度，那就一个个字符的写入
							else
							{
								for (j = index; j < i; j++)
								{
									tempCharCode = input.charCodeAt(j);
									if (tempCharCode == sentinel)
									{
										_cache.writeByte(sentinel);
										_cache.writeByte(tempCharCode);
										_cache.writeByte(1);
									}
									else
									{
										_cache.writeByte(tempCharCode);
									}
								}
							}
							
							// 如果已经是整个字符串的最后一个字符了，那么把最后一个字符也写入
							if (i == length - 1)
							{
								tempCharCode = input.charCodeAt(i);
								if (tempCharCode == sentinel)
								{
									_cache.writeByte(sentinel);
									_cache.writeByte(tempCharCode);
									_cache.writeByte(1);
								}
								else
								{
									_cache.writeByte(tempCharCode);
								}
							}
							
							index = i;
						}
						// 是字符串中的最后一个字符
						else if (i == length - 1)
						{
							// 相同字符数量大于最小行程长度，一次写入
							if (i - index >= minBlockLength)
							{								
								_cache.writeByte(sentinel);
								_cache.writeByte(currCharCode);
								_cache.writeByte(i - index + 1);
							}
							// 没有大于最小行程长度，那就一个个字符的写入
							else
							{
								for (j = index; j <= i; j++)
								{
									tempCharCode = input.charCodeAt(j);
									if (tempCharCode == sentinel)
									{
										_cache.writeByte(sentinel);
										_cache.writeByte(tempCharCode);
										_cache.writeByte(1);
									}
									else
									{
										_cache.writeByte(tempCharCode);
									}
								}
							}
						}
					}
					// 当前字符和上一个字符不同
					else
					{
						// 相同字符数量大于最小行程长度，一次写入
						if (i - index > minBlockLength)
						{								
							_cache.writeByte(sentinel);
							_cache.writeByte(lastCharCode);
							_cache.writeByte(i - index);
						}
						// 没有大于最小行程长度，那就一个个字符的写入
						else
						{
							for (j = index; j < i; j++)
							{
								tempCharCode = input.charCodeAt(j);
								if (tempCharCode == sentinel)
								{
									_cache.writeByte(sentinel);
									_cache.writeByte(tempCharCode);
									_cache.writeByte(1);
								}
								else
								{
									_cache.writeByte(tempCharCode);
								}
							}
						}
						
						// 如果已经是整个字符串的最后一个字符了，那么把最后一个字符也写入
						if (i == length - 1)
						{
							tempCharCode = input.charCodeAt(i);
							if (tempCharCode == sentinel)
							{
								_cache.writeByte(sentinel);
										_cache.writeByte(tempCharCode);
										_cache.writeByte(1);
							}
							else
							{
								_cache.writeByte(tempCharCode);
							}
						}
						
						index = i;
					}
					
					lastCharCode = currCharCode;
				}
				
				_cache.position = 0;
				return _cache.readUTFBytes(_cache.bytesAvailable);
			}
		}
		
		// 写行程编码数据头
		private static function writeCompressASCIIHead(cache:ByteArray, sentinel:uint):void
		{
			cache.writeByte(0xFF);
			cache.writeByte(0xFF);
			cache.writeByte(0xFF);
			cache.writeByte(sentinel);
		}
		
		/**
		 * 解压使用行程编码压缩的字符串
		 * 
		 * @param	input	输入由compressASCII返回的字符串
		 * 
		 * @return	返回解压缩后的字符串
		 * 
		 * @throws	com.codeTooth.actionscript.lang.exceptions.UnknownTypeException 
		 * 解析不了输入的字符串
		 */
		public static function decompressASCII(input:String):String
		{
			if (input == null)
			{
				return null;
			}
			else if (input.length < 4 || input.charCodeAt(0) != 0xFF || input.charCodeAt(1) != 0xFF || input.charCodeAt(2) != 0xFF)
			{
				throw new UnknownTypeException("未知的格式");
				return null;
			}
			else
			{
				_cache.clear();
				
				var sentinel:int = input.charCodeAt(3);
				var length:int = input.length;
				var currCharCode:uint
				var step:int;
				for (var i:int = 4; i < length; i++)
				{
					currCharCode = input.charCodeAt(i);
					if (currCharCode == sentinel)
					{
						currCharCode = input.charCodeAt(i + 1);
						step = input.charCodeAt(i + 2);
						i += 2;
						for (var j:int = 0; j < step; j++)
						{
							_cache.writeByte(currCharCode);
						}
					}
					else
					{
						_cache.writeByte(currCharCode);
					}
				}
				
				_cache.position = 0;
				return _cache.readUTFBytes(_cache.bytesAvailable);
			}
		}
	}

}