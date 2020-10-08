import Foundation

@available(*, deprecated)
public protocol ClientIdentifiable {
  var clientIdentifier: UUID { get }
}
