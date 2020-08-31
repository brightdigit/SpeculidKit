**STRUCT**

# `SpeculidDocument`

```swift
public struct SpeculidDocument: SpeculidDocumentProtocol
```

## Properties
### `url`

```swift
public let url: URL
```

### `specificationsFile`

```swift
public let specificationsFile: SpeculidSpecificationsFileProtocol
```

### `assetFile`

```swift
public let assetFile: AssetSpecificationFileProtocol
```

## Methods
### `init(url:decoder:)`

```swift
public init(url: URL, decoder: JSONDecoder) throws
```

### `init(sandboxedFromFile:withURL:decoder:withManager:)`

```swift
public init(
  sandboxedFromFile specificationsFile: SpeculidSpecificationsFileProtocol,
  withURL url: URL,
  decoder: JSONDecoder,
  withManager manager: Sandbox
) throws
```
