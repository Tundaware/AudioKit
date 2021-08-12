///
///  Created by George Cox on 8/12/21.
///

import Foundation
import AudioToolbox

enum kDynamicsProcessorParam_MasterGain_Wrapper {
  #if os(iOS) || os(tvOS)
  static let value = kDynamicsProcessorParam_MasterGain
  #else
  static let value = kDynamicsProcessorParam_OverallGain
  #endif
}
