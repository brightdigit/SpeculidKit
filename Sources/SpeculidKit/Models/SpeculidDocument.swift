import AssetLib
import Foundation

public protocol Sandbox {
  func bookmarkURL(fromURL url: URL) throws -> URL
}

public struct SpeculidDocument: SpeculidDocumentProtocol {
  public let url: URL
  public let specificationsFile: SpeculidSpecificationsFileProtocol
  public let assetFile: AssetSpecificationFileProtocol

  public init(url: URL, decoder: JSONDecoder) throws {
    let specificationsFileData = try Data(contentsOf: url)
    let specificationsFile = try decoder.decode(SpeculidSpecificationsFile.self, from: specificationsFileData)

    let contentsJSONURL = url
      .deletingLastPathComponent()
      .appendingPathComponent(specificationsFile.assetDirectoryRelativePath, isDirectory: true)
      .appendingPathComponent("Contents.json")

    let assetData = try Data(contentsOf: contentsJSONURL)
    let asset = try decoder.decode(AssetSpecificationDocument.self, from: assetData)

    self.specificationsFile = specificationsFile
    assetFile = AssetSpecificationFile(url: contentsJSONURL, document: asset)
    self.url = url
  }

  public init(
    sandboxedFromFile specificationsFile: SpeculidSpecificationsFileProtocol,
    withURL url: URL,
    decoder: JSONDecoder,
    withManager manager: Sandbox
  ) throws {
    let contentsAbsDirURL = url.deletingLastPathComponent().appendingPathComponent(specificationsFile.assetDirectoryRelativePath)

    let contentsDirURL = try manager.bookmarkURL(fromURL: contentsAbsDirURL)
    let dirAccessingScoped = contentsDirURL.startAccessingSecurityScopedResource()
    let contentsJSONURL = contentsDirURL.appendingPathComponent("Contents.json")
    let jsonAccessingScoped = contentsJSONURL.startAccessingSecurityScopedResource()
    let assetData = try Data(contentsOf: contentsJSONURL)
    if jsonAccessingScoped {
      contentsJSONURL.stopAccessingSecurityScopedResource()
    }
    if dirAccessingScoped {
      contentsDirURL.stopAccessingSecurityScopedResource()
    }
    let asset = try decoder.decode(AssetSpecificationDocument.self, from: assetData)

    self.specificationsFile = specificationsFile
    assetFile = AssetSpecificationFile(url: contentsJSONURL, document: asset)
    self.url = url
  }
}
