import AssetLib
import Foundation
import GampKit

public struct SpeculidBuilder: SpeculidBuilderProtocol {
  public let tracker: AnalyticsTrackerProtocol?
  public let imageSpecificationBuilder: SpeculidImageSpecificationBuilderProtocol

  public init(
    imageSpecificationBuilder: SpeculidImageSpecificationBuilderProtocol,
    tracker: AnalyticsTrackerProtocol? = nil
  ) {
    self.imageSpecificationBuilder = imageSpecificationBuilder
    self.tracker = tracker
  }

  public func build(document: SpeculidDocumentProtocol, callback: @escaping ((Error?) -> Void)) {
    let imageSpecifications: [ImageSpecificationObject]

    let destinationFileNames = document.assetFile.document.images
      .map { asset in
        (asset, document.destinationName(forImage: asset))
      }
    do {
      imageSpecifications = try destinationFileNames.map { (asset, fileName) -> ImageSpecificationObject in
        try self.imageSpecificationBuilder.imageSpecification(
          forURL: document.destinationURL(forFileName: fileName),
          withSpecifications: document.specificationsFile,
          andAsset: asset
        )
      }
    } catch {
      return callback(error)
    }
    let service = ServiceObject()
    service.exportImageAtURL(document.sourceImageURL, toSpecifications: imageSpecifications) { error in
      if let error = error {
        callback(error)
        return
      }
    }
  }
}
