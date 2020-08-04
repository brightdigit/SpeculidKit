**EXTENSION**

# `NSColor`
```swift
extension NSColor
```

## Properties
### `red`

```swift
public var red: Double
```

### `green`

```swift
public var green: Double
```

### `blue`

```swift
public var blue: Double
```

## Methods
### `init(hex3:alpha:)`

```swift
public convenience init(hex3: UInt16, alpha: CGFloat = 1)
```

The shorthand three-digit hexadecimal representation of color.
#RGB defines to the color #RRGGBB.

- parameter hex3: Three-digit hexadecimal value.
- parameter alpha: 0.0 - 1.0. The default is 1.0.

#### Parameters

| Name | Description |
| ---- | ----------- |
| hex3 | Three-digit hexadecimal value. |
| alpha | 0.0 - 1.0. The default is 1.0. |

### `init(hex4:)`

```swift
public convenience init(hex4: UInt16)
```

The shorthand four-digit hexadecimal representation of color with alpha.
#RGBA defines to the color #RRGGBBAA.

- parameter hex4: Four-digit hexadecimal value.

#### Parameters

| Name | Description |
| ---- | ----------- |
| hex4 | Four-digit hexadecimal value. |

### `init(hex6:alpha:)`

```swift
public convenience init(hex6: UInt32, alpha: CGFloat = 1)
```

The six-digit hexadecimal representation of color of the form #RRGGBB.

- parameter hex6: Six-digit hexadecimal value.

#### Parameters

| Name | Description |
| ---- | ----------- |
| hex6 | Six-digit hexadecimal value. |

### `init(hex8:)`

```swift
public convenience init(hex8: UInt32)
```

The six-digit hexadecimal representation of color with alpha of the form #RRGGBBAA.

- parameter hex8: Eight-digit hexadecimal value.

#### Parameters

| Name | Description |
| ---- | ----------- |
| hex8 | Eight-digit hexadecimal value. |

### `init(rgba_throws:)`

```swift
public convenience init(rgba_throws rgba: String) throws
```

The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, throws error.

- parameter rgba: String value.

#### Parameters

| Name | Description |
| ---- | ----------- |
| rgba | String value. |

### `init(_:defaultColor:)`

```swift
public convenience init?(_ rgba: String, defaultColor: NSColor = NSColor.clear)
```

The rgba string representation of color with alpha of the form #RRGGBBAA/#RRGGBB, fails to default color.

- parameter rgba: String value.

#### Parameters

| Name | Description |
| ---- | ----------- |
| rgba | String value. |

### `hexString(_:)`

```swift
public func hexString(_ includeAlpha: Bool = true) -> String
```

Hex string of a UIColor instance.

- parameter includeAlpha: Whether the alpha should be included.
