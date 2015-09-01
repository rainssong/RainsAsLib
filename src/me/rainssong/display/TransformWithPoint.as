package me.rainssong.display{

	import flash.display.DisplayObject;

	import flash.geom.Point;

	import flash.geom.Matrix;



	/**NinePointsCotrolExample
	
	         * 2008/12/25
	
	         * @author  Nodihsop
	
	         */



	public class TransformWithPoint {



		public static  function transformWithExternalPoint(displayOb:DisplayObject,regPiont:Point,angleDegrees:Number=0,sx:Number=1,sy:Number=1):void {//自身坐标系

			var m:Matrix=displayOb.transform.matrix;

			m.tx-= regPiont.x;

			m.ty-= regPiont.y;

			if (angleDegrees % 360 != 0) {

				m.rotate(angleDegrees * Math.PI / 180);

			}

			if (sx != 1 || sy != 1) {

				m.scale(sx,sy);

			}

			m.tx+= regPiont.x;

			m.ty+= regPiont.y;

			displayOb.transform.matrix=m;

		}

		public static  function transformWithInternalPoint(displayOb:DisplayObject,regPiont:Point,angleDegrees:Number=0,sx:Number=1,sy:Number=1):void {//容器坐标系

			var m:Matrix=displayOb.transform.matrix;

			regPiont=m.transformPoint(regPiont);

			m.tx-= regPiont.x;

			m.ty-= regPiont.y;

			if (angleDegrees % 360 != 0) {

				m.rotate(angleDegrees * Math.PI / 180);

			}

			if (sx != 1 || sy != 1) {

				m.scale(sx,sy);

			}

			m.tx+= regPiont.x;

			m.ty+= regPiont.y;

			displayOb.transform.matrix=m;

		}

	}

}