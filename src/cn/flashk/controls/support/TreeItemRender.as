package cn.flashk.controls.support
{
	import cn.flashk.controls.List;
	import cn.flashk.controls.Tree;
	import cn.flashk.controls.interfaces.IListItemRender;
	import cn.flashk.controls.managers.DefaultStyle;
	import cn.flashk.controls.managers.SkinLoader;
	import cn.flashk.controls.managers.SkinManager;
	import cn.flashk.controls.managers.SourceSkinLinkDefine;
	import cn.flashk.controls.skin.SkinThemeColor;
	import cn.flashk.conversion.ColorConversion;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;

	public class TreeItemRender extends ListItemRender
	{
		public static var closeRefs:Array =[] ;
		public var level:int = 0;
		private var levelSpace:Number = 18;
		private var iconFolderStr:String;
		private var iconItemStr:String;
		private var icon3Str:String;
		private var icon4Str:String;
		private var openSprite:Sprite;
		private var openBp:Bitmap;
		private var opens:Array=[];
		
		private var isOpen:Boolean = false;
		
		public var items:Sprite;
		
		
		private var xml:XML;
		private var myCloseRefs:Array;
		private var isRecord:Boolean = false;
		private var tree:Tree;
		
		public function TreeItemRender()
		{
			super();
			items = new Sprite();
			this.addChild(items);
			items.y = 25;
			//图标PNG数据
			//iconFolderStr = "15,11,0,0xe2a447xe2a447xe2a447xe2a447,zzz0xcf8838xyxyxyxyxcf8838,zz0,0xe29d47xsf0a4xsf0a4xse598xf9df8fxf5d281xedc17bxe29d47xe29d47xe29d47xe29d47xe29d47,0,0,0xdc9e44xsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxdc9e44,0,0,0xdc9744xsefb8xsefb8xsefb8xsefb8xsefb8xsefb8xsefb8xsefb8xsefb8xsefb8xc07b37,0,0,0xd49945xse9abxse9abxse9abxse9abxcd8d43xcd8d43xcd8d43xcd8d43xcd8d43xcd8d43xcd8d43xcd8d43xcd8d43xcd8d43xce8d3fxse19exse19exse19excd8d43xse9a4xse9a4xse9a4xse9a4xse9a4xse9a4xse9a4xse9a4xf9df8fxcd8d43xc88839xse197xse197xcd8d43xse197xse197xse197xse197xse197xse197xse197xse197xf9df8fxcd8d43,0xc17c35xsdb8axcd8d43xsdb91xsdb91xsdb91xsdb91xsdb91xsdb91xsdb91xsdb91xf9df8fxcd8d43,0,0xb37132xcd8d43xsdb8axsdb8axsdb8axsdb8axsdb8axsdb8axsdb8axsdb8axf9df8fxcd8d43,z0xbf823exbf823exbf823exbf823exbf823exbf823exbf823exbf823exbf823exbf823e,z0,";
			iconFolderStr = "15,11,0,0xe2a447xe2a447xe2a447xe2a447,zzz0xcf8838xyxyxyxyxcf8838,zz0,0xe29d47xsf0a4xsf0a4xse598xf9df8fxf5d281xedc17bxe29d47xe29d47xe29d47xe29d47xe29d47,0,0,0xdc9e44xsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxsf7ccxdc9e44,0,0,0xdc9744xsefb8xsefb8xsefb8xsefb8xsefb8xsefb8xsefb8xsefb8xsefb8xsefb8xc07b37,0,0,0xd49945xse9abxse9abxe4b773xcd8e44xcd8d43xcd8d43xcd8d43xcd8d43xcd8d43xcd8d43xcd8d43xcd8d43,7cc98a40,0xce8d3fxse19exebbf7axdba75exseba6xseca7xse9a4xse9a4xse9a4xse9a4xseaa6xsefa7xedc97a,aac9883f,2rrrxc88839xf5d086xdaa258xf7d68bxse89exse096xse197xse197xse197xse197xse79cxf5d889,d2cf964b,2dc17d39,0xc27d36xe1ac5fxecbe75xse79dxsda90xsdb91xsdb91xsdb91xsdb91xsde94xfade90,ecd9a85d,65c07e35,0,0xbc7b38xe0aa5exse796xsda89xsdb8axsdb8axsdb8axsdb8axsdc8bxfdde8d,fbe5be72,a4c17c35,z1cb67637xbf823exbf823exbf823exbf823exbf823exbf823exbf823exbf823exbf823e,e5be813d,z0,";			
			iconItemStr="12,15xb0b0b0xb1b1b1xb0b0b0xaeaeaexadadadxb0b0b0,f7b1b1b1,9dd4d4d4,1cededed,0,0,0xb3b3b3xe3e3e3xe3e3e3xdfdfdfxd3d3d3xc2c2c2xb4b4b4xb7b7b7,ebcacaca,3df7f7f7,0,0xb3b3b3xe5e5e5xe5e5e5xe4e4e4xe1e1e1xd5d5d5xc3c3c3xabababxf6f6f6,f1c4c4c4,31f5f5f5,0xb3b3b3xe7e7e7xe7e7e7xe7e7e7xe6e6e6xe3e3e3xd6d6d6xaeaeaexyxf6f6f6,dcc5c5c5,accccccxb5b5b5xebebebxeaeaeaxeaeaeaxe9e9e9xe8e8e8xd9d9d9xb7b7b7x949494x8e8e8ex999999,88ccccccxb7b7b7xeeeeeexeeeeeexedededxedededxecececxeaeaeaxd5d5d5xbdbdbdxaaaaaaxa0a0a0,f7a1a1a1xb7b7b7xeeeeeexeeeeeexeeeeeexeeeeeexeeeeeexeeeeeexecececxd8d8d8xcbcbcbxc7c7c7xaaaaaaxb7b7b7xeeeeeexeeeeeexeeeeeexeeeeeexeeeeeexeeeeeexeeeeeexedededxe9e9e9xdbdbdbxaeaeaexb7b7b7xeeefefxeeefefxeeefefxeeefefxeeefefxeeefefxefefefxefefefxefefefxe9e9e9xb3b3b3xb7b7b7xf0efefxf0efefxf0efefxf0efefxf0efefxf0efefxf2f2f2xf2f2f2xf2f2f2xefefefxb5b5b5xb7b7b7xf0f0f0xf0f0f0xf1f1f1xf2f2f2xf4f4f4xf5f5f5xf5f5f5xf5f5f5xf5f5f5xf4f4f4xb8b8b8xb7b7b7xf1f1f1xf1f1f1xf2f2f2xf4f4f4xf6f6f6xf7f7f7xf7f7f7xf7f7f7xf7f7f7xf5f5f5xb8b8b8xb7b7b7xf2f2f2xf2f2f2xf4f4f4xf6f6f6xf8f8f8xfafafaxfafafaxfafafaxfafafaxf9f9f9xbababaxb7b7b7xf3f4f4xf5f4f4xf5f6f6xf7f7f7xf8f8f8xf9f9f9xfafafaxfbfafbxfbfbfbxfbfbfbxbababa,dfc1c1c1x9f9f9fx9f9f9fx9f9f9fx9f9f9fx9f9f9fx9f9f9fx9f9f9fx9f9f9fx9f9f9fx9f9f9fxaaaaaa,";
			//icon3Str ="6,10,15555555,z0,0,8c646464,3060606z0,0,93656565,a5646464,47616161,z93656565,f1ebebeb,ccb3b3b3,61646464,3rrr,0,93656565,f6efefefxfcfcfc,cdb4b4b4,78646464,9555555,93656565,f6efefefxy,dbcdcdcd,9f636363,28606060,93656565,f6efefef,d4c0c0c0,93656565,1e5d5d5d,0,93656565,cfb7b7b7,84646464,115a5a5a,0,0,93656565,70646464,7494949,z47616161,z0,0,";
			icon3Str = "5,9,342c2c2c,z0,7d272727,8c232323,25rr0z8c232323xy,8c232323,25rrr,0,8c232323xyxy,8c232323,25rrr,8c232323xyxyxy,8c232323,8c232323xyxy,8c232323,25rrr,8c232323xy,8c232323,25rrr,0,7d272727,8c232323,25rr0z342c2c2c,z0,";
			icon4Str ="7,7,zzcrr0zzdrrr,6crr0z0,0,1crrr,d9rrrxrr0z0,1frrr,dfrrrx323232xrr0z22rrr,e2rrrx333333x626262xrrr,0,12rrr,e2rrrx353535x626262x626262xrrr,15rrr,73rrrxrrrxrrrxrrrxrrr,81rrr,";
			
		}
		
		override public function set list(value:List):void{
			_list = value;
			tree = value as Tree;
		}
		override public function set data(value:Object):void{
			var isSetIcon:Boolean = false;
			_data = value;
			xml = value as XML;
			txt.text = xml.attribute(_list.labelField.slice(1))[0];
			if(tree.floderIcon == null){
				if(SkinManager.isUseDefaultSkin == false){
					tree.floderIcon = SkinLoader.getBitmapData(SourceSkinLinkDefine.TREE_FLODER_ICON);
				}
				if(tree.floderIcon == null){
					tree.floderIcon = BitmapDataText.decodeTextToBitmapData(iconFolderStr);
				}
			}
			if(tree.nodeIcon == null){
				if(SkinManager.isUseDefaultSkin == false){
					tree.nodeIcon = SkinLoader.getBitmapData(SourceSkinLinkDefine.TREE_NODE_ICON);
				}
				if(tree.nodeIcon == null){
					tree.nodeIcon = BitmapDataText.decodeTextToBitmapData(iconItemStr);
				}
			}
			if(tree.closedIcon == null){
				if(SkinManager.isUseDefaultSkin == false){
					tree.closedIcon = SkinLoader.getBitmapData(SourceSkinLinkDefine.TREE_CLOSED_ICON);
				}
				if(tree.closedIcon == null){
					tree.closedIcon = BitmapDataText.decodeTextToBitmapData(icon3Str);
				}
			}
			if(tree.openedIcon == null){
				if(SkinManager.isUseDefaultSkin == false){
					tree.openedIcon = SkinLoader.getBitmapData(SourceSkinLinkDefine.TREE_OPENED_ICON);
				}
				if(tree.openedIcon == null){
					tree.openedIcon = BitmapDataText.decodeTextToBitmapData(icon4Str);
				}
			}
			padding =Number(_list.getStyleValue("textPadding")) + level*levelSpace;
			var iconSet:XMLList = xml.attribute(_list.iconField.slice(1));
			if(iconSet.length()>0){
				var iconBD:BitmapData = Tree(_list).iconGetFunction(iconSet[0]) as BitmapData;
				if(iconBD != null){
					setIcon(iconBD,true);
					isSetIcon = true;
				}
			}
			if(xml.children().length()>0){
				if(isSetIcon == false){ 
					setIcon(tree.floderIcon,true);
				}
				openBp = new Bitmap(tree.closedIcon);
				openSprite = new Sprite();
				openSprite.graphics.beginFill(0,0);
				openSprite.graphics.drawRect(-15,0,25,25);
				openSprite.x = bp.x - 10;
				openSprite.addEventListener(MouseEvent.MOUSE_OVER,showOepnOver);
				openSprite.addEventListener(MouseEvent.MOUSE_OUT,showOepnOut);
				openSprite.addEventListener(MouseEvent.CLICK,openNode);
				openBp.y = int((25-openBp.height)/2);
				openSprite.addChild(openBp);
				this.addChild(openSprite);
			}else{
				if(isSetIcon == false){ 
					setIcon(tree.nodeIcon,true);
				}
			}
		}
		public function checkOpenNode(node:Object):void{
			if(_data == node){
				if(isOpen == false){
					openNode();
				}
			}else{
				if(xml.toXMLString().indexOf(node.toXMLString().slice(0,35)) != -1){
					if(isOpen == false && xml.children().length() > 0){
						openNode();
					}
				}
				for(var i:int=0;i<opens.length;i++){
					TreeItemRender(opens[i]).checkOpenNode(node);
				}
			}
		}
		public function checkCloseNode(node:Object):void{
			if(_data == node){
				if(isOpen == true){
					openNode();
				}
			}else{
				for(var i:int=0;i<opens.length;i++){
					//TreeItemRender(opens[i]).checkCloseNode(node);
				}
			}
		}
		public function expandChildrenOf(node:Object=null, isOpenNode:Boolean=true):void{
			if(_data == node || node == null){
				if(isOpenNode == true){
					if(xml.children().length() > 0 && isOpen == false){
						isOpen = false;
						openNode();
						if(node != null){
							for(var i:int=0;i<opens.length;i++){
								TreeItemRender(opens[i]).expandChildrenOf(null,isOpenNode);
							}
						}
					}
				}else{
					if(xml.children().length() > 0  && isOpen == true){
						isOpen = true;
						openNode();
					}
				}
			}
		}
		private function openNode(event:MouseEvent = null):void{
			isOpen = !isOpen;
			var item:IListItemRender;
			if(isOpen == true){
				openBp.bitmapData = tree.openedIcon;
				if(isRecord == false){
					for(var i:int=0;i<xml.children().length();i++){
						item = new TreeItemRender();
						item.list = List(this._list);
						TreeItemRender(item).level = this.level+1;
						item.data = xml.children()[i];
						item.setSize(_list.compoWidth,0);
						items.addChild(item as DisplayObject);
						Tree(_list).addItemRenderAt(item,this.parent.getChildIndex(this)+i+1);
						opens.push(item);
					}
				}else{
					myCloseRefs.sortOn("index",Array.NUMERIC);
					for(var m:int=0;m<myCloseRefs.length;m++){
						item = myCloseRefs[m].ref as IListItemRender;
						Tree(_list).addItemRenderAt(item,this.parent.getChildIndex(this)+myCloseRefs[m].index);
					}
				}
			}else{
				openBp.bitmapData = tree.closedIcon;
				closeRefs = [];
				record();
				myCloseRefs = [];
				for(var j:int=0;j<closeRefs.length;j++){
					closeRefs[j][1] = closeRefs[j][1]- this.parent.getChildIndex(this);
					myCloseRefs[j] = {ref:closeRefs[j][0],index:closeRefs[j][1]};
				}
				isRecord = true;
				removeMyOpen();
				closeRefs=[];
			}
		}
		public function record():void{
			for(var j:int=0;j<opens.length;j++){
				TreeItemRender(opens[j]).record();
			}
			for( j=0;j<opens.length;j++){
				if(DisplayObject(opens[j]).parent != null){
					closeRefs.push([opens[j],DisplayObject(opens[j]).parent.getChildIndex(DisplayObject(opens[j]))]);
				}
			}
		}
		public function removeMyOpen():void{
			for(var j:int=0;j<opens.length;j++){
				TreeItemRender(opens[j]).removeMyOpen();
			}
			
			for( j=0;j<opens.length;j++){
				if(DisplayObject(opens[j]).parent != null){
					Tree(_list).removeItemRenderAt(opens[j] as IListItemRender);
				}
			}
		}
		public function reAlign():void{
			if(this.level == 0){
				Tree(_list).alignItems(null);
				Tree(_list).alignItems(items);
			}else{
				Object(this.parent.parent).reAlign();
			}
		}
		private function showOepnOver(event:MouseEvent):void{
			var glow:GlowFilter = new GlowFilter(ColorConversion.transformWebColor(DefaultStyle.buttonOutTextColor),1,8,8,1.5,2);
			//var glow:GlowFilter = new GlowFilter(0xFFFFFF,1,12,12,8,2);
			openSprite.filters = [glow];
		}
		private function showOepnOut(event:MouseEvent):void{
			openSprite.filters = [];
		}
	}
}