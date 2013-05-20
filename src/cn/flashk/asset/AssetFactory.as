package cn.flashk.asset
{
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class AssetFactory
	{
		public function AssetFactory()
		{
		}
		public static function getSpriteByRef(classRef:Class):Sprite{
			return new classRef() as Sprite;
		}
		public static function getMovieClipByRef(classRef:Class):MovieClip{
			return new classRef() as MovieClip;
		}
		
		public static function getObjectByRef(classRef:Class):Object{
			return new classRef();
		}
	}
}