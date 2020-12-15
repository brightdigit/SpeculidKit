import Foundation

@available(*, deprecated)
@objc
public protocol ServiceProtocol {
  func exportImageAtURL(_ url: URL, toSpecifications specifications: [ImageSpecificationObject], _ callback: @escaping ((NSError?) -> Void))
}
