import Foundation
public protocol SpeculidBuilderProtocol {
  func build(document: SpeculidDocumentProtocol, callback: @escaping ((Error?) -> Void))
}

public extension SpeculidBuilderProtocol {
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
