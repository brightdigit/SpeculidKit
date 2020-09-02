**EXTENSION**

# `Geometry`
```swift
extension Geometry: Codable
```

## Properties
### `description`

```swift
public var description: String
```

## Methods
### `init(string:)`

```swift
public init?(string: String)
```

### `init(size:preferWidth:)`

```swift
public init(size: Size, preferWidth: Bool? = true) throws
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