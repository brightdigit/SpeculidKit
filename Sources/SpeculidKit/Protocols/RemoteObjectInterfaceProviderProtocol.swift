import Foundation

public protocol RemoteObjectInterfaceProviderProtocol {
  func remoteObjectProxyWithHandler(_ handler: (Result<ServiceProtocol, Error>) -> Void)
}

public protocol InstallerObjectInterfaceProviderProtocol {
  func remoteObjectProxyWithHandler(_ handler: (Result<InstallerProtocol, Error>) -> Void)
}
