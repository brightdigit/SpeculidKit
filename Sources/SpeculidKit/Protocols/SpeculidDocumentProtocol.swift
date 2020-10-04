import AssetLib
import Foundation

public protocol SpeculidDocumentProtocol {
  var url: URL { get }
  var specificationsFile: SpeculidSpecificationsFileProtocol { get }
  // var asset: AssetSpecificationDocumentProtocol { get }
  var assetFile: AssetSpecificationFileProtocol { get }
}

public extension SpeculidDocumentProtocol {
  var sourceImageURL: URL {
    url.deletingLastPathComponent().appendingPathComponent(specificationsFile.sourceImageRelativePath)
  }

  func destinationName(forImage image: AssetSpecificationProtocol) -> String {
    if let filename = image.filename {
      return filename
    } else if let scale = image.scale {
      if let size = image.size {
        let pathExtension = "\(size.width.cleanValue)x\(size.height.cleanValue)@\(scale.cleanValue)x~\(image.idiom.rawValue).png"
        return
          sourceImageURL
            .deletingPathExtension()
            .appendingPathExtension(pathExtension).lastPathComponent
      } else {
        return sourceImageURL.deletingPathExtension().appendingPathExtension("\(scale.cleanValue)x~\(image.idiom.rawValue).png").lastPathComponent
      }
    } else {
      return sourceImageURL.deletingPathExtension().appendingPathExtension("pdf").lastPathComponent
    }
  }

  func destinationURL(forFileName fileName: String) -> URL {
    url
      .deletingLastPathComponent()
      .appendingPathComponent(
        specificationsFile.assetDirectoryRelativePath,
        isDirectory: true
      ).appendingPathComponent(fileName)
  }
}
