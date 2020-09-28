// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import CAudioKit

/// 8 FDN stereo zitareverb algorithm, imported from Faust.
public class ZitaReverb: Node, AudioUnitContainer, Tappable, Toggleable {

    public static let ComponentDescription = AudioComponentDescription(effect: "zita")

    public typealias AudioUnitType = InternalAU

    public private(set) var internalAU: AudioUnitType?

    // MARK: - Parameters

    public static let predelayDef = NodeParameterDef(
        identifier: "predelay",
        name: "Delay in ms before reverberation begins.",
        address: akGetParameterAddress("ZitaReverbParameterPredelay"),
        range: 0.0 ... 200.0,
        unit: .generic,
        flags: .default)

    /// Delay in ms before reverberation begins.
    @Parameter public var predelay: AUValue

    public static let crossoverFrequencyDef = NodeParameterDef(
        identifier: "crossoverFrequency",
        name: "Crossover frequency separating low and middle frequencies (Hz).",
        address: akGetParameterAddress("ZitaReverbParameterCrossoverFrequency"),
        range: 10.0 ... 1_000.0,
        unit: .hertz,
        flags: .default)

    /// Crossover frequency separating low and middle frequencies (Hz).
    @Parameter public var crossoverFrequency: AUValue

    public static let lowReleaseTimeDef = NodeParameterDef(
        identifier: "lowReleaseTime",
        name: "Time (in seconds) to decay 60db in low-frequency band.",
        address: akGetParameterAddress("ZitaReverbParameterLowReleaseTime"),
        range: 0.0 ... 10.0,
        unit: .seconds,
        flags: .default)

    /// Time (in seconds) to decay 60db in low-frequency band.
    @Parameter public var lowReleaseTime: AUValue

    public static let midReleaseTimeDef = NodeParameterDef(
        identifier: "midReleaseTime",
        name: "Time (in seconds) to decay 60db in mid-frequency band.",
        address: akGetParameterAddress("ZitaReverbParameterMidReleaseTime"),
        range: 0.0 ... 10.0,
        unit: .seconds,
        flags: .default)

    /// Time (in seconds) to decay 60db in mid-frequency band.
    @Parameter public var midReleaseTime: AUValue

    public static let dampingFrequencyDef = NodeParameterDef(
        identifier: "dampingFrequency",
        name: "Frequency (Hz) at which the high-frequency T60 is half the middle-band's T60.",
        address: akGetParameterAddress("ZitaReverbParameterDampingFrequency"),
        range: 10.0 ... 22_050.0,
        unit: .hertz,
        flags: .default)

    /// Frequency (Hz) at which the high-frequency T60 is half the middle-band's T60.
    @Parameter public var dampingFrequency: AUValue

    public static let equalizerFrequency1Def = NodeParameterDef(
        identifier: "equalizerFrequency1",
        name: "Center frequency of second-order Regalia Mitra peaking equalizer section 1.",
        address: akGetParameterAddress("ZitaReverbParameterEqualizerFrequency1"),
        range: 10.0 ... 1_000.0,
        unit: .hertz,
        flags: .default)

    /// Center frequency of second-order Regalia Mitra peaking equalizer section 1.
    @Parameter public var equalizerFrequency1: AUValue

    public static let equalizerLevel1Def = NodeParameterDef(
        identifier: "equalizerLevel1",
        name: "Peak level in dB of second-order Regalia-Mitra peaking equalizer section 1",
        address: akGetParameterAddress("ZitaReverbParameterEqualizerLevel1"),
        range: -100.0 ... 10.0,
        unit: .generic,
        flags: .default)

    /// Peak level in dB of second-order Regalia-Mitra peaking equalizer section 1
    @Parameter public var equalizerLevel1: AUValue

    public static let equalizerFrequency2Def = NodeParameterDef(
        identifier: "equalizerFrequency2",
        name: "Center frequency of second-order Regalia Mitra peaking equalizer section 2.",
        address: akGetParameterAddress("ZitaReverbParameterEqualizerFrequency2"),
        range: 10.0 ... 22_050.0,
        unit: .hertz,
        flags: .default)

    /// Center frequency of second-order Regalia Mitra peaking equalizer section 2.
    @Parameter public var equalizerFrequency2: AUValue

