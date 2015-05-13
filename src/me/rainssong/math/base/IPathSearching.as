package me.rainssong.math.base
{
	import com.codeTooth.actionscript.lang.utils.destroy.IDestroy;
	/**
	 * 寻路算法接口
	 */
	public interface IPathSearching extends IDestroy
	{
		/**
		 * 添加一个不可行走点
		 * 
		 * @param	row
		 * @param	col
		 * 
		 * @return	是否成功添加，指定的点不存在返回false
		 */
		function addUnwalkable(row:int, col:int):Boolean;
		
		/**
		 *	移除一个不可行走点
		 * 
		 * @param	row
		 * @param	col
		 * 
		 * @return	是否成功删除，指定的点不存在返回false
		 */
		function removeUnwalkable(row:int, col:int):Boolean;
		
		/**
		 * 开始寻路
		 * 
		 * @param	rowFrom 起始行编号
		 * @param	colFrom 起始列编号
		 * @param	rowTo 目标行编号
		 * @param	colTo 目标列编号
		 * 
		 * @return 返回寻路的结果。返回一个二维数组，第一维表示有几条路径可达，第二维表示可达的每一条路径节点
		 */
		function search(rowFrom:int, colFrom:int, rowTo:int, colTo:int):Vector.<Vector.<int>>;
	}
}