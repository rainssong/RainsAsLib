//----------------------------------------------------------------------------------------------------
// MIDI sound module operator
//  Copyright (c) 2011 keim All rights reserved.
//  Distributed under BSD-style license (see org.si.license.txt).
//----------------------------------------------------------------------------------------------------


package org.si.sion.midi {
    /** MIDI sound module channel */
    public class MIDIModuleChannel
    {
    // variables
    //--------------------------------------------------------------------------------
        /** active operator count of this channel */
        public var activeOperatorCount:int;
        /** maximum operator limit of this channel */
        public var maxOperatorCount:int;
        
        public var drumMode:int;
        public var mute:Boolean;
        public var programNumber:int;
        public var pan:int;
        public var modulation:int;
        public var pitchBend:int;
        public var channelAfterTouch:int;
        public var sustainPedal:Boolean;
        public var portamento:Boolean;
        public var portamentoTime:int;
        public var masterFineTune:int;
        public var masterCoarseTune:int;
        public var pitchBendSensitivity:int;
        public var modulationCycleTime:int;
        
        public var eventTriggerID:int;
        public var eventTriggerTypeOn:int;
        public var eventTriggerTypeOff:int;
        
        public var bankNumber:int;
        
        
        /** @private */
        internal var _sionVolumes:Vector.<int> = new Vector.<int>(8);
        /** @private */
        internal var _effectSendLevels:Vector.<int> = new Vector.<int>(8);

        private var _expression:int;
        private var _masterVolume:int;
        
        
        
        
    // properties
    //--------------------------------------------------------------------------------
        /** master volume (0-127) */
        public function get masterVolume() : int { return _masterVolume; }
        public function set masterVolume(v:int) : void { _masterVolume = v; _updateVolumes(); }
        
        
        /** expression (0-127) */
        public function get expression() : int { return _expression; }
        public function set expression(e:int) : void { _expression = e; _updateVolumes(); }
        
        
        // update all volumes of SiON tracks
        private function _updateVolumes() : void {
            var v:int = (_masterVolume * _expression + 64) >> 7;
            _sionVolumes[0] = _effectSendLevels[0] = v;
            for (var i:int =1; i<8; i++) {
                _sionVolumes[i] = (v * _effectSendLevels[i] + 64) >> 7;
            }
        }
        
        
        
    // constructor
    //--------------------------------------------------------------------------------
        /** @private */
        function MIDIModuleChannel()
        {
            mute = false;
            eventTriggerID = 0;
            eventTriggerTypeOn = 0;
            eventTriggerTypeOff = 0;
            reset();
        }
        
        
        
        
    // operations
    //--------------------------------------------------------------------------------
        /** reset this channel */
        public function reset() : void
        {
            activeOperatorCount = 0;
            maxOperatorCount = 1024;
            
            //mute = false;
            drumMode = 0;
            programNumber = 0;
            _expression = 127;
            _masterVolume = 64;
            pan = 0;
            modulation = 0;
            pitchBend = 0;
            channelAfterTouch = 0;
            sustainPedal = false;
            portamento = false;
            portamentoTime = 0;
            masterFineTune = 0;
            masterCoarseTune = 0;
            pitchBendSensitivity = 2;
            modulationCycleTime = 180;
            
            bankNumber = 0;
            
            _sionVolumes[0] = _masterVolume;
            _effectSendLevels[0] = _masterVolume;
            for (var i:int = 1; i<8; i++) {
                _sionVolumes[i] = 0;
                _effectSendLevels[i] = 0;
            }
        }
        
        
        /** get effect send level 
         *  @param slotNumber effect slot number (1-8)
         *  @return effect send level
         */
        public function getEffectSendLevel(slotNumber:int) : int { 
            return _effectSendLevels[slotNumber];
        }
        
        
        /** set effect send level 
         *  @param slotNumber effect slot number (1-8)
         *  @param level effect send level (0-127)
         */
        public function setEffectSendLevel(slotNumber:int, level:int) : void {
            _effectSendLevels[slotNumber] = level;
            _sionVolumes[slotNumber] = (_effectSendLevels[0] * _effectSendLevels[slotNumber] + 64) >> 7;
        }
        
        
        /** set event trigger of this channel
         *  @param id Event trigger ID of this track. This value can be refered from SiONTrackEvent.eventTriggerID.
         *  @param noteOnType Dispatching event type at note on. 0=no events, 1=NOTE_ON_FRAME, 2=NOTE_ON_STREAM, 3=both.
         *  @param noteOffType Dispatching event type at note off. 0=no events, 1=NOTE_OFF_FRAME, 2=NOTE_OFF_STREAM, 3=both.
         *  @see org.si.sion.events.SiONTrackEvent
         */
        public function setEventTrigger(id:int, noteOnType:int=1, noteOffType:int=0) : void
        {
            eventTriggerID = id;
            eventTriggerTypeOn = noteOnType;
            eventTriggerTypeOff = noteOffType;
        }
    }
}

