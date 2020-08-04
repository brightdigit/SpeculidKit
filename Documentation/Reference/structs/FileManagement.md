**STRUCT**

# `FileManagement`

```swift
public struct FileManagement
```

## Methods
### `init()`

```swift
public init()
```

### `saveBookmark(_:)`

```swift
public func saveBookmark(_ url: URL) throws
```

### `bookmarkURL(fromURL:)`

```swift
public func bookmarkURL(fromURL url: URL) throws -> URL
```

### `withinSandbox(urls:_:otherwise:)`

```swift
public func withinSandbox(urls: [String: URL], _ fileoperation: ([String: URL]) throws -> Void, otherwise: (Any) -> NSSavePanel?) throws
```
