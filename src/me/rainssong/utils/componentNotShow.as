package me.rainssong.utils
{
	
	/**
	 * 组件看不到？请使用本函数检测
	 * @param target
	 *
	 */
	public function componentsNotShow(target:DisplayObject):void
	{
		// 检查基本属性
		if (!target.stage)
		{
			trace("没添加到舞台");
			return;
		}
		if (!target.visible)
		{
			trace("visible 是 false");
			return;
		}
		if (target.scaleX == 0)
		{
			trace("scaleX 为 0");
			return;
		}
		if (target.scaleY == 0)
		{
			trace("scaleY 为 0");
			return;
		}
		if (target.alpha == 0)
		{
			trace("目标是透明的(alpha 为 0)");
			return;
		}
		if (target.width == 0)
		{
			trace("宽度 为 0");
			return;
		}
		if (target.height == 0)
		{
			trace("高度 为 0");
			return;
		}
		
		if (target.alpha < .3)
			trace("alpha 小于0.3");
		if (target.width < 2)
			trace("宽度小于2");
		if (target.height < 2)
			trace("高度小于2");
		if (target.scrollRect)
			trace("设置了 scrollRect, 检查是否是该属性造成的");
		
		// 检查是否为特殊组件
		var str:String;
		if (target["text"] != undefined)
		{
			str = target["text"];
			if (str == null || str == "" || str.replace(/[         　        ]+/, "") == "")
				trace("文本为空:", "text属性未赋值，或值为空格");
		}
		if (target["label"] != undefined)
		{
			str = target["label"];
			if (str == null || str == "" || str.replace(/[         　        ]+/, "") == "")
				trace("label属性未赋值，或值为空格", "如果与label无关可以忽略该信息");
		}
		
		// 检查位置
		var p:Point = target.localToGlobal(new Point(0, 0));
		if ((p.x + target.width) < 0 || (p.y + target.height) < 0 || p.x > target.stage.stageWidth || p.y > target.stage.stageHeight)
		{
			trace("目标位置在舞台之外");
			return;
		}
		var bound:Rectangle = target.transform.pixelBounds;
		if (bound.width < 2 || bound.height < 2 || bound.right < 0 || bound.bottom < 0 || bound.left > target.stage.stageWidth || bound.top > target.stage.stageHeight)
		{
			trace("目标尺寸或位置有问题");
		}
		
		// 截图检查透明区域
		var bmp:BitmapData = new BitmapData(target.width, target.height, true, 0);
		bmp.draw(target);
		var ta:Number;
		var alphaCount:int;
		for (var w:int = 0; w < bmp.width; w++)
		{
			for (var h:int = 0; h < bmp.height; h++)
			{
				ta = bmp.getPixel32(w, h) >>> 24;
				if (ta == 0)
					alphaCount++;
			}
		}
		trace("目标透明区域比例：", alphaCount / (w * h) * 100, "%", (alphaCount == (w * h)) ? "目标是透明的" : "");
		
		// 把组件放到最上层
		try
		{
			var tempParent:DisplayObject = target;
			while (tempParent.parent)
			{
				tempParent.parent.setChildIndex(tempParent, tempParent.parent.numChildren - 1);
				tempParent = tempParent.parent;
			}
			trace("已把目标放在最上层");
		}
		catch (e:Error)
		{
			trace("无法把目标放在最上层");
		}
		
		trace("如果上述信息无法给予帮助，请做如下检查：");
		trace("  · ", "查看目标位置是否为预定位置");
		trace("  · ", "查看目标背景是否与大背景一致");
		trace("  · ", "如果是文本组件，请检查text属性是否有值，color属性是否和背景一致");
		trace("  · ", "如果你遇到的情况不是上述情况，请告知，以便更新此函数");
	}
}