package {
    import flash.display.*;
    import flash.events.*;

    public class Cheat {

        private static const cheatLetters:Vector.<String> = Vector.<String>(["CHEAT1", "Money", "UUDDLRLRBABA"]);

        private static var cheatActive:Vector.<Boolean>;
        private static var curLetters:Vector.<int>;
        private static var lastChar:String;

        public static function init(_arg1:Stage):void{
            lastChar = "";
            curLetters = Vector.<int>([]);
            cheatActive = Vector.<Boolean>([]);
            var _local2:int;
            while (_local2 < cheatLetters.length) {
                curLetters[_local2] = 0;
                cheatActive[_local2] = false;
                _local2++;
            };
            _arg1.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
        }
        private static function keyDownHandler(_arg1:KeyboardEvent):void{
            var _local3:int;
            var _local2:String = String.fromCharCode(_arg1.keyCode);
            if (_local2 != lastChar){
                _local3 = 0;
                while (_local3 < cheatLetters.length) {
                    if (_local2 == cheatLetters[_local3].charAt(curLetters[_local3])){
                        var _local4 = curLetters;
                        var _local5 = _local3;
                        var _local6 = (_local4[_local5] + 1);
                        _local4[_local5] = _local6;
                        if (_local6 >= cheatLetters[_local3].length){
                            curLetters[_local3] = 0;
                            activate(cheatLetters[_local3]);
                        };
                    } else {
                        curLetters[_local3] = 0;
                    };
                    _local3++;
                };
            };
        }
        private static function activate(_arg1:String):void{
            var _local3:int;
        }
        public static function isActive(_arg1:String):Boolean{
            return (cheatActive[cheatLetters.indexOf(_arg1)]);
        }

    }
}//package firebeast 