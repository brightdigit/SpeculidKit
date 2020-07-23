**CLASS**

# `CommandLineRunner`

```swift
public class CommandLineRunner: CommandLineRunnerProtocol
```

## Properties
### `errorStream`

```swift
public var errorStream: TextOutputStream
```

### `outputStream`

```swift
public var outputStream: TextOutputStream
```

## Methods
### `init(outputStream:errorStream:)`

```swift
public init(outputStream: TextOutputStream, errorStream: TextOutputStream)
```

### `activity(withArguments:_:)`

```swift
public func activity(
  withArguments arguments: SpeculidCommandArgumentSet,
  _ completed: @escaping (CommandLineActivityProtocol, Error?) -> Void
) -> CommandLineActivityProtocol
```
