package cn.flashk.test
{
	import cn.flashk.controls.Button;
	import cn.flashk.controls.ComboBox;
	import cn.flashk.controls.skin.SkinThemeColor;
	import cn.flashk.core.DisplayRefs;
	import cn.flashk.debug.Debug;
	import cn.flashk.map.MapEngine;
	import cn.flashk.map.move.AutoRoad;
	import cn.flashk.role.player.PlayerSelf;
	
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.events.ContextMenuEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;

	public class MapTest extends Sprite
	{
		private var btn1:Button;
		private var btn2:Button;
		private var btn3:Button;
		private var btn4:Button;
		private var combo:ComboBox;
		private var combo2:ComboBox;
		
		public function MapTest()
		{
			this.cacheAsBitmap = true;
			SkinThemeColor.userDefaultColor(int(Math.random()*60));
			btn1 = new Button();
			btn1.label = "地图震动";
			this.addChild(btn1);
			btn1.addEventListener(MouseEvent.CLICK,test1);
			btn1.x = 5;
			btn1.y = 5;
			
			
			btn2 = new Button();
			btn2.label = "地图震动2";
			this.addChild(btn2);
			btn2.addEventListener(MouseEvent.CLICK,test2);
			btn2.x = 5;
			btn2.y = 30;
			
			btn3 = new Button();
			btn3.label = "地图震动3";
			this.addChild(btn3);
			btn3.addEventListener(MouseEvent.CLICK,test3);
			btn3.x = 5;
			btn3.y = 55;
			
			combo = new ComboBox();
			combo.selectedIndex = 4;
			combo.addItem({label:"开启画面增强1"}); 
			combo.addItem({label:"开启画面增强2"}); 
			combo.addItem({label:"开启画面增强3"}); 
			combo.addItem({label:"开启画面增强4"}); 
			combo.addItem({label:"不开启画面增强"}); 
			this.addChild(combo);
			//combo.dropdown.
			combo.x = 5;
			combo.y = 80;
			combo.addEventListener(Event.CHANGE,changeStyle);
			
			
			combo2 = new ComboBox();
			combo2.addItem({label:"显示足迹1"}); 
			combo2.addItem({label:"显示足迹2"}); 
			combo2.addItem({label:"不显示足迹"}); 
			combo2.rowCount  = 3;
			this.addChild(combo2);
			//combo.dropdown.
			combo2.x = 5;
			combo2.y = 105;
			combo2.addEventListener(Event.CHANGE,changeStyle2);
			
			var cm:ContextMenu;
			var cmi:ContextMenuItem;
			
			cm = new ContextMenu();
			cmi=new ContextMenuItem("60FPS");
			cmi.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,fps60);
			cm.customItems.push(cmi);
			cmi=new ContextMenuItem("50FPS");
			cmi.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,fps50);
			cm.customItems.push(cmi);
			cmi=new ContextMenuItem("30FPS");
			cmi.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,fps30);
			cm.customItems.push(cmi);
			cmi=new ContextMenuItem("显示Debug");
			cmi.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,switchDebug);
			cm.customItems.push(cmi);
			cmi=new ContextMenuItem("显示品质：低");
			cmi.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,qu1);
			cm.customItems.push(cmi);
			cmi=new ContextMenuItem("显示品质：中");
			cmi.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,qu2);
			cm.customItems.push(cmi);
			cmi=new ContextMenuItem("显示品质：高");
			cmi.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT,qu3);
			cm.customItems.push(cmi);
			
			
			DisplayRefs.swfRootSprite.contextMenu = cm;
			
			this.addChild(Debug.infoTxt);
			Debug.infoTxt.width = 150;
			Debug.infoTxt.height = 35;
			Debug.infoTxt.text = "飞龙网页游戏开发引擎地图\nDemo TEL:13581931635";
			Debug.infoTxt.setTextFormat(new TextFormat("Arial",12,0xFFFFFFF));
			Debug.infoTxt.y = -30;
			this.y = 30;
			
			
			return;
			
			btn4 = new Button();
			btn4.label = "释放冲击波特效（轻）";
			btn4.width = 150;
			this.addChild(btn4);
			btn4.addEventListener(MouseEvent.CLICK,test5);
			btn4.x = 5;
			btn4.y = 132;
			
			
			btn4 = new Button();
			btn4.label = "释放冲击波特效（重）";
			btn4.width = 150;
			this.addChild(btn4);
			btn4.addEventListener(MouseEvent.CLICK,test4);
			btn4.x = 5;
			btn4.y = 155;
		}
		private function qu1(event:Event):void{
			DisplayRefs.swfRootSprite.stage.quality = StageQuality.LOW;
		}
		private function qu2(event:Event):void{
			DisplayRefs.swfRootSprite.stage.quality = StageQuality.MEDIUM;
		}
		private function qu3(event:Event):void{
			DisplayRefs.swfRootSprite.stage.quality = StageQuality.HIGH;
		}
		private function switchDebug(event:Event):void{
			AutoRoad.getInstance().switchShowDebug();
		}
		private function fps60(event:Event):void{
			DisplayRefs.swfRootSprite.stage.frameRate = 60;
		}
		private function fps50(event:Event):void{
			DisplayRefs.swfRootSprite.stage.frameRate = 50;
		}
		private function fps30(event:Event):void{
			DisplayRefs.swfRootSprite.stage.frameRate = 30;
		}
		private function test1(event:MouseEvent):void{
			MapEngine.getInstance().shake(1.5,9);
		}
		private function test2(event:MouseEvent):void{
			MapEngine.getInstance().shake(5,2);
		}
		private function test3(event:MouseEvent):void{
			MapEngine.getInstance().shake(2,10,2);
		}
		private function test4(event:MouseEvent):void{
			MapEngine.getInstance().earthShock(15,15);
		}
		private function test5(event:MouseEvent):void{
			MapEngine.getInstance().earthShock(7,7);
		}
		private function changeStyle(event:Event):void{
			//trace(combo.selectedIndex);
			switch(combo.selectedIndex)
			{
				case 0:
					MapEngine.getInstance().applyPictureHeigher(-15,15,2,0);	
					break;
				case 1:
					MapEngine.getInstance().applyPictureHeigher(-5,5,5,0);	
					break;
				case 2:
					MapEngine.getInstance().applyPictureHeigher(-5,5,25,0);	
					break;
				case 3:
					MapEngine.getInstance().applyPictureHeigher(-5,5,-5,0);	
					break;
				
					
				default:
					MapEngine.getInstance().applyPictureHeigher(0,0,0,0);
				
				
			}
		}
		private function changeStyle2(event:Event):void{
			//trace(combo.selectedIndex);
			switch(combo2.selectedIndex)
			{
				case 0:
					PlayerSelf.getInstance().setFootEffect("Flower1",1,false);	
					break;
				case 1:
					PlayerSelf.getInstance().setFootEffect("Foot1",10,true);	
					break;
				case 2:
					PlayerSelf.getInstance().setFootEffect("",1,false);	
					break;
				
				
				default:
					
					
					
			}
		}
	}
}