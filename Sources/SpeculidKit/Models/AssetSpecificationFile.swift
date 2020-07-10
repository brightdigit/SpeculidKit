import Foundation
import AssetLib

public struct AssetSpecificationFile: AssetSpecificationFileProtocol {
  public let url: URL
  public let document: AssetSpecificationDocumentProtocol
}
