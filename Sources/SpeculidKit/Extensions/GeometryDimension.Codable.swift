import Foundation
import AssetLib

extension Geometry: Codable {
  internal static func parse(string: String) -> (dimension: GeometryType, value: Float)? {
    let value: Double
    let dimension: GeometryType
    if let width = Double(string) {
      value = width
      dimension = .width
    } else if let height = Double(String(string[string.index(after: string.startIndex)...])), string[string.startIndex] == "x" {
      dimension = .height
      value = height
    } else {
      return nil
    }
    return (dimension, Float(value))
  }

  public var description: String {
    switch dimension {
    case .width: return "\(value)"
    case .height: return "x\(value)"
    case .scale: return "\(value)x"
    case .unspecified: return ""
    }
  }

  public init?(string: String) {
    guard let geometryDimension = Geometry.parse(string: string) else {
      return nil
    }
    self.init(value: geometryDimension.value, dimension: geometryDimension.dimension)
  }

  public init(size: Size, preferWidth: Bool? = true) throws {
    if preferWidth == nil, size.height != size.width {
      throw BadGeometryCGSizeValueError(size: size)
    }

    if preferWidth == false {
      self.init(value: size.height, dimension: .height)
    } else {
      self.init(value: size.width, dimension: .width)
    }
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    let stringValue = try container.decode(String.self)
    guard let geometryDimension = Geometry.parse(string: stringValue) else {
      throw BadGeometryStringValueError(stringValue: stringValue)
    }
    self.init(value: geometryDimension.value, dimension: geometryDimension.dimension)
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(value.description)
  }
}

extension GeometryDimension {
  init(geometry: Geometry) {
    
    self.init(value: CGFloat(geometry.value), dimension: geometry.dimension.dimensionValue)
  }
}
