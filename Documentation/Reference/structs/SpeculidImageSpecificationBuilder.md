**STRUCT**

# `SpeculidImageSpecificationBuilder`

```swift
public struct SpeculidImageSpecificationBuilder: SpeculidImageSpecificationBuilderProtocol
```

## Methods
### `init()`

```swift
public init()
```

### `imageSpecification(forURL:withSpecifications:andAsset:)`

```swift
public func imageSpecification(
  forURL destinationURL: URL,
  withSpecifications specifications: SpeculidSpecificationsFileProtocol,
  andAsset asset: AssetSpecificationProtocol
) throws -> ImageSpecification
```
