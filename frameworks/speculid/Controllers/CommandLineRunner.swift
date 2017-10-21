import Foundation

public struct InvalidDocumentURL: Error {
  public let url: URL
}
extension Operation: CommandLineActivityProtocol {
}

public struct UnknownArgumentsError: Error {
  public let arguments: [String]
}
public class CommandLineRunner: CommandLineRunnerProtocol {

  public var errorStream: TextOutputStream
  public var outputStream: TextOutputStream

  public init(outputStream: TextOutputStream, errorStream: TextOutputStream) {
    self.outputStream = outputStream
    self.errorStream = errorStream
  }

  public func activity(withArguments arguments: SpeculidCommandArgumentSet, _ completed: @escaping (CommandLineActivityProtocol, Error?) -> Void) -> CommandLineActivityProtocol {

    var error: Error?
    let operation = AsyncBlockOperation { completed in
      switch arguments {
      case .help:
        self.outputStream.write(Application.helpText)
        return completed()
      case let .unknown(arguments):
        self.errorStream.write(Application.errorText)
        self.outputStream.write(Application.helpText)
        error = UnknownArgumentsError(arguments: arguments)
        return completed()
      case .version:
        self.outputStream.write("Speculid v\(Application.version.shortDescription) [\(Application.version)]")
        return completed()
      case let .file(url):
        guard let document = Application.current.document(url: url) else {
          error = InvalidDocumentURL(url: url)
          return completed()
        }
        error = Application.current.builder.build(document: document)
        return completed()
      }
    }
    operation.completionBlock = {
      completed(operation, error)
    }
    return operation
  }
}