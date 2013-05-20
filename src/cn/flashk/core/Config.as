package cn.flashk.core
{
	/**
	 * 此对象为动态对象，其中的动态属性由Loader第一次加载配置文件（config.xml）初始化。
	 * 每个标签对应一个变量名。如：
	 * <config>
	 *<firstRun>select-avatar.swf</firstRun>
	 * .....
	 *</config>
	 * 要取得firstRun标签的内容，使用Config.getInstance().firstRun代码
	 */ 
	public dynamic class Config
	{
		public static var xml:XML;
		
		private static var ins:Config;
		
		public function Config()
		{
		}
		
		/**
		 * 返回对Config唯一对象的引用
		 */ 
		public static function getInstance():Object{
			if(ins == null){
				ins = new Config();
			}
			return ins;
		}
		
		public static function getAttributeByChild(childName:String,attributeName:String):Object{
			return xml.child(childName).attribute(attributeName);
		}
	}
}