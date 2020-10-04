import Foundation

@available(*, deprecated)
public struct CommandLineArgumentProvider: CommandLineArgumentProviderProtocol {
  public let commandLine: CommandLine.Type

  public init(commandLine: CommandLine.Type? = nil) {
    self.commandLine = commandLine ?? CommandLine.self
  }

  public var arguments: [String] {
    commandLine.arguments
  }
}
