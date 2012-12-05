//----------------------------------------------------------------------------------------------------
// Note object used in PatternSequencer
//  Copyright (c) 2009 keim All rights reserved.
//  Distributed under BSD-style license (see org.si.license.txt).
//----------------------------------------------------------------------------------------------------


package org.si.sound.patterns {
    /** Note object used in PatternSequencer. */
    public class Note
    {
    // variables
    //--------------------------------------------------
        /** Note number[-1-127], -1 (or all negatives) sets playing with sequencers default note. */
        public var note:int = 0;
        /** Velocity[-1-128], -1 (or all negatives) sets playing with sequencers default velocity, 0 sets no note (rest). */
        public var velocity:int = 0;
        /** Length in 16th beat [16 for whole tone], Number.NaN sets playing with sequencers default length. */
        public var length:Number = 0;
        /** Voice index refering from PatternSequencer.voiceList, -1 (or all negatives) sets no voice changing.
         *  @see si.org.sound.PatternSequencer.voiceList 
         */
        public var voiceIndex:Number = 0;
        /** Any informations */
        public var data:* = null;
        
        
        
        
    // constructor
    //--------------------------------------------------
        /** constructor
         *  @param note Note number[-1-127], -1 sets playing with sequencer's default note.
         *  @param velocity Velocity[-1-128], -1 sets playing with sequencer's default velocity, 0 sets no note (rest).
         *  @param length Length in 16th beat [16 for whole tone], Number.NaN sets playing with sequencers default length.
         *  @param voiceIndex Voice index refering from PatternSequencer.voiceList, -1 (or all negatives) sets no voice changing.
         *  @param data Any informations you want.
         *  @see si.org.sound.PatternSequencer.voiceList.
         */
        function Note(note:int=-1, velocity:int=0, length:Number=Number.NaN, voiceIndex:int=-1, data:*=null)
        {
            this.note = note;
            this.velocity = velocity;
            this.length = length;
            this.voiceIndex = voiceIndex;
            this.data = data;
        }

        
        
        
    // operations
    //--------------------------------------------------
        /** Set note.
         *  @param note Note number[-1-127], -1 sets playing with sequencer's default note.
         *  @param velocity Velocity[-1-128], -1 sets playing with sequencer's default velocity, 0 sets no note (rest).
         *  @param length Length in 16th beat [16 for whole tone], Number.NaN sets playing with sequencers default length.
         *  @param voiceIndex Voice index refering from PatternSequencer.voiceList, -1 (or all negatives) sets no voice changing. @see si.org.sound.PatternSequencer.voiceList.
         *  @param data Any informations you want.
         *  @return this instance.
         */
        public function setNote(note:int=-1, velocity:int=-1, length:Number=Number.NaN, voiceIndex:int=-1, data:*=null) : Note
        {
            this.note = note;
            this.velocity = velocity;
            this.length = length;
            this.voiceIndex = voiceIndex;
            this.data = data;
            return this;
        }
        
        
        /** Set as rest. */
        public function setRest() : Note
        {
            velocity = 0;
            return this;
        }
        
        
        /** Copy from another note.
         *  @param src source note instnace.
         *  @return this instance
         */
        public function copyFrom(src:Note) : Note {
            if (src == null) return setRest();
            note = src.note;
            velocity = src.velocity;
            length = src.length;
            voiceIndex = src.voiceIndex;
            return this;
        }
        
        
        /** return new instance copied parameters from this note.
         *  @return new clone instance
         */
        public function clone() : Note {
            return new Note(note, velocity, length, voiceIndex);
        }
    }
}

