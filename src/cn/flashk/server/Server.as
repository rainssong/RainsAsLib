package cn.flashk.server
{
	import cn.flashk.API;

	public class Server extends SocketServer
	{
		public static var type:int = 1;
		
		private static var ins:IServer;
		
		public function Server()
		{
		}
		public static function init():void{
			if(type == 1){
				ins = new XMLSocketServer();
			}else{
				ins = new SocketServer();
			}
			API.server = ins;
		}
	}
}