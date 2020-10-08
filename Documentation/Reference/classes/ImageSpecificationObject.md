**CLASS**

# `ImageSpecificationObject`

```swift
@objc open class ImageSpecificationObject: NSObject, ImageSpecificationProtocol, NSSecureCoding
```

## Properties
### `file`

```swift
public let file: ImageFileProtocol
```

### `geometry`

```swift
public let geometry: GeometryDimension
```

### `removeAlphaChannel`

```swift
public let removeAlphaChannel: Bool
```

### `backgroundColor`

```swift
public let backgroundColor: CairoColorProtocol?
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

### `init(file:geometryDimension:removeAlphaChannel:backgroundColor:)`

```swift
public init(file: ImageFileProtocol,
            geometryDimension: GeometryDimension? = nil,
            removeAlphaChannel: Bool = false,
            backgroundColor: CairoColorProtocol? = nil)
```
