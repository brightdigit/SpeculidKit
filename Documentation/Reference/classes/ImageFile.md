**CLASS**

# `ImageFile`

```swift
public class ImageFile: NSObject, ImageFileProtocol, NSSecureCoding
```

## Properties
### `url`

```swift
public let url: URL
```

### `format`

```swift
public let format: ImageFileFormat
```

## Methods
### `encode(with:)`

```swift
public func encode(with aCoder: NSCoder)
```

### `init(coder:)`

```swift
public required init?(coder aDecoder: NSCoder)
```

### `init(url:format:)`

```swift
public init(url: URL, format: ImageFileFormat)
```
