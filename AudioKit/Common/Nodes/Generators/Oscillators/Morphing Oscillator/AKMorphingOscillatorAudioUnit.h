//
//  AKMorphingOscillatorAudioUnit.h
//  AudioKit
//
//  Created by Aurelius Prochazka, revision history on Github.
//  Copyright (c) 2016 Aurelius Prochazka. All rights reserved.
//

#ifndef AKMorphingOscillatorAudioUnit_h
#define AKMorphingOscillatorAudioUnit_h

#import <AudioToolbox/AudioToolbox.h>

@interface AKMorphingOscillatorAudioUnit : AUAudioUnit
@property (nonatomic) float frequency;
@property (nonatomic) float amplitude;
@property (nonatomic) float index;

- (void)finalize;
- (void)setupWaveform:(UInt32)waveform size:(int)size;
- (void)setWaveform:(UInt32)waveform withValue:(float)value atIndex:(UInt32)index;
- (void)start;
- (void)stop;
- (BOOL)isPlaying;
@end

#endif /* AKMorphingOscillatorAudioUnit_h */
