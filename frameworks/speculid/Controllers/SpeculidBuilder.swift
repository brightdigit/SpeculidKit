import Foundation

// TODO: Separate into Files
public typealias ImageConversionPair = (image: AssetSpecificationProtocol, conversion: Result<ImageConversionTaskProtocol>?)
public typealias ImageConversionDictionary = [String: ImageConversionPair]

extension SpeculidSpecificationsProtocol {
  public func destination(forImage image: AssetSpecificationProtocol) -> String {
    if let filename = image.filename {
      return filename
    } else if let scale = image.scale {
      if let size = image.size {
        return sourceImageURL.deletingPathExtension().appendingPathExtension("\(size.width.cleanValue)x\(size.height.cleanValue)@\(scale.cleanValue)x~\(image.idiom.rawValue).png").lastPathComponent
      } else {
        return sourceImageURL.deletingPathExtension().appendingPathExtension("\(scale.cleanValue)x~\(image.idiom.rawValue).png").lastPathComponent
      }
    } else {
      return sourceImageURL.deletingPathExtension().appendingPathExtension("pdf").lastPathComponent
    }
  }
}

public struct SpeculidBuilder: SpeculidBuilderProtocol {

  public let tracker: AnalyticsTrackerProtocol?
  public let configuration: SpeculidConfigurationProtocol

  public func build(document: SpeculidDocumentProtocol, callback: @escaping ((Error?) -> Void)) {
    let start = Date()

    guard let conversionSet = ImageConversionSetBuilder.sharedInstance.buildConversions(forDocument: document, withConfiguration: self.configuration) else {
      return callback(UnknownConversionError(fromDocument: document))
    }

    conversionSet.run {
      error in
      let difference = -start.timeIntervalSinceNow
      self.tracker?.track(time: difference, withCategory: "operations", withVariable: "building", withLabel: nil)
      callback(error)
    }
  }
}

public extension SpeculidBuilderProtocol {
  func build(document: SpeculidDocumentProtocol) -> Error? {
    var result: Error?
    let semaphone = DispatchSemaphore(value: 0)
    build(document: document) { error in
      result = error
      semaphone.signal()
    }
    semaphone.wait()
    return result
  }
}