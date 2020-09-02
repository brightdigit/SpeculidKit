import AppKit
import Foundation
import GampKit

// @available(*, deprecated)
// extension OperatingSystemVersion {
//  var fullDescription: String {
//    [majorVersion, minorVersion, patchVersion].map {
//      String(describing: $0)
//    }.joined(separator: ".")
//  }
// }
//
// @available(*, deprecated)
// var exceptionHandler: ((NSException) -> Void)?
// @available(*, deprecated)
// func exceptionHandlerMethod(exception: NSException) {
//  if let handler = exceptionHandler {
//    handler(exception)
//  }
// }

public typealias RegularExpressionArgumentSet = (String, options: NSRegularExpression.Options)

// @available(*, deprecated)
// open class ObsoleteApplication: NSApplication, ApplicationProtocol {
//  public func withInstaller(_ completed: (Result<InstallerProtocol, Error>) -> Void) {
//    installerObjectInterfaceProvider.remoteObjectProxyWithHandler(completed)
//  }
//
//  public func documents(url: URL) throws -> [SpeculidDocumentProtocol] {
//    var isDirectory: ObjCBool = false
//    let exists = FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory)
//    if exists, isDirectory.boolValue == true {
//      guard let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: nil) else {
//        throw InvalidDocumentURL(url: url)
//      }
//      return enumerator.compactMap { (item) -> SpeculidDocument? in
//        guard let url = item as? URL else {
//          return nil
//        }
//        return try? SpeculidDocument(url: url, decoder: jsonDecoder, configuration: configuration)
//      }
//    } else {
//      return [try SpeculidDocument(url: url, decoder: jsonDecoder, configuration: configuration)]
//    }
//  }
//
//  public static var current: ApplicationProtocol! {
//    NSApplication.shared as? ApplicationProtocol
//  }
//
//  public static let unknownCommandMessagePrefix = "Unknown Command Arguments"
//
//  public static func unknownCommandMessage(fromArguments arguments: [String]) -> String {
//    "\(unknownCommandMessagePrefix): \(arguments.joined(separator: " "))"
//  }
//
//  public static let helpText: String! = {
//    guard let url = ObsoleteApplication.bundle.url(forResource: "help", withExtension: "txt") else {
//      return nil
//    }
//
//    guard let format = try? String(contentsOf: url) else {
//      return nil
//    }
//
//    let text: String
//
//    if let sourceApplicationName = ProcessInfo.processInfo.environment["sourceApplicationName"] ?? Bundle.main.executableURL?.lastPathComponent {
//      text = format.replacingOccurrences(of: "$ speculid", with: "$ " + sourceApplicationName)
//    } else {
//      text = format
//    }
//
//    return text
//  }()
//
//  open private(set) var commandLineActivity: CommandLineActivityProtocol?
//  open private(set) var statusItem: NSStatusItem?
//  open private(set) var service: ServiceProtocol!
//  open private(set) var installer: InstallerProtocol!
//  open private(set) var regularExpressions: RegularExpressionSetProtocol!
//  open private(set) var tracker: AnalyticsTrackerProtocol!
//  open private(set) var configuration: SpeculidConfigurationProtocol!
//  open private(set) var builder: SpeculidBuilderProtocol!
//
//  public let statusItemProvider: StatusItemProviderProtocol
//  public let remoteObjectInterfaceProvider: RemoteObjectInterfaceProviderProtocol
//  public let installerObjectInterfaceProvider: InstallerObjectInterfaceProviderProtocol
//  public let regularExpressionBuilder: RegularExpressionSetBuilderProtocol
//  public let configurationBuilder: SpeculidConfigurationBuilderProtocol
//  public let jsonDecoder: JSONDecoder
//  public let imageSpecificationBuilder: SpeculidImageSpecificationBuilderProtocol
//  open var commandLineRunner: CommandLineRunnerProtocol
//
//  override public init() {
//    statusItemProvider = StatusItemProvider()
//    remoteObjectInterfaceProvider = RemoteObjectInterfaceProvider()
//    installerObjectInterfaceProvider = InstallerObjectInterfaceProvider()
//    regularExpressionBuilder = RegularExpressionSetBuilder()
//    configurationBuilder = SpeculidConfigurationBuilder()
//    jsonDecoder = JSONDecoder()
//    imageSpecificationBuilder = SpeculidImageSpecificationBuilder()
//    commandLineRunner = CommandLineRunner(
//      outputStream: FileHandle.standardOutput,
//      errorStream: FileHandle.standardError
//    )
//
//    super.init()
//  }
//
//  public required init?(coder: NSCoder) {
//    statusItemProvider = StatusItemProvider()
//    remoteObjectInterfaceProvider = RemoteObjectInterfaceProvider()
//    installerObjectInterfaceProvider = InstallerObjectInterfaceProvider()
//    regularExpressionBuilder = RegularExpressionSetBuilder()
//    configurationBuilder = SpeculidConfigurationBuilder(coder: coder)
//    jsonDecoder = JSONDecoder()
//    imageSpecificationBuilder = SpeculidImageSpecificationBuilder()
//    commandLineRunner = CommandLineRunner(
//      outputStream: FileHandle.standardOutput,
//      errorStream: FileHandle.standardError
//    )
//
//    super.init(coder: coder)
//  }
//
//  override open func finishLaunching() {
//    super.finishLaunching()
//
//    configuration = configurationBuilder.configuration(fromCommandLine: CommandLineArgumentProvider())
//
//    let operatingSystem = ProcessInfo.processInfo.operatingSystemVersion.fullDescription
//    let applicationVersion: String
////    if let version = self.version {
////      applicationVersion = (try? version.fullDescription(withLocale: nil)) ?? ""
////    } else {
//    applicationVersion = ""
//    // }
//
//    let analyticsConfiguration = AnalyticsConfiguration(
//      trackingIdentifier: "UA-33667276-6",
//      applicationName: "speculid",
//      applicationVersion: applicationVersion, clientIdentifier: ClientIdentifier.shared.clientIdentifier,
//      customParameters: [.operatingSystemVersion: operatingSystem, .model: Sysctl.model]
//    )
//
//    remoteObjectInterfaceProvider.remoteObjectProxyWithHandler { result in
//      switch result {
//      case let .failure(error):
//        preconditionFailure("Could not connect to XPS Service: \(error)")
//      case let .success(service):
//        self.service = service
//      }
//    }
//
//    builder = SpeculidBuilder(configuration: configuration, imageSpecificationBuilder: imageSpecificationBuilder, tracker: self.tracker)
//
//    let tracker = AnalyticsTracker(configuration: analyticsConfiguration, sessionManager: AnalyticsSessionManager(session: AnalyticsURLSession()))
//    NSSetUncaughtExceptionHandler(exceptionHandlerMethod)
//
//    exceptionHandler = {
//      tracker.track($0) { _ in }
//    }
//
//    tracker.track(AnalyticsEvent(category: "main", action: "launch", label: "application")) { _ in }
//
//    self.tracker = tracker
//
//    do {
//      regularExpressions = try regularExpressionBuilder.buildRegularExpressions(fromDictionary: [
//        .geometry: ("x?(\\d+)", options: [.caseInsensitive]),
//        .integer: ("\\d+", options: []),
//        .scale: ("(\\d+)x", options: []),
//        .size: ("(\\d+\\.?\\d*)x(\\d+\\.?\\d*)", options: []),
//        .number: ("\\d", options: [])
//      ])
//    } catch {
//      assertionFailure("Failed to parse regular expression: \(error)")
//    }
//
//    if case let .command(arguments) = configuration.mode {
//      let commandLineActivity = self.commandLineRunner.activity(withArguments: arguments, self.commandLineActivity(_:hasCompletedWithError:))
//      self.commandLineActivity = commandLineActivity
//      commandLineActivity.start()
//      return
//    }
//
//    statusItem = statusItemProvider.statusItem(for: self)
//  }
//
//  public func commandLineActivity(_: CommandLineActivityProtocol, hasCompletedWithError error: Error?) {
//    if let error = error {
//      FileHandle.standardError.write(error.localizedDescription)
//      exit(1)
//    } else {
//      exit(0)
//    }
//  }
//
//  public func quit(_ sender: Any?) {
//    terminate(sender)
//  }
//
//  public static var author: String {
//    bundle.bundleIdentifier!.components(separatedBy: "-").first!
//  }
//
//  public static let bundle = Bundle(for: ObsoleteApplication.self)
// }
