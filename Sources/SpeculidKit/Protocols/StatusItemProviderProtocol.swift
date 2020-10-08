import AppKit
import Foundation

@available(*, deprecated)
public protocol StatusItemProviderProtocol {
  func statusItem(for sender: Any?) -> NSStatusItem
}
