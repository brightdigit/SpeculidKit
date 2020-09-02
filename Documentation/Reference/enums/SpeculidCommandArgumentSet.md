**ENUM**

# `SpeculidCommandArgumentSet`

```swift
public enum SpeculidCommandArgumentSet: Equatable
```

## Cases
### `help`

```swift
case help
```

### `unknown(_:)`

```swift
case unknown([String])
```

### `version`

```swift
case version
```

### `process(_:_:)`

```swift
case process(URL, Bool)
```

### `install(_:)`

```swift
case install(InstallType)
```

### `debugLocation`

```swift
case debugLocation
```

## Methods
### `==(_:_:)`

```swift
public static func == (lhs: SpeculidCommandArgumentSet, rhs: SpeculidCommandArgumentSet) -> Bool
```

#### Parameters

| Name | Description |
| ---- | ----------- |
| lhs | A value to compare. |
| rhs | Another value to compare. |