import Foundation
import AssetLib

public protocol AssetSpecificationFileProtocol {
  var url: URL { get }
  var document: AssetSpecificationDocumentProtocol { get }
}
