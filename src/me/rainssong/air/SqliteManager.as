package me.rainssong.air
{
	import flash.data.SQLConnection;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.errors.SQLError;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.net.Responder;
	
	/**
	 * ...
	 * @author rainssong
	 */
	public class SqliteManager
	{
		private var _conn:SQLConnection = new SQLConnection();
		private var _file:File
		private var _statement:SQLStatement = new SQLStatement();
		private var _result:SQLResult;
		private var _isSync:Boolean = true;
		
		public function SqliteManager()
		{
			_statement.sqlConnection = _conn;
			_conn.addEventListener(SQLEvent.OPEN, onOpen);
			_conn.addEventListener(SQLErrorEvent.ERROR, onError);
			_statement.addEventListener(SQLEvent.RESULT, onExecute);
			_statement.addEventListener(SQLErrorEvent.ERROR, onError);
		}
		
		public function open(path:String, isSync:Boolean = true):void
		{
			_file = File.applicationStorageDirectory.resolvePath(path);
			_file.parent.createDirectory();
			
			_isSync = isSync;
			if (isSync)
				_conn.open(_file);
			else
				_conn.openAsync(_file);
		}
		
		private function onExecute(e:SQLEvent):void 
		{
			_result = _statement.getResult();
			powerTrace(_result.data);
		}
		
		private function onOpen(e:SQLEvent):void
		{
			powerTrace(e);
		}
		
		private function onError(event:SQLErrorEvent):void
		{
			powerTrace("Error message:", event.error.message);
			powerTrace("Details:", event.error.details);
		}
		
		public function execute(sql:String):SQLResult
		{
			try
			{
				_statement.text = sql;
				_statement.execute();
			}
			catch (error:SQLError)
			{
				powerTrace("Error message:", error.message);
				powerTrace("Details:", error.details);
			}
			return _statement.getResult();
		}
		
		/* DELEGATE flash.data.SQLConnection */
		
		public function close(responder:Responder = null):void 
		{
			_conn.close(responder);
		}
		
		public function get result():SQLResult 
		{
			return _result;
		}
		
		public function get isSync():Boolean 
		{
			return _isSync;
		}
	
	}

}