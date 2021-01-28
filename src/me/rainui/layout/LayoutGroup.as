package me.rainui.layout 
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import me.rainssong.utils.Directions;
	import me.rainui.components.Container;
	
	
	/**
	 * @date 2018-12-30 0:38
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class LayoutGroup extends Container 
	{
		
        protected var m_TotalSize:Object = {"vertical":0, "horizontal":0};
		
		public function LayoutGroup(dataSource:Object=null) 
		{
			super(dataSource);
			
		}
		

        protected var _childrens:Vector.<DisplayObject> = new Vector.<DisplayObject>();

		/**
		 * 所有子对象填入
		 */
        public function GetAllChildren():void
        {
			_childrens.length = 0;
            for (var i:int = 0; i < this.numChildren; i++)
            {
				var d:DisplayObject = this.getChildAt(i);
                if (d == null || !d.visible)
                    continue;

				_childrens.push(d);
            }
        }
		
		
		
		
		/**
		 * 对齐
		 * @param	axis
		 * @return
		 */
		  //protected function GetAlignmentOnAxis(axis:String):Number
        //{
            //if (axis == 0)
                //return (childAlignment % 3) * 0.5f;
            //else
                //return (childAlignment / 3) * 0.5f;
        //}
		
		protected function SetChildAlongAxis(rect:DisplayObject ,  axis:String,  pos:Number)
        {
            if (rect == null)
                return;

			if (axis == Directions.HORIZONTAL)
			{
				rect.x = pos
			}
           
		   else
		   {
			    rect.y = pos;
		   }
		  
        }



        public function  SetLayoutHorizontal(){}
        public function  SetLayoutVertical(){}



        protected function GetTotalSize(axis:String):Number
        {
            return m_TotalSize[axis];
        }


        //protected  GetAlignmentOnAxis(axit:Directions)
        //{
            //if (axis == 0)
                //return ((int)childAlignment % 3) * 0.5f;
            //else
                //return ((int)childAlignment / 3) * 0.5f;
        //}


        //protected void SetChildAlongAxis(RectTransform rect, axit:Directions,  pos)
        //{
            //if (rect == null)
                //return;
//
            //m_Tracker.Add(this, rect,
                //DrivenTransformProperties.Anchors |
                //(axis == 0 ? DrivenTransformProperties.AnchoredPositionX : DrivenTransformProperties.AnchoredPositionY));
//
            //rect.SetInsetAndSizeFromParentEdge(axis == 0 ? RectTransform.Edge.Left : RectTransform.Edge.Top, pos, rect.sizeDelta[axis]);
        //}
//
        //protected void SetChildAlongAxis(RectTransform rect, axit:Directions,  pos,  size)
        //{
            //if (rect == null)
                //return;
//
            //m_Tracker.Add(this, rect,
                //DrivenTransformProperties.Anchors |
                //(axis == 0 ?
                    //(DrivenTransformProperties.AnchoredPositionX | DrivenTransformProperties.SizeDeltaX) :
                    //(DrivenTransformProperties.AnchoredPositionY | DrivenTransformProperties.SizeDeltaY)
                //)
            //);
//
            //rect.SetInsetAndSizeFromParentEdge(axis == 0 ? RectTransform.Edge.Left : RectTransform.Edge.Top, pos, size);
        //}

		



		
	}

}