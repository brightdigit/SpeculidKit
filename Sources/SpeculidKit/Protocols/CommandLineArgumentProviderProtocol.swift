import Foundation

@available(*, deprecated)
public protocol CommandLineArgumentProviderProtocol {
  var arguments: [String] { get }
}
