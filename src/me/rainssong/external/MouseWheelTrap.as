package me.rainssong.external
{
    import flash.display.*;
    import flash.errors.*;
    import flash.events.*;
    import flash.external.*;

    public class MouseWheelTrap
    {
        private const INSTANTIATION_ERROR:String = "Don\'t instantiate com.spikything.utils.MouseWheelTrap directly. Just call MouseWheelTrap.setup(stage);";
        private static const JAVASCRIPT:String = "var browserScrolling;function allowBrowserScroll(value){browserScrolling=value;}function handle(delta){if(!browserScrolling){return false;}return true;}function wheel(event){var delta=0;if(!event){event=window.event;}if(event.wheelDelta){delta=event.wheelDelta/120;if(window.opera){delta=-delta;}}else if(event.detail){delta=-event.detail/3;}if(delta){handle(delta);}if(!browserScrolling){if(event.preventDefault){event.preventDefault();}event.returnValue=false;}}if(window.addEventListener){window.addEventListener(\'DOMMouseScroll\',wheel,false); window.addEventListener(\'mousewheel\',wheel,false); window.addEventListener(\'wheel\',wheel,false);}window.onmousewheel=document.onmousewheel=wheel;allowBrowserScroll(true);";
        private static const JS_METHOD:String = "allowBrowserScroll";
        private static var _browserScrollEnabled:Boolean = true;
        private static var _mouseWheelTrapped:Boolean = false;

        public function MouseWheelTrap()
        {
            throw new IllegalOperationError(this.INSTANTIATION_ERROR);
        }// end function

        public static function setup(stage:Stage) : void
        {
            var stage:* = stage;
            stage.addEventListener(MouseEvent.MOUSE_MOVE, function (stage = null) : void
            {
                allowBrowserScroll(false);
                return;
            }// end function
            );
            stage.addEventListener(Event.MOUSE_LEAVE, function (stage = null) : void
            {
                allowBrowserScroll(true);
                return;
            }// end function
            );
            return;
        }// end function

        private static function allowBrowserScroll(isOpen:Boolean) : void
        {
            var allow:* = isOpen;
            createMouseWheelTrap();
            if (allow == _browserScrollEnabled)
            {
                return;
            }
            _browserScrollEnabled = allow;
            try
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call(JS_METHOD, _browserScrollEnabled);
                    return;
                }
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

        private static function createMouseWheelTrap() : void
        {
            if (_mouseWheelTrapped)
            {
                return;
            }
            _mouseWheelTrapped = true;
            try
            {
                if (ExternalInterface.available)
                {
                    ExternalInterface.call("eval", JAVASCRIPT);
                    return;
                }
            }
            catch (e:Error)
            {
            }
            return;
        }// end function

    }
}
