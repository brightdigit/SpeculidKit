import AppKit
import Foundation

public enum GeometryType {
  case width
  case height
  case scale
  case unspecified
}

public extension GeometryType {
  var dimensionValue: Dimension {
    switch self {
    case .width: return .width
    case .height: return .height
    case .scale: return .scale
    case .unspecified: return .unspecified
    }
  }
}

public struct Geometry {
  public let value: Float
  public let dimension: GeometryType

  public init(value: Float, dimension: GeometryType) {
    self.dimension = dimension
    self.value = value
  }
}

public struct SpeculidSpecificationsFile: SpeculidSpecificationsFileProtocol, Codable {
  public let assetDirectoryRelativePath: String
  public let sourceImageRelativePath: String
  public let geometry: Geometry?
  public let background: NSColor?
  public let removeAlpha: Bool

  public enum CodingKeys: String, CodingKey {
    case assetDirectoryRelativePath = "set"
    case sourceImageRelativePath = "source"
    case geometry
    case background
    case removeAlpha = "remove-alpha"
  }

  public init() {
    assetDirectoryRelativePath = ""
    sourceImageRelativePath = ""
    removeAlpha = false
    geometry = nil
    background = nil
  }

  public init(source: SpeculidSpecificationsFileProtocol) {
    assetDirectoryRelativePath = source.assetDirectoryRelativePath
    sourceImageRelativePath = source.sourceImageRelativePath
    geometry = source.geometry
    background = source.background
    removeAlpha = source.removeAlpha
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    assetDirectoryRelativePath = try container.decode(String.self, forKey: CodingKeys.assetDirectoryRelativePath)
    sourceImageRelativePath = try container.decode(String.self, forKey: CodingKeys.sourceImageRelativePath)
    removeAlpha = try container.decodeIfPresent(Bool.self, forKey: CodingKeys.removeAlpha) ?? false

    let geometry: Geometry?

    if let geometryString = try container.decodeIfPresent(String.self, forKey: CodingKeys.geometry) {
      geometry = Geometry(string: geometryString)
    } else {
      geometry = nil
    }

    let background: NSColor?
    if let colorString = try container.decodeIfPresent(String.self, forKey: CodingKeys.background) {
      background = try NSColor(rgba_throws: colorString)
    } else {
      background = nil
    }

    self.background = background
    self.geometry = geometry
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    try container.encode(assetDirectoryRelativePath, forKey: CodingKeys.assetDirectoryRelativePath)
    try container.encode(sourceImageRelativePath, forKey: CodingKeys.sourceImageRelativePath)
    try container.encode(geometry, forKey: CodingKeys.geometry)
    try container.encode(removeAlpha, forKey: CodingKeys.removeAlpha)
    try container.encode(background?.hexString(), forKey: CodingKeys.background)
  }
}
