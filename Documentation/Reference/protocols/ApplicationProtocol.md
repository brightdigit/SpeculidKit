**PROTOCOL**

# `ApplicationProtocol`

```swift
public protocol ApplicationProtocol
```

## Properties
### `builder`

```swift
var builder: SpeculidBuilderProtocol!
```

### `service`

```swift
var service: ServiceProtocol!
```

### `regularExpressions`

```swift
var regularExpressions: RegularExpressionSetProtocol!
```

### `tracker`

```swift
var tracker: AnalyticsTrackerProtocol!
```

## Methods
### `documents(url:)`

```swift
func documents(url: URL) throws -> [SpeculidDocumentProtocol]
```

### `quit(_:)`

```swift
func quit(_ sender: Any?)
```

### `withInstaller(_:)`

```swift
func withInstaller(_ completed: (Result<InstallerProtocol, Error>) -> Void)
```
