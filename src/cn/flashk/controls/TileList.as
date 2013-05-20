package cn.flashk.controls
{
	import cn.flashk.controls.interfaces.ITileListItemRender;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.skin.ActionDrawSkin;
	import cn.flashk.controls.skin.ListSkin;
	import cn.flashk.controls.skin.sourceSkin.ListSourceSkin;
	import cn.flashk.controls.support.ItemsSelectControl;
	import cn.flashk.controls.support.TileListThumbnail;
	import cn.flashk.controls.support.UIComponent;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	/**
	 * TileList用来显示一个类似于系统资源管理器一样的缩略图列表，列表中的项目按照网格排列
	 * 
	 * 默认显示缩略图的itemRender是cn.flashk.controls.support.TileListThumbnail
	 *  
	 * @langversion ActionScript 3.0
	 * @playerversion Flash 9.0
	 * 
	 * @see cn.flashk.controls.support.TileListThumbnail
	 * @see cn.flashk.controls.support.UIComponent
	 * 
	 * @author flashk
	 */

	public class TileList extends List
	{
		
		private var _verticalSpace:Number = 3;
		private var _horizontalSpace:Number = 7;
		
		
		public function TileList()
		{
			super();
			
			_compoWidth = 600;
			_compoHeight = 300;
			
			_itemRender = TileListThumbnail;
			_allowMultipleSelection = true;
			styleSet["textPadding"] = 10;
			setSize(_compoWidth, _compoHeight);
			items.y = 1;
		}
		/**
		 * 设置/获取 网格之间的横向间距
		 */ 
		public function set horizontalSpace(value:Number):void{
			_horizontalSpace = value;
		}
		public function get horizontalSpace():Number{
			return _horizontalSpace;
		}
		/**
		 * 设置/获取 网格之间的竖向间距
		 */
		public function set verticalSpace(value:Number):void{
			_verticalSpace = value;
		}
		public function get verticalSpace():Number{
			return _verticalSpace;
		}
		override public function setDefaultSkin():void {
			setSkin(ListSkin)
		}
		override public function setSourceSkin():void {
			setSkin(SkinLoader.getClassFromSkinFile(SourceSkinLinkDefine.LIST));
		}
		override public function setSkin(Skin:Class):void {
			if(SkinManager.isUseDefaultSkin == true){
				skin = new Skin();
				ActionDrawSkin(skin).init(this,styleSet);
			}else{
				var sous:ListSourceSkin = new ListSourceSkin();
				sous.init(this,styleSet,Skin);
				skin = sous;
			}
		}
		override public function addItemAt(item:Object,index:uint):void{
			super.addItemAt(item,index);
			var itemT:ITileListItemRender;
			var max:uint;
			var nx:Number;
			var ny:Number;
			for(var i:int=1;i<items.numChildren;i++){
				itemT = items.getChildAt(i) as ITileListItemRender;
				nx = itemT.itemWidth+_horizontalSpace;
				ny = itemT.itemHeight+_verticalSpace;
				max = uint((_compoWidth-17)/nx);
				DisplayObject(itemT).x = i*nx%(max*nx);
				DisplayObject(itemT).y = Math.floor(i/max)*ny;
			}
			scrollBar.snapNum = 1;
			scrollBar.updateSize(Math.floor((items.numChildren-1)/max+1)*ny);
		}
	}
}