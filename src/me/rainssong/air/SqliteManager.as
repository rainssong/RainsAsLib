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
			
		
		}
		
		private function onExecute(e:SQLEvent):void 
		{
			_result = _statement.getResult();
			_conn.close();
		}
		
		private function onOpen(e:SQLEvent):void
		{
			
		}
		
		private function onError(event:SQLErrorEvent):void
		{
			powerTrace("Error Message:", event.error.message);
			powerTrace("Details:", event.error.details);
			powerTrace("SQL:", _statement.text);
			_conn.close();
		}
		
		public function execute(sql:String,prefetch:int=-1, responder:Responder=null):SQLResult
		{
			try
			{
				_conn.open(_file);
				_statement.text = sql;
				_statement.execute(prefetch, responder);
				return _result;
			}
			catch (error:SQLError)
			{
				powerTrace("Error Message:", error.message);
				powerTrace("Details:", error.details);
				powerTrace("SQL:", sql);
				_conn.close();
			}
			return null;
			
			
			//_conn.open(_file);
			//_statement.text = sql;
			//_statement.addEventListener(SQLEvent.RESULT,resultHandler);
			//_statement.addEventListener(SQLErrorEvent.ERROR,errorHandler);
			//try {
				//_statement.execute();
			//}catch (evt:SQLError) {
				//throw new Error("执行SQL数据出错");
			//}
			//return _result;
		}
		
        public function sqlSelect(sql:String, prefetch:int = -1, responder:Responder = null):Array
        {
			var result:SQLResult = execute(sql, prefetch, responder);
			
			var data:Array = result?result.data:[];
			data ||= [];
            return data;
        }
      
        public function sqlUpdate(sql:String, prefetch:int = -1, responder:Responder = null):int
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
		
		/**
		 * 创建一个数据表
		 * @param	name 表名称
		 * @param	template 字段与字段类型对象，例如{name:"*",age:"*"}
		 */
		public function creatTable(name:String,template:Object):void {
			//创建数据库表;
			var sql:String = "create table if not exists " + name + " ( ";
			sql += "id integer primary key autoincrement, ";//序号，自动生成
			for (var att:String in template) {
				sql += (att + " " + template[att] + ", ");
			}
			sql = sql.substring(0, sql.length - 2);
			sql += ")";
			execute(sql);
		}
		
		public function select(name:String, fields:Array=null,where:Object = null,oa:String="OR"):Array {
			if (!fields) {
				fields = new Array("*");
			}
			var sql:String;
			var s1:String = "SELECT ";
			if (fields[0] == "*"||fields[0] == null) {
				s1 += "* FROM "+name;
			}else {
				for each(var obj1:String in fields) {
					s1 += obj1 + ",";
				}
				s1=s1.substr(0,s1.length-1);
				s1 += " FROM "+name;
			}
			if (where) {
				var s2:String = " WHERE ";
				for (var obj2:String in where) {
					if (where[obj2] is Number) {
						s2 += obj2 + "=" + where[obj2]+" "+oa+" ";
					}else {
						//where[obj2] = StringTools.replaceAllByRegex(where[obj2], "'", "‘");
						s2 += obj2 + "='" + where[obj2] + "' " + oa + " ";
						
					}
				}
				s2 = s2.substr(0, (s2.length - (oa.length+1)));
				sql = s1 + s2;
			}else {
				sql = s1;
			}
			return sqlSelect(sql);
			//trace("statement.getResult().data:"+statement.getResult().data);
			//return (statement.getResult().data as Array);
		}
		
		public function update(name:String, dataObj:Object, where:Object):void {
			var sql:String;
			var s1:String = "UPDATE "+name+" SET ";
			var s2:String = "WHERE ";
			for (var obj:String in dataObj) {
				
				s1 += obj + "='"+dataObj[obj] + "',";
			}
			s1 = s1.substring(0, s1.length - 1);
			
			for (obj in where) {
				s2 += (obj + "='" + where[obj] + "' AND ");
			}
			s2 = s2.substr(0, s2.length - 5);
			sql = s1 +" " + s2;
			execute(sql);
		}
		
		public function insert(name:String,dataObj:Object):void {	
			var sql:String;
			var sqlStr:String = "INSERT INTO "+name+" (";
			var sqlStr2:String = "VALUES(";
			for (var obj:String in dataObj) {
				sqlStr += (obj + ",");
				//dataObj[obj] = StringTools.replaceAllByRegex(dataObj[obj], "'", "‘");
				sqlStr2 += ("'"+dataObj[obj] + "',");
			}
			sqlStr=sqlStr.substring(0, sqlStr.length - 1);
			sqlStr2 = sqlStr2.substring(0, sqlStr2.length - 1);
			sqlStr = sqlStr + ")";
			sqlStr2 = sqlStr2 + ")";
			sql = sqlStr + " " + sqlStr2;
			execute(sql);
		}
		
		public function deleteData(tableName:String,where:Object=null):void
		{
			var sql:String;
			var s1:String = "DELETE FROM " + tableName + " ";
			
			if (where != null)
			{
				var s2:String = "WHERE ";
				for (var obj:String in where) {
					s2 += (obj + "='" + where[obj] + "' AND ");
				}
				s2 = s2.substr(0, s2.length - 5);
				sql = s1 +" " + s2;
			}
			else
			{
				sql = s1;
			}
			
			execute(sql);
		}
		
		public function addColumn(tableName:String,template:Object=null):void
		{
			var sql:String;
			for (var att:String in template) {
				sql = "alter table "+ tableName +" add " ;
				sql += att + " " + template[att];
				execute(sql);
			}
			
		}
	
	}

}