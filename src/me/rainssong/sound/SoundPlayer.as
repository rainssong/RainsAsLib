package MPViewer
{
    import flash.events.*;
    import flash.media.*;
    import flash.net.*;
    import flash.utils.*;

    public class SoundPlayer extends EventDispatcher
    {
        public var sound:Sound;
        public var timeLength:int;
        public var startTime:Number;
        public var positionTime:Number;
        public var positionSaved:Number;
        public var paused:Boolean = false;
        public var sndTrsForm:SoundTransform;
        public var soundChannel:SoundChannel;
        public var volumeValue:Number = 1;
        public var playState:int = 0;

        public function SoundPlayer(volume:Number) : void
        {
            sound = new Sound();
            this.volumeValue = param1;
            return;
        }// end function

        private function soundComplete(event:Event) : void
        {
            soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundComplete);
            event = new Event(Event.COMPLETE);
            this.dispatchEvent(event);
            return;
        }// end function

        public function playSound() : int
        {
            var _loc_2:Number = NaN;
            var _loc_3:Number = NaN;
            var _loc_4:int = 0;
            var _loc_5:Event = null;
            return 0;
        }// end function

        public function loadSound(param1:String) : void
        {
            var _loc_2:* = new String(param1 + "?" + getTimer() + " " + Math.round(Math.random() * 100));
            var _loc_3:* = new URLRequest(param1);
            var _loc_4:* = new SoundLoaderContext(1000);
            sound = new Sound();
            sound.addEventListener(Event.COMPLETE, soundLoaded);
            sound.addEventListener(IOErrorEvent.IO_ERROR, sound_ioerror);
            sound.load(_loc_3, _loc_4);
            return;
        }// end function

        public function stop() : void
        {
            if (soundChannel != null)
            {
                soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundComplete);
                soundChannel.stop();
            }
            return;
        }// end function

        private function sound_open(event:Event) : void
        {
            return;
        }// end function

        public function getLength() : Number
        {
            if (this.sound != null)
            {
                return sound.length;
            }
            return 0;
        }// end function

        public function getPosition() : Number
        {
            if (this.soundChannel != null)
            {
                return soundChannel.position;
            }
            return 0;
        }// end function

        public function start(param1:int) : void
        {
            this.positionTime = 0;
            this.soundChannel = sound.play();
            soundChannel.addEventListener(Event.SOUND_COMPLETE, soundComplete);
            this.startTime = getTimer();
            return;
        }// end function

        private function sound_progress(event:ProgressEvent) : void
        {
            return;
        }// end function

        public function restart(param1:int) : void
        {
            this.startTime = Math.round(getTimer());
            this.soundChannel = sound.play(this.positionSaved);
            soundChannel.addEventListener(Event.SOUND_COMPLETE, soundComplete);
            return;
        }// end function

        public function startPosition(param1:Number) : void
        {
            this.positionTime = 0;
            var _loc_2:* = sound.length;
            var _loc_3:* = param1 * _loc_2;
            this.soundChannel = sound.play(_loc_3);
            soundChannel.addEventListener(Event.SOUND_COMPLETE, soundComplete);
            this.startTime = getTimer();
            return;
        }// end function

        public function loadSoundClass(param1:Sound) : void
        {
            this.sound = param1;
            return;
        }// end function

        private function sound_ioerror(event:IOErrorEvent) : void
        {
            trace("sound ioerror");
            trace(event.target);
            trace(event.text);
            return;
        }// end function

        public function pause() : void
        {
            if (soundChannel != null)
            {
                soundChannel.removeEventListener(Event.SOUND_COMPLETE, soundComplete);
                this.positionTime = this.positionTime + Math.round(getTimer()) - this.startTime;
                this.positionSaved = Math.round(soundChannel.position);
                soundChannel.stop();
            }
            return;
        }// end function

        private function soundLoaded(event:Event) : void
        {
            this.timeLength = sound.length;
            sound.removeEventListener(Event.COMPLETE, soundLoaded);
            event = new Event(Event.OPEN);
            this.dispatchEvent(event);
            return;
        }// end function

    }
}
