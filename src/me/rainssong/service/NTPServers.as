package me.rainssong.service
{
	import com.greensock.events.LoaderEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	import me.rainssong.date.DateCore;
	import me.rainssong.events.ObjectEvent;
	
	/**
	 * @date 2015/12/21 2:19
	 * @author rainssong
	 * @blog http://blog.sina.com.cn/rainssong
	 * @homepage http://rainsgameworld.sinaapp.com
	 * @weibo http://www.weibo.com/rainssong
	 */
	[Event(name = "complete", type = "events.Event")]
	public class NTPServers extends EventDispatcher
	{
		static public const SERVER_LIST:Array = [ "time-nw.nist.gov", "time-c.nist.gov", "time-d.nist.gov", "nist1-macon.macon.ga.us", "nist.netservicesgroup.com", "nist1-lnk.binary.net", "wwv.nist.gov", "time.nist.gov", "utcnist.colorado.edu", "utcnist2.colorado.edu", "ntp-nist.ldsbc.net", "nist-time-server.eoni.com", "nist-time-server.eoni.com"];
		static public var port:int = 13;
		
		private var _socket:Socket;
		private var _loadIndex:int = -1;
		private var _serverList:Array;
		private var _date:Date;
		
		public function NTPServers(serverList:Array=null)
		{
			if (serverList == null)
				serverList = SERVER_LIST;
			_serverList = serverList;
			_socket = new Socket();
			_socket.addEventListener(Event.CONNECT, onConnect);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
			_socket.addEventListener(Event.CLOSE, onClose);
			_socket.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
		}
		
		public function loadDate(index:int=-1):void
		{
			if (index < 0)
				_loadIndex++;
			else
				_loadIndex = index;
			if(_loadIndex< _serverList.length)
				_socket.connect(_serverList[_loadIndex], NTPServers.port);
			
		}
		
		private function onError(e:IOErrorEvent):void
		{
			powerTrace(e.type)
			loadDate();
		}
		
		private function onConnect(event:Event):void
		{
			powerTrace("已经成功连接到服务器！\n");
		}
		
		private function onSocketData(e:ProgressEvent):void
		{
			var str:String = _socket.readUTFBytes(_socket.bytesAvailable);
			str=str.replace(/[\n\r]/g, "");
			_date = DateCore.stringToDate(str, "xxxx YY-MM-DD hh:mm:ss");
			dispatchEvent(new ObjectEvent(Event.COMPLETE, _date));
		}
		
		private function onClose(event:Event):void
		{
			powerTrace("和服务器断开!\n")
		}
		
		public function destroy():void
		{
			_serverList = null;
			_socket.close();
			_socket.removeEventListener(Event.CONNECT, onConnect);
			_socket.removeEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
			_socket.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			_socket.removeEventListener(Event.CLOSE, onClose);
			_socket = null;
			
		}
	
	}

}