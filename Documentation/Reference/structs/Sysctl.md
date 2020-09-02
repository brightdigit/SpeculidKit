**STRUCT**

# `Sysctl`

```swift
public struct Sysctl
```

A "static"-only namespace around a series of functions that operate on buffers returned from the `Darwin.sysctl` function

## Methods
### `dataForKeys(_:)`

```swift
public static func dataForKeys(_ keys: [Int32]) throws -> [Int8]
```

Access the raw data for an array of sysctl identifiers.

### `keysForName(_:)`

```swift
public static func keysForName(_ name: String) throws -> [Int32]
```

Convert a sysctl name string like "hw.memsize" to the array of `sysctl` identifiers (e.g. [CTL_HW, HW_MEMSIZE])

### `valueOfType(_:forKeys:)`

```swift
public static func valueOfType<T>(_: T.Type, forKeys keys: [Int32]) throws -> T
```

Invoke `sysctl` with an array of identifers, interpreting the returned buffer as the specified type. This function will throw `Error.invalidSize` if the size of buffer returned from `sysctl` fails to match the size of `T`.

### `valueOfType(_:forKeys:)`

```swift
public static func valueOfType<T>(_ type: T.Type, forKeys keys: Int32...) throws -> T
```

Invoke `sysctl` with an array of identifers, interpreting the returned buffer as the specified type. This function will throw `Error.invalidSize` if the size of buffer returned from `sysctl` fails to match the size of `T`.

### `valueOfType(_:forName:)`

```swift
public static func valueOfType<T>(_ type: T.Type, forName name: String) throws -> T
```

Invoke `sysctl` with the specified name, interpreting the returned buffer as the specified type. This function will throw `Error.invalidSize` if the size of buffer returned from `sysctl` fails to match the size of `T`.

### `stringForKeys(_:)`

```swift
public static func stringForKeys(_ keys: [Int32]) throws -> String
```

Invoke `sysctl` with an array of identifers, interpreting the returned buffer as a `String`. This function will throw `Error.malformedUTF8` if the buffer returned from `sysctl` cannot be interpreted as a UTF8 buffer.

### `stringForKeys(_:)`

```swift
public static func stringForKeys(_ keys: Int32...) throws -> String
```

Invoke `sysctl` with an array of identifers, interpreting the returned buffer as a `String`. This function will throw `Error.malformedUTF8` if the buffer returned from `sysctl` cannot be interpreted as a UTF8 buffer.

### `stringForName(_:)`

```swift
public static func stringForName(_ name: String) throws -> String
```

Invoke `sysctl` with the specified name, interpreting the returned buffer as a `String`. This function will throw `Error.malformedUTF8` if the buffer returned from `sysctl` cannot be interpreted as a UTF8 buffer.
