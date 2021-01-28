package me.rainui.layout 
{
	import me.rainssong.utils.Directions;
	
	/**
	 * @date 2019-01-02 1:03
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class VerticalLayoutGroup extends HorizontalOrVerticalLayoutGroup 
	{
		
		public function VerticalLayoutGroup(dataSource:Object=null) 
		{
			super(dataSource);
		}
		
		override protected function preinitialize():void 
		{
			_width = 400;
			_height = 400;
			super.preinitialize();
		}
		//延横轴
		public function CalculateLayoutInputHorizontal():void
        {
            CalcAlongAxis(Directions.HORIZONTAL, true);
        }
		
		
        public function CalculateLayoutInputVertical()
        {
            CalcAlongAxis(Directions.VERTICAL, true);
        }

        public override function SetLayoutHorizontal()
        {
            SetChildrenAlongAxis(Directions.HORIZONTAL, true);
        }

        public override function SetLayoutVertical()
        {
            SetChildrenAlongAxis(Directions.VERTICAL, true);
        }
		
		override protected function initialize():void 
		{
			super.initialize();
			
		}
		
		
		public function runLayout()
		{
			CalculateLayoutInputHorizontal();
			CalculateLayoutInputVertical();
			SetLayoutHorizontal();
			SetLayoutVertical();
		}
		
		

		
	}

}