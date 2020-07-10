import Foundation
import AssetLib

@objc open class AssetCatalogItemSize: NSObject, NSSecureCoding {
  public static let supportsSecureCoding: Bool = true

  public func encode(with coder: NSCoder) {
    coder.encode(width, forKey: "width")
    coder.encode(height, forKey: "height")
  }

  public required init?(coder: NSCoder) {
    guard let width = coder.decodeObject(forKey: "width") as? NSNumber else {
      return nil
    }

    guard let height = coder.decodeObject(forKey: "height") as? NSNumber else {
      return nil
    }

    self.width = width
    self.height = height
  }

  public let width: NSNumber
  public let height: NSNumber

  public init(size: Size) {
    width = size.width as NSNumber
    height = size.height as NSNumber
  }
}

extension AssetCatalogItemSize {
  var cgSize: Size {
    Size(width: width.floatValue, height: height.floatValue)
  }
}
