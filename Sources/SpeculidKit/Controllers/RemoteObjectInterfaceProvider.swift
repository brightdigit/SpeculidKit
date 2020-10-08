import Foundation

@available(*, deprecated)
public struct NoServiceReturnedError: Error {}

@available(*, deprecated)
public struct RemoteObjectInterfaceProvider: RemoteObjectInterfaceProviderProtocol {
  public func remoteObjectProxyWithHandler(_ handler: (Result<ServiceProtocol, Error>) -> Void) {
    let interface = NSXPCInterface(with: ServiceProtocol.self)
    let connection = NSXPCConnection(serviceName: "com.brightdigit.Speculid-Mac-XPC")

    connection.remoteObjectInterface = interface
    connection.resume()

    var error: Error?

    let proxy = connection.remoteObjectProxyWithErrorHandler { handlerError in
      error = handlerError
    }

    let result: Result<ServiceProtocol, Error>

    if let error = error {
      result = .failure(error)
    } else if let service = proxy as? ServiceProtocol {
      result = .success(service)
    } else {
      result = .failure(NoServiceReturnedError())
    }

    handler(result)
  }
}

@available(*, deprecated)
public struct InstallerObjectInterfaceProvider: InstallerObjectInterfaceProviderProtocol {
  public func remoteObjectProxyWithHandler(_ handler: (Result<InstallerProtocol, Error>) -> Void) {
    let interface = NSXPCInterface(with: InstallerProtocol.self)
    let connection =
      NSXPCConnection(machServiceName: "com.brightdigit.Speculid-Mac-Installer", options: .privileged)

    connection.remoteObjectInterface = interface
    connection.resume()

    var error: Error?

    let proxy = connection.remoteObjectProxyWithErrorHandler { handlerError in
      error = handlerError
    }

    let result: Result<InstallerProtocol, Error>

    if let error = error {
      result = .failure(error)
    } else if let service = proxy as? InstallerProtocol {
      result = .success(service)
    } else {
      result = .failure(NoServiceReturnedError())
    }

    handler(result)
  }
}
