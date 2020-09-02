**STRUCT**

# `InstallType`

```swift
public struct InstallType: OptionSet
```

## Properties
### `rawValue`

```swift
public let rawValue: UInt8
```

## Methods
### `init(rawValue:)`

```swift
public init(rawValue: UInt8)
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| rawValue | The raw value of the option set to create. Each bit of `rawValue` potentially represents an element of the option set, though raw values may include bits that are not defined as distinct values of the `OptionSet` type. |