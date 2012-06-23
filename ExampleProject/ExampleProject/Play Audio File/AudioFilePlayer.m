//
//  AudioFilePlayer.m
//  ExampleProject
//
//  Created by Aurelius Prochazka on 6/16/12.
//  Copyright (c) 2012 Hear For Yourself. All rights reserved.
//

#import "AudioFilePlayer.h"
#import "OCSLoopingOscillator.h"
#import "OCSReverb.h"
#import "OCSOutputStereo.h"

@implementation AudioFilePlayer

-(id) init {
    self = [super init];
    if (self) {
        
        // INSTRUMENT DEFINITION ===============================================
        
        NSString * file = [[NSBundle mainBundle] pathForResource:@"hellorcb" ofType:@"aif"];
        OCSSoundFileTable * fileTable = [[OCSSoundFileTable alloc] initWithFilename:file];
        [self addFunctionTable:fileTable];
        
        OCSLoopingOscillator * trigger = 
        [[OCSLoopingOscillator alloc] initWithSoundFileTable:fileTable];
        [self addOpcode:trigger];
        
        OCSReverb * reverb = 
        [[OCSReverb alloc] initWithMonoInput:[trigger output1] 
                               FeedbackLevel:ocsp(0.85)
                             CutoffFrequency:ocsp(12000)];
        
        [self addOpcode:reverb];
        
        // AUDIO OUTPUT ========================================================

        OCSOutputStereo * stereoOutput = 
        [[OCSOutputStereo alloc] initWithInputLeft:[reverb outputLeft] 
                                        InputRight:[reverb outputRight]]; 
        [self addOpcode:stereoOutput];
    }
    return self;
}

-(void) play {
    [self playNoteForDuration:3.0f];
}

@end
