import Foundation

public struct ErrorCollection: Error {
  public let errors: [Error]

  public static func error(for errors: [Error]) -> Error? {
    if errors.count > 1 {
      return ErrorCollection(errors: errors)
    } else {
      return errors.first
    }
  }
}
