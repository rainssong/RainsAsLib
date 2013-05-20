package cn.flashk.map.move
{
	public class MapTileModel implements IMapTileModel
	{
		private var data:Array;
		
		public function MapTileModel()
		{
		}
		public function isBlock(p_startX : int, p_startY : int, p_endX : int, p_endY : int) : int{
			
			if(data[p_endX][p_endY]=="1"){
				if(p_endX==p_startX || p_endY==p_startY){
					return 1;
				}else if(data[p_startX][p_endY]==0 || data[p_endX][p_startY]==0){
					return 0;
				}else{
					return 1;
				}
			}else{
				return 0;
			}
			return 1;
		}
		public function checkAbleTo(x:int,y:int):Boolean{
			if(data[x][y]=="1"){
				return true;
			}else{
				return false;
			}
		}
		public function rebuild(blockData:String,length:uint):void{
			data = new Array();
			var index:int = 0;
			for(var i:int=0;i<length;i++){
				data[i] = ("0"+blockData.slice(i*length,i*length+length)).split("");
				//trace(data[i]);
			}
		}
	}
}