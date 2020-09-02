**STRUCT**

# `SpeculidSpecificationsFile`

```swift
public struct SpeculidSpecificationsFile: SpeculidSpecificationsFileProtocol, Codable
```

## Properties
### `assetDirectoryRelativePath`

```swift
public let assetDirectoryRelativePath: String
```

### `sourceImageRelativePath`

```swift
public let sourceImageRelativePath: String
```

### `geometry`

```swift
public let geometry: Geometry?
```

### `background`

```swift
public let background: NSColor?
```

### `removeAlpha`

```swift
public let removeAlpha: Bool
```

## Methods
### `init()`

```swift
public init()
```

### `init(source:)`

```swift
public init(source: SpeculidSpecificationsFileProtocol)
```

### `init(from:)`

```swift
public init(from decoder: Decoder) throws
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| decoder | The decoder to read data from. |

### `encode(to:)`

```swift
public func encode(to encoder: Encoder) throws
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| encoder | The encoder to write data to. |