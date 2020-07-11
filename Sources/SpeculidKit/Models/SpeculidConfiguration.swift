import Foundation

public struct SpeculidConfiguration: SpeculidConfigurationProtocol {
  public init (mode: SpeculidApplicationMode) {
    self.mode = mode
  }
  public var mode: SpeculidApplicationMode
}
