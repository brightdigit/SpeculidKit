import Foundation
public protocol SpeculidBuilderProtocol {
  func build(document: SpeculidDocumentProtocol, callback: @escaping ((Error?) -> Void))
}

public extension SpeculidBuilderProtocol {
  @available(*, deprecated: 2.0.0)
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

  func build(documents: [SpeculidDocumentProtocol]) -> Error? {
    var errors = [Error]()
    let group = DispatchGroup()
    let errorQueue = DispatchQueue(label: "errors", qos: .default, attributes: .concurrent)
    let buildQueue = DispatchQueue(label: "builder", qos: .userInitiated, attributes: .concurrent)
    for document in documents {
      group.enter()
      buildQueue.async {
        self.build(document: document) { errorOpt in
          if let error = errorOpt {
            errorQueue.async(group: nil, qos: .default, flags: .barrier) {
              errors.append(error)
              group.leave()
            }
          } else {
            group.leave()
          }
        }
      }
    }

    group.wait()
    return ArrayError.error(for: errors)
  }
}
