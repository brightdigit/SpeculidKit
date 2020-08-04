import AppKit
import Foundation

public struct SpeculidMutableSpecificationsFile: SpeculidSpecificationsFileProtocol {
  public var assetDirectoryRelativePath: String
  public var sourceImageRelativePath: String
  public var geometry: Geometry?
  public var background: NSColor?
  public var removeAlpha: Bool

  public init(source: SpeculidSpecificationsFileProtocol) {
    assetDirectoryRelativePath = source.assetDirectoryRelativePath
    sourceImageRelativePath = source.sourceImageRelativePath
    geometry = source.geometry
    background = source.background
    removeAlpha = source.removeAlpha
  }
}
