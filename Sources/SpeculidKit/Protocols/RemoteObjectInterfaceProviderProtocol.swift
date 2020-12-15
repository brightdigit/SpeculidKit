import Foundation

@available(*, deprecated)
public protocol RemoteObjectInterfaceProviderProtocol {
  func remoteObjectProxyWithHandler(_ handler: (Result<ServiceProtocol, Error>) -> Void)
}

@available(*, deprecated)
public protocol InstallerObjectInterfaceProviderProtocol {
  func remoteObjectProxyWithHandler(_ handler: (Result<InstallerProtocol, Error>) -> Void)
}