    public static let equalizerLevel2Def = NodeParameterDef(
        identifier: "equalizerLevel2",
        name: "Peak level in dB of second-order Regalia-Mitra peaking equalizer section 2",
        address: akGetParameterAddress("ZitaReverbParameterEqualizerLevel2"),
        range: -100.0 ... 10.0,
        unit: .generic,
        flags: .default)

    /// Peak level in dB of second-order Regalia-Mitra peaking equalizer section 2
    @Parameter public var equalizerLevel2: AUValue

    public static let dryWetMixDef = NodeParameterDef(
        identifier: "dryWetMix",
        name: "0 = all dry, 1 = all wet",
        address: akGetParameterAddress("ZitaReverbParameterDryWetMix"),
        range: 0.0 ... 1.0,
        unit: .generic,
        flags: .default)

    /// 0 = all dry, 1 = all wet
    @Parameter public var dryWetMix: AUValue

    // MARK: - Audio Unit

    public class InternalAU: AudioUnitBase {

        public override func getParameterDefs() -> [NodeParameterDef] {
            [ZitaReverb.predelayDef,
             ZitaReverb.crossoverFrequencyDef,
             ZitaReverb.lowReleaseTimeDef,
             ZitaReverb.midReleaseTimeDef,
             ZitaReverb.dampingFrequencyDef,
             ZitaReverb.equalizerFrequency1Def,
             ZitaReverb.equalizerLevel1Def,
             ZitaReverb.equalizerFrequency2Def,
             ZitaReverb.equalizerLevel2Def,
             ZitaReverb.dryWetMixDef]
        }

        public override func createDSP() -> DSPRef {
            akCreateDSP("ZitaReverbDSP")
        }
    }

    // MARK: - Initialization

    /// Initialize this reverb node
    ///
    /// - Parameters:
    ///   - input: Input node to process
    ///   - predelay: Delay in ms before reverberation begins.
    ///   - crossoverFrequency: Crossover frequency separating low and middle frequencies (Hz).
    ///   - lowReleaseTime: Time (in seconds) to decay 60db in low-frequency band.
    ///   - midReleaseTime: Time (in seconds) to decay 60db in mid-frequency band.
    ///   - dampingFrequency: Frequency (Hz) at which the high-frequency T60 is half the middle-band's T60.
    ///   - equalizerFrequency1: Center frequency of second-order Regalia Mitra peaking equalizer section 1.
    ///   - equalizerLevel1: Peak level in dB of second-order Regalia-Mitra peaking equalizer section 1
    ///   - equalizerFrequency2: Center frequency of second-order Regalia Mitra peaking equalizer section 2.
    ///   - equalizerLevel2: Peak level in dB of second-order Regalia-Mitra peaking equalizer section 2
    ///   - dryWetMix: 0 = all dry, 1 = all wet
    ///
    public init(
        _ input: Node,
        predelay: AUValue = 60.0,
        crossoverFrequency: AUValue = 200.0,
        lowReleaseTime: AUValue = 3.0,
        midReleaseTime: AUValue = 2.0,
        dampingFrequency: AUValue = 6_000.0,
        equalizerFrequency1: AUValue = 315.0,
        equalizerLevel1: AUValue = 0.0,
        equalizerFrequency2: AUValue = 1_500.0,
        equalizerLevel2: AUValue = 0.0,
        dryWetMix: AUValue = 1.0
        ) {
        super.init(avAudioNode: AVAudioNode())

        instantiateAudioUnit { avAudioUnit in
            self.avAudioUnit = avAudioUnit
            self.avAudioNode = avAudioUnit

            guard let audioUnit = avAudioUnit.auAudioUnit as? AudioUnitType else {
                fatalError("Couldn't create audio unit")
            }
            self.internalAU = audioUnit

            self.predelay = predelay
            self.crossoverFrequency = crossoverFrequency
            self.lowReleaseTime = lowReleaseTime
            self.midReleaseTime = midReleaseTime
            self.dampingFrequency = dampingFrequency
            self.equalizerFrequency1 = equalizerFrequency1
            self.equalizerLevel1 = equalizerLevel1
            self.equalizerFrequency2 = equalizerFrequency2
            self.equalizerLevel2 = equalizerLevel2
            self.dryWetMix = dryWetMix
        }
        connections.append(input)
    }
}