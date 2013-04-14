package me.rainssong.math

{
	//像素级精确碰撞算法优化
	//代码：Aone
	//2009-10-30
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;



	public class BitmapHitTestPlus

	{
		
		public static var tileSize:int=20	
		public static function complexHitTestObject(target1:DisplayObject, target2:DisplayObject):Boolean
		{
			//横向缩小到tileSize尺寸需要的倍数，也就是期望检测的时候缩小到的尺寸。
			var scaleX:Number = (target1.width < target2.width ? target1.width : target2.width) / BitmapHitTestPlus.tileSize 
			//纵向缩小到tileSize尺寸需要的倍
			var scaleY:Number = (target1.height < target2.height ? target1.height : target2.height) / BitmapHitTestPlus.tileSize 
			//
			//如果倍数小于1则按原始倍率也就是原始尺寸
			scaleX = scaleX < 1 ? 1 : scaleX
			scaleY = scaleY < 1 ? 1 : scaleY
			//draw用point
			var pt:Point=new Point()
			//做2次draw时使用的颜色
			var ct:ColorTransform=new ColorTransform()			
			ct.color=0xFF00000F	
			//原始尺寸下的重叠矩形		
			var oldHitRectangle:Rectangle=intersectionRectangle(target1, target2)
			//用于存放缩放的重叠矩形
			var hitRectangle:Rectangle= new Rectangle()
			return complexIntersectionRectangle(target1, target2 , scaleX , scaleY , pt , ct , oldHitRectangle,hitRectangle,BitmapHitTestPlus.tileSize,BitmapHitTestPlus.tileSize).width != 0;

		}		

		public static function intersectionRectangle(target1:DisplayObject, target2:DisplayObject):Rectangle

		{

			// If either of the items don't have a reference to stage, then they are not in a display list

			// or if a simple hitTestObject is false, they cannot be intersecting.

			if (!target1.root || !target2.root || !target1.hitTestObject(target2))
				return new Rectangle();



			// Get the bounds of each DisplayObject.

			var bounds1:Rectangle=target1.getBounds(target1.root);

			var bounds2:Rectangle=target2.getBounds(target2.root);



			// Determine test area boundaries.

			var intersection:Rectangle=new Rectangle();

			intersection.x=Math.max(bounds1.x, bounds2.x);

			intersection.y=Math.max(bounds1.y, bounds2.y);

			intersection.width=Math.min((bounds1.x + bounds1.width) - intersection.x, (bounds2.x + bounds2.width) - intersection.x);

			intersection.height=Math.min((bounds1.y + bounds1.height) - intersection.y, (bounds2.y + bounds2.height) - intersection.y);


				
			return intersection;

		}

		public static function complexIntersectionRectangle(target1:DisplayObject, target2:DisplayObject, scaleX:Number , scaleY:Number , pt:Point , ct:ColorTransform ,oldhitRectangle:Rectangle,hitRectangle:Rectangle,nowW:int,nowH:int):Rectangle

		{		
			if (!target1.hitTestObject(target2))
				return new Rectangle();
			//根据纵横的缩小倍数来计算缩小的重叠矩形尺寸
			hitRectangle.x = oldhitRectangle.x
			hitRectangle.y = oldhitRectangle.y
			hitRectangle.width = oldhitRectangle.width / scaleX
			hitRectangle.height = oldhitRectangle.height / scaleY
			//建立一个用来draw的临时BitmapData对象，尺寸为期望宽nowW,期望高nowH
			var bitmapData:BitmapData=new BitmapData(nowW,nowH, true, 0);			
			//绘制对象1其缩放比例和位移量由getDrawMatrix（）函数计算，并且把不透明处绘制为ct的颜色
			bitmapData.draw(target1, BitmapHitTestPlus.getDrawMatrix(target1, hitRectangle , scaleX , scaleY ),ct);
			//当纵横缩小比例不为1的时候把任何有色像素重新替换成ct的颜色0xFF00000F，原因为缩小的对象在进行纯色绘制的时候会有半透明像素产生，如果不加以重新替换会影响后面对象2的滤镜效果。
			if(scaleX!=1&&scaleY!=1){
				bitmapData.threshold(bitmapData,bitmapData.rect,pt,">",0,0xFF00000F)
			}
			//绘制对象2其缩放比例和位移量由getDrawMatrix（）函数计算，并且把不透明处绘制为ct的颜色，并且模式为叠加。如此一来两个对象重叠的部分颜色值必定大于0xFF00000F。
			bitmapData.draw(target2, BitmapHitTestPlus.getDrawMatrix(target2, hitRectangle , scaleX , scaleY ),ct, BlendMode.ADD);
			//把所有颜色值大于0xFF00000F的部分（也就是重叠部分）重新替换为不透明红色方便后面getColorBoundsRect()方法计算尺寸。这里替换的原因是getColorBoundsRect()不支持范围取色而只支持单色计算。
			//对象1缩放后可以重新替换掉透明色，但是对象2则无法使用同一方法，但是对象2由于也是经过缩放绘制也会有半透明像素，那么重叠部分虽然全部大于0xFF00000F，但未必是统一的。
			var hits:int=bitmapData.threshold(bitmapData,bitmapData.rect,pt,">",0xFF00000F,0xFFFF0000)
			//判断红色区域尺寸
			var intersection:Rectangle=bitmapData.getColorBoundsRect(0xFFFFFFFF, 0xFFFF0000);
			//		
			
			bitmapData = null
			//如果红色区域宽度不为0，即bitmapData中含有红色像素。此时说明对象1和对象2在此次判定中有重叠有碰撞
			if(intersection.width!=0){				
				//如果纵横缩放比例有任意一个不是原始尺寸
				if(scaleX>1||scaleY>1){
					//并且红色像素的数量比较少，对象1和对象2的碰撞面积比较小的话
					if(hits<=(scaleX+scaleY)*1.5){
						//由于bitmapData的宽高坐标都是以整数表示，那么经过缩放后取整的区域势必回又可能在取整的时候把真正可能产生碰撞的区域忽略。
						//所以要进行下一次检测时候适当的把检测区域扩大xadd和yadd就是这个扩大的系数
						var xadd:int=.5
						var yadd:int=.5
						//下次检测时候bitmapData的期望大小
						var nextW:int=BitmapHitTestPlus.tileSize
						var nextH:int=BitmapHitTestPlus.tileSize
						//如果此次判定发现碰撞区域和bitmapData尺寸相同，那么在计算下次需要判断区域时候会和此次的区域相同，那么判断结果可能会和此次结果相同。这样则会引起堆栈上溢的情况，为了避免该情况发生，将缩小判断的尺寸扩大一倍进行再次检测。
						if(intersection.width!=nowW){
							nextW=BitmapHitTestPlus.tileSize					
						}else{
							nextW=nowW*2
						}				
						if(intersection.height!=nowH){
							nextH=BitmapHitTestPlus.tileSize
						}else{
							nextH=nowH*2
						}
						//根据检测出来的缩的碰撞区域来计算未缩小的碰撞区域大小以方便下一次计算的时候缩小检测范围。
						oldhitRectangle.x += (intersection.x - xadd) * scaleX
						oldhitRectangle.y += (intersection.y - yadd) * scaleY
						oldhitRectangle.width = (intersection.width + xadd*2) * scaleX
						oldhitRectangle.height = (intersection.height + yadd*2)  * scaleY
						//根据检测期望缩小到的尺寸重新计算缩小倍率
						scaleX = (oldhitRectangle.width / nextW) 
						scaleY = (oldhitRectangle.height / nextH)
						//如果倍率小于2则直接按原始尺寸 
						scaleX = scaleX < 2 ? 1 : scaleX
						scaleY = scaleY < 2 ? 1 : scaleY
						//进行下一次判定
						intersection=complexIntersectionRectangle(target1,target2, scaleX , scaleY ,pt,ct,oldhitRectangle,hitRectangle,nextW,nextH)							
					}
				}
			}
				
			
			return intersection;

		}

		protected static function getDrawMatrix(target:DisplayObject, hitRectangle:Rectangle , scaleX:Number , scaleY:Number ):Matrix

		{

			var localToGlobal:Point;
			var matrix:Matrix;
			var rootConcatenatedMatrix:Matrix=target.root.transform.concatenatedMatrix;



			localToGlobal=target.localToGlobal(new Point());

			matrix=target.transform.concatenatedMatrix;

			matrix.tx=(localToGlobal.x - hitRectangle.x) / scaleX;

			matrix.ty=(localToGlobal.y - hitRectangle.y) / scaleY;			
			
			matrix.a=matrix.a / rootConcatenatedMatrix.a / scaleX ;
			matrix.d=matrix.d / rootConcatenatedMatrix.d / scaleY;		

			return matrix;

		}


	}



}


