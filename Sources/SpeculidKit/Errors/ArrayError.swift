import Foundation

@available(*, deprecated)
public struct ArrayError: Error {
  public let errors: [Error]

  public static func error(for errors: [Error]) -> Error? {
    if errors.count > 1 {
      return ArrayError(errors: errors)
    } else {
      return errors.first
    }
  }
}
