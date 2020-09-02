import Foundation

public protocol ClientIdentifiable {
  var clientIdentifier: UUID { get }
}
