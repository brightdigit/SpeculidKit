**CLASS**

# `AssetCatalogItem`

```swift
@objc open class AssetCatalogItem: NSObject, NSSecureCoding
```

## Properties
### `idiom`

```swift
public let idiom: String
```

### `scale`

```swift
public let scale: NSNumber?
```

### `size`

```swift
public let size: AssetCatalogItemSize?
```

### `filename`

```swift
public let filename: String
```

### `subtype`

```swift
public let subtype: String?
```

### `role`

```swift
public let role: String?
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
