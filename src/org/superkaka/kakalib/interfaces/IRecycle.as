package org.superkaka.kakalib.interfaces 
{
	
	/**
	 * 可回收对象接口，对象池使用此接口
	 * @author ｋａｋａ
	 */
	public interface IRecycle 
	{
		
		/**
		 * 回收此对象
		 */
		function recycle():void;
		
	}
	
}