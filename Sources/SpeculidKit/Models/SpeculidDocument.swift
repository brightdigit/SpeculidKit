import Foundation
import AssetLib

public struct SpeculidDocument: SpeculidDocumentProtocol {
  public let url: URL
  public let specificationsFile: SpeculidSpecificationsFileProtocol
  public let assetFile: AssetSpecificationFileProtocol

  public init(url: URL, decoder: JSONDecoder, configuration _: SpeculidConfigurationProtocol? = nil) throws {
    let specificationsFileData = try Data(contentsOf: url)
    let specificationsFile = try decoder.decode(SpeculidSpecificationsFile.self, from: specificationsFileData)

    let contentsJSONURL = url.deletingLastPathComponent().appendingPathComponent(specificationsFile.assetDirectoryRelativePath, isDirectory: true).appendingPathComponent("Contents.json")

    let assetData = try Data(contentsOf: contentsJSONURL)
    let asset = try decoder.decode(AssetSpecificationDocument.self, from: assetData)

    self.specificationsFile = specificationsFile
    assetFile = AssetSpecificationFile(url: contentsJSONURL, document: asset)
    self.url = url
  }
  
  
  public init(sandboxedFromFile specificationsFile: SpeculidSpecificationsFileProtocol, withURL url: URL, decoder: JSONDecoder, withManager manager: FileManagement) throws {
//    let sourceURL = try manager.bookmarkURL(fromURL: url)
//    let specificationsFileData = try Data(contentsOf: sourceURL)
//    let specificationsFile = try decoder.decode(SpeculidSpecificationsFile.self, from: specificationsFileData)

    let contentsAbsJSONURL = url.deletingLastPathComponent().appendingPathComponent(specificationsFile.assetDirectoryRelativePath).appendingPathComponent("Contents.json")

    let contentsDirURL = try manager.bookmarkURL(fromURL: contentsAbsJSONURL)
    let accessingScoped = contentsDirURL.startAccessingSecurityScopedResource()
    if !accessingScoped {
        print("startAccessingSecurityScopedResource returned false. This directory might not need it, or this URL might not be a security scoped URL, or maybe something's wrong?")
    }
    let contentsJSONURL = contentsDirURL
    let assetData = try Data(contentsOf: contentsJSONURL)
    if accessingScoped {
    contentsJSONURL.stopAccessingSecurityScopedResource()
    }
    let asset = try decoder.decode(AssetSpecificationDocument.self, from: assetData)

    self.specificationsFile = specificationsFile
    assetFile = AssetSpecificationFile(url: contentsJSONURL, document: asset)
    self.url = url
  }
}
