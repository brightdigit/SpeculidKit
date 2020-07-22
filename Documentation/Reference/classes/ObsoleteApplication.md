**CLASS**

# `ObsoleteApplication`

```swift
open class ObsoleteApplication: NSApplication, ApplicationProtocol
```

## Properties
### `commandLineActivity`

```swift
open private(set) var commandLineActivity: CommandLineActivityProtocol?
```

### `statusItem`

```swift
open private(set) var statusItem: NSStatusItem?
```

### `service`

```swift
open private(set) var service: ServiceProtocol!
```

### `installer`

```swift
open private(set) var installer: InstallerProtocol!
```

### `regularExpressions`

```swift
open private(set) var regularExpressions: RegularExpressionSetProtocol!
```

### `tracker`

```swift
open private(set) var tracker: AnalyticsTrackerProtocol!
```

### `configuration`

```swift
open private(set) var configuration: SpeculidConfigurationProtocol!
```

### `builder`

```swift
open private(set) var builder: SpeculidBuilderProtocol!
```

### `statusItemProvider`

```swift
public let statusItemProvider: StatusItemProviderProtocol
```

### `remoteObjectInterfaceProvider`

```swift
public let remoteObjectInterfaceProvider: RemoteObjectInterfaceProviderProtocol
```

### `installerObjectInterfaceProvider`

```swift
public let installerObjectInterfaceProvider: InstallerObjectInterfaceProviderProtocol
```

### `regularExpressionBuilder`

```swift
public let regularExpressionBuilder: RegularExpressionSetBuilderProtocol
```

### `configurationBuilder`

```swift
public let configurationBuilder: SpeculidConfigurationBuilderProtocol
```

### `jsonDecoder`

```swift
public let jsonDecoder: JSONDecoder
```

### `imageSpecificationBuilder`

```swift
public let imageSpecificationBuilder: SpeculidImageSpecificationBuilderProtocol
```

### `commandLineRunner`

```swift
open var commandLineRunner: CommandLineRunnerProtocol
```

## Methods
### `withInstaller(_:)`

```swift
public func withInstaller(_ completed: (Result<InstallerProtocol, Error>) -> Void)
```

### `documents(url:)`

```swift
public func documents(url: URL) throws -> [SpeculidDocumentProtocol]
```

### `unknownCommandMessage(fromArguments:)`

```swift
public static func unknownCommandMessage(fromArguments arguments: [String]) -> String
```

### `init()`

```swift
override public init()
```

### `init(coder:)`

```swift
public required init?(coder: NSCoder)
```

### `finishLaunching()`

```swift
override open func finishLaunching()
```

### `commandLineActivity(_:hasCompletedWithError:)`

```swift
public func commandLineActivity(_: CommandLineActivityProtocol, hasCompletedWithError error: Error?)
```

### `quit(_:)`

```swift
public func quit(_ sender: Any?)
```
