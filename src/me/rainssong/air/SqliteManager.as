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
			powerTrace(_result.complete);
		}
		
		private function onOpen(e:SQLEvent):void
		{
			powerTrace(e);
		}
		
		private function onError(event:SQLErrorEvent):void
		{
			powerTrace("Error Message:", event.error.message);
			powerTrace("Details:", event.error.details);
		}
		
		public function execute(sql:String,prefetch:int=-1, responder:Responder=null):SQLResult
		{
			try
			{
				_statement.text = sql;
				_statement.execute(prefetch, responder);
				return _statement.getResult();
			}
			catch (error:SQLError)
			{
				powerTrace("Error Message:", error.message);
				powerTrace("Details:", error.details);
			}
			return null;
		}
		
        public function select(sql:String, prefetch:int = -1, responder:Responder = null):Array
        {
			var data:Array=execute(sql, prefetch, responder).data as Array;
            return data;
        }
      
        public function update(sql:String, prefetch:int = -1, responder:Responder = null):int
        {
            var sqlResult:SQLResult=execute(sql, prefetch, responder);
            return sqlResult!=null?sqlResult.rowsAffected:-1;
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