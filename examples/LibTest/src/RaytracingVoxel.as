/**
*Simple Raytracing Voxel Demo
*August 26, 2011
*Bruce Jawn
*http://bruce-lab.blogspot.com
* 
*Copyright (c) <2011> <Bruce Jawn>
*This software is released under the MIT License 
*<http://www.opensource.org/licenses/mit-license.php>
**/
package {
    import flash.display.*;
    import flash.events.*;
    public class RaytracingVoxel extends Sprite {

        var eyeX:int=128;
        var eyeY:int=128;
        var eyeZ:int=-300;

        var rayX:Number;
        var rayY:Number;
        var rayZ:Number;
        var rayLen:Number;

        var color:uint;

        var xx:int=0;
        var yy:int=0;
        var zz:int=0;

        var voxelData:Array=[];

        private var ScreenData:BitmapData=new BitmapData(256,256,false,0xffff00);
        private var Screen:Bitmap=new Bitmap(ScreenData);

        public function RaytracingVoxel():void {
            createVoxel();
            addChild(Screen);
            addEventListener(Event.ENTER_FRAME,render);
        }//end of RaytracingVoxel

        private function createVoxel():void {
            //bounding box
            for (var i:int=0; i<256; i++) {
                for (var j:int=0; j<256; j++) {
                    color=i<<16|j<<8|0xff;
                    voxelData[i<<16|j<<8|255]=color;
                    voxelData[i<<16|255<<8|j]=color;
                    voxelData[255<<16|i<<8|j]=color;
                    voxelData[i<<16|0<<8|j]=color;
                    voxelData[0<<16|i<<8|j]=color;
                }
            }
            //cube
            for (var i:int=2; i<64; i++) {
                for (var j:int=2; j<64; j++) {
                    color=j<<16|j<<8|i;
                    voxelData[i<<16|63<<8|j]=color;
                    voxelData[63<<16|i<<8|j]=color;
                    voxelData[i<<16|2<<8|j]=color;
                    voxelData[2<<16|i<<8|j]=color;
                    voxelData[i<<16|j<<8|2]=color;
                }
            }
            //sphere
            for (var i:int=-64; i<64; i++) {
                for (var j:int=-64; j<64; j++) {
                    for (var k:int=-64; k<64; k++) {
                        if (i*i+j*j+k*k<64*64) {
                            voxelData[(i+128)<<16|(j+128)<<8|(k+64)]=(k+64)<<16|(i+64)<<8|(j+64);
                        }

                    }
                }
            }

        }//end of createVoxel

        private function render(event:Event):void {
            ScreenData.lock();
            for (var yy:int =0; yy<256; yy++) {
                rayX=xx-eyeX;
                rayY=yy-eyeY;
                rayZ=- eyeZ;

                rayLen=Math.sqrt(rayX*rayX+rayY*rayY+rayZ*rayZ);
                rayX/=rayLen;
                rayY/=rayLen;
                rayZ/=rayLen;
                color=0xffffff;

                for (var zz=0; zz<600; zz++) {
                    var crayX:int=rayX*zz+eyeX;
                    var crayY:int=rayY*zz+eyeY;
                    var crayZ:int=rayZ*zz+eyeZ;

                    if ((crayX>256)||(crayY>256)||(crayZ>256)) {
                        break;
                    }
                    if (voxelData[crayX<<16|crayY<<8|crayZ]>0) {
                        color=voxelData[crayX<<16|crayY<<8|crayZ];
                        break;
                    }

                }
                ScreenData.setPixel(xx,yy,color);
            }
            ScreenData.unlock();
            xx++;
            if (xx>256) {
                removeEventListener(Event.ENTER_FRAME,render);
            }
        }

    }//end of class
}//end of package