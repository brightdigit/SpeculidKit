import Foundation
import GampKit

@available(*, deprecated)
public protocol ApplicationProtocol { //: VersionProvider {
  func documents(url: URL) throws -> [SpeculidDocumentProtocol]
  var builder: SpeculidBuilderProtocol! { get }
  var service: ServiceProtocol! { get }
  // var installer: InstallerProtocol! { get }
  var regularExpressions: RegularExpressionSetProtocol! { get }
  var tracker: AnalyticsTrackerProtocol! { get }
  func quit(_ sender: Any?)
  func withInstaller(_ completed: (Result<InstallerProtocol, Error>) -> Void)
}
