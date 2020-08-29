import Foundation

public struct InvalidDocumentURL: Error {
  public let url: URL
}

extension Operation: CommandLineActivityProtocol {}

@available(*, deprecated)
public struct UnknownArgumentsError: Error {
  public let arguments: [String]
}

@available(*, deprecated)
public class CommandLineRunner: CommandLineRunnerProtocol {
  public var errorStream: TextOutputStream
  public var outputStream: TextOutputStream
  // private let _versionProvider: VersionProvider?

//  public var versionProvider: VersionProvider {
//    _versionProvider ?? Application.current
//  }
  public init(outputStream: TextOutputStream, errorStream: TextOutputStream) {
    self.outputStream = outputStream
    self.errorStream = errorStream
    // _versionProvider = versionProvider
  }

  public func activity(
    withArguments arguments: SpeculidCommandArgumentSet,
    _ completed: @escaping (CommandLineActivityProtocol, Error?) -> Void
  ) -> CommandLineActivityProtocol {
    var error: Error?
    let operation = AsyncBlockOperation { completed in
      switch arguments {
      case .help:
        self.outputStream.write(ObsoleteApplication.helpText)
        return completed()
      case let .unknown(arguments):
        self.errorStream.write(ObsoleteApplication.unknownCommandMessage(fromArguments: arguments))
        self.outputStream.write(ObsoleteApplication.helpText)
        error = UnknownArgumentsError(arguments: arguments)
        return completed()
      case .version:
//        if let version = self.versionProvider.version {
//          self.outputStream.write(version.developmentDescription)
//        } else {
        self.outputStream.write("""
          "\(ObsoleteApplication.bundle.infoDictionary?["CFBundleShortVersionString"]) \
          (\(ObsoleteApplication.bundle.infoDictionary?["CFBundleVersion"]))"
        """)
        // }
        #if DEBUG
          self.outputStream.write(" DEBUG")
        #endif
        return completed()
      case let .process(url, update):
        let documents: [SpeculidDocumentProtocol]
        do {
          documents = try ObsoleteApplication.current.documents(url: url)
        } catch let caughtError {
          error = caughtError
          return completed()
        }
//        guard let document = tryDocument else {
//          error = InvalidDocumentURL(url: url)
//          return completed()
//        }
        error = ObsoleteApplication.current.builder.build(documents: documents)
        return completed()
      case .debugLocation:
        self.outputStream.write(Bundle.main.bundleURL.absoluteString)
        return completed()
      case let .install(type):
        if type.contains(.command) {
          error = CommandLineInstaller.startSync()
          return completed()
        } else {
          return completed()
        }
      }
    }
    operation.completionBlock = {
      completed(operation, error)
    }
    return operation
  }
}
