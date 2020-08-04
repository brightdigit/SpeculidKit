import AppKit
import Foundation

public struct NoBookmarkAvailableError: Error {
  public let url: URL

  public init(url: URL) {
    self.url = url
  }
}
