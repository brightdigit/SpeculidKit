**STRUCT**

# `SpeculidBuilder`

```swift
public struct SpeculidBuilder: SpeculidBuilderProtocol
```

## Properties
### `tracker`

```swift
public let tracker: AnalyticsTrackerProtocol?
```

### `configuration`

```swift
public let configuration: SpeculidConfigurationProtocol
```

### `imageSpecificationBuilder`

```swift
public let imageSpecificationBuilder: SpeculidImageSpecificationBuilderProtocol
```

## Methods
### `init(configuration:imageSpecificationBuilder:tracker:)`

```swift
public init(
  configuration: SpeculidConfigurationProtocol,
  imageSpecificationBuilder: SpeculidImageSpecificationBuilderProtocol,
  tracker: AnalyticsTrackerProtocol? = nil
)
```

### `build(document:callback:)`

```swift
public func build(document: SpeculidDocumentProtocol, callback: @escaping ((Error?) -> Void))
```
