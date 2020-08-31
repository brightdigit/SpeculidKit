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

### `imageSpecificationBuilder`

```swift
public let imageSpecificationBuilder: SpeculidImageSpecificationBuilderProtocol
```

## Methods
### `init(imageSpecificationBuilder:tracker:)`

```swift
public init(
  imageSpecificationBuilder: SpeculidImageSpecificationBuilderProtocol,
  tracker: AnalyticsTrackerProtocol? = nil
)
```

### `build(document:callback:)`

```swift
public func build(document: SpeculidDocumentProtocol, callback: @escaping ((Error?) -> Void))
```
