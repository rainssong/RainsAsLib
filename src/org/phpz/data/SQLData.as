package org.phpz.data
{
    /**
     * author: Seven Yu
     * url: http://phpz.org/
     * */
    import flash.data.SQLConnection;
    import flash.data.SQLStatement;
    import flash.filesystem.File;
    import flash.net.Responder;
   
    public class SQLData
    {
        private var dbFile:File = new File();
        private var conn:SQLConnection = new SQLConnection();
        private var stmt:SQLStatement = new SQLStatement();
       
        public function SQLData(path:String = null)
        {
            if (null != path)
            {
                dbFile.nativePath = path;
                open(dbFile);
            }
        }
       
        //////////////////////////
        // public functions
        //////////////////////////
       
        /**
         * open database from path
         * */
        public function openPath(path:String):Boolean
        {
            dbFile.nativePath = path;
            return open(dbFile);
        }
       
        /**
         * open database from file
         * */
        public function openFile(file:File):Boolean
        {
            return open(file);
        }
       
        /**
         * close database connection
         * */
        public function close(responder:Responder = null):void
        {
            conn.connected && conn.close(responder);
        }
       
        /**
         * execute Select sql
         * @return Array SQLStatement.getResult().data;
         * */
        public function select(sql:String, prefetch:int = -1, responder:Responder = null):Array
        {
            stmt.text = sql;
            try
            {
                stmt.execute(prefetch, responder);
                return stmt.getResult().data;
            }
            catch (e:Error)
            {
                trace("<select>", e.message);
                trace(" - <SQL>", sql);
            }
            return null;
        }
       
        /**
         * ÷¥–– Insert Update ªÚ Create µ»”Ôæ‰
         * @return int SQLStatement.getResult().rowsAffected
         * */
        public function update(sql:String, prefetch:int = -1, responder:Responder = null):int
        {
            stmt.text = sql;
            try
            {
                stmt.execute(prefetch, responder);
                return stmt.getResult().rowsAffected;
            }
            catch (e:Error)
            {
                trace("<update>", e.message);
                trace(" - <SQL>", sql);
            }
            return -1;
        }
       
        ///////////////////////////
        // getter & setter
        ///////////////////////////
       
        /**
         * get database native path
         * @return String path
         * */
        public function get path():String
        {
            return dbFile.nativePath;
        }
       
        /**
         * get database file
         * @return File database file
         * */
        public function get file():File
        {
            return dbFile;
        }
       
        /**
         * get the last sql sentence
         * @return String sql
         * */
        public function get lastSQL():String
        {
            return stmt.text;
        }
       
        ///////////////////////////
        // private functions
        ///////////////////////////
       
        /**
         * open database connection
         * @private
         * */
        private function open(file:File):Boolean
        {
            dbFile = file;
            close();
            try
            {
                conn.open(dbFile);
                stmt.sqlConnection = conn;
            }
            catch (e:Error)
            {
                trace("  <open>", e.message);
                return false;
            }
            return true;
        }
    }
}