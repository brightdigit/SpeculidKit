import Foundation
import AssetLib

public protocol SpeculidDocumentProtocol {
  var url: URL { get }
  var specificationsFile: SpeculidSpecificationsFileProtocol { get }
  // var asset: AssetSpecificationDocumentProtocol { get }
  var assetFile: AssetSpecificationFileProtocol { get }
}
