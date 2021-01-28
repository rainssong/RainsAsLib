package me.rainui.layout 
{
	import com.greensock.motionPaths.Direction;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import me.rainssong.math.MathCore;
	import me.rainssong.utils.Directions;
	
	/**
	 * @date 2019-01-02 1:04
	 * @author Rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	public class HorizontalOrVerticalLayoutGroup extends LayoutGroup 
	{
		
		public function HorizontalOrVerticalLayoutGroup(dataSource:Object=null) 
		{
			super(dataSource);
			
		}

        var  m_Spacing:Number  = 0;
        public  function get spacing() { return m_Spacing; } 
		public  function set spacing(value:Number) { m_Spacing = value; }
		
		protected var   m_ChildControlWidth:Boolean= true;
        public function get childControlWidth()  { return m_ChildControlWidth; } 
        public function set childControlWidth(value:Boolean) { m_ChildControlWidth=value}

        protected var   m_ChildControlHeight:Boolean = true;
        public function  get childControlHeight()    { return m_ChildControlHeight; }
        public function  set childControlHeight(value:Boolean) { m_ChildControlHeight=value}

        var  m_ChildForceExpandWidth:Boolean = true;
        public function get childForceExpandWidth(){ return m_ChildForceExpandWidth; } 
		public function set childForceExpandWidth(value:Boolean){ m_ChildForceExpandWidth = value } 
		
		/**
		 * 铺满
		 */
		var  m_ChildForceExpandHeight:Boolean = true;
        public function get childForceExpandHeight(){ return m_ChildForceExpandHeight; } 
		public function set childForceExpandHeight(value:Boolean){ m_ChildForceExpandHeight= value } 


		//最小，默认，主动填充
		//public var min:Number, preferred:Number, flexible:Number;
		
		public var axis:String = Directions.HORIZONTAL;
		public var isVertical:String = true;
		
      
		//计算整体内容大小
        protected function CalcAlongAxis(axis:String, isVertical:Boolean)
        {
			GetAllChildren();
            var childForceExpandSize:Boolean = (axis == Directions.HORIZONTAL) ? childForceExpandWidth : childForceExpandHeight;


			//异或 约等于isVertical!=(axis== Directions.VERTICAL)
            var alongOtherAxis:Boolean = isVertical != (axis == Directions.VERTICAL)
			
			
			 var childSize:Number
			var totalSize:Number = 0;
			
            for ( var i:int = 0; i < _childrens.length; i++)
            {
                var child:DisplayObject = _childrens[i];
                childSize=GetChildSizes(child, axis);
               
				
                if (alongOtherAxis)
                {
					totalSize=Math.max(childSize , totalSize);
                }
                else
                {
                   totalSize+= childSize+m_Spacing;
                }
            }
			totalSize-= -m_Spacing;
            m_TotalSize[axis] = totalSize;
        }
		

		
        protected function SetChildrenAlongAxis(axis:String, isVertical:Boolean)
        {
            var thisSize:Number = axis == Directions.HORIZONTAL?_width: _height;
			var controlSize:Boolean = axis == Directions.HORIZONTAL ? m_ChildControlWidth : m_ChildControlHeight;
			var childForceExpandSize:Boolean = (axis == Directions.HORIZONTAL) ? childForceExpandWidth : childForceExpandHeight;
            var alignmentOnAxis:Number = 0;

            var alongOtherAxis:Boolean = isVertical != (axis == Directions.VERTICAL)
			var childSizeAlongAxis:Number;
			
            if (alongOtherAxis)
            {
				var innerSize:Number = 0
                for (var  i:int = 0; i < _childrens.length; i++)
                {
                    var  child:DisplayObject = _childrens[i];
                   
					SetChildAlongAxis(child, axis, 0);
					
					
					if (controlSize)
					{
						childSizeAlongAxis=thisSize;
						SetChildSizes(child, axis, childSizeAlongAxis);
					}
                }
            }
            else
            {
              

                var pos:Number = 0
				
				
                //var itemFlexibleMultiplier:Number = 0;
                //if (thisSize > GetTotalSize(axis))
                //{
                    //if (GetTotalSize(axis) > 0)
                        //itemFlexibleMultiplier = (thisSize - GetTotalSize(axis)) / GetTotalSize(axis);
                //}
                
                for (var  i:int = 0; i < _childrens.length; i++)
                {
                    var child:DisplayObject = _childrens[i];
                   
					
                   var childSize:Number = GetChildSizes(child, axis);
				   //占用空间
					var childSpace:Number = thisSize / _childrens.length;
					
					if (controlSize)
					{
						childSizeAlongAxis=childSpace;
						SetChildSizes(child, axis, childSpace);
					}
					
					
					
					SetChildAlongAxis(child, axis, pos);
                    
					//先修改宽高
					if (childForceExpandSize)
					{
						pos += childSpace+spacing;
					}
					else
						pos += childSize+spacing;
                }
            }
        }
		
		private function SetChildSizes(child:DisplayObject , axis:String,value:Number):void
        {
			if(axis==Directions.HORIZONTAL)
				child.width = value;
			else
				child.height = value;
            
        }

        private function GetChildSizes(child:DisplayObject , axis:String):Number
        {

            return axis == Directions.HORIZONTAL?child.width:child.height;
            
        }
		
		override public function redraw():void 
		{
			super.redraw();
			CalcAlongAxis(axis, isVertical);
			SetChildrenAlongAxis(axis, isVertical);
		}
		
		
		override protected function onAdded(param0:Event):void 
		{
			super.onAdded(param0);
			redraw();
		}
		


		
	}

}