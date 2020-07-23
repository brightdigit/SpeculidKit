**PROTOCOL**

# `CommandLineRunnerProtocol`

```swift
public protocol CommandLineRunnerProtocol
```

## Methods
### `activity(withArguments:_:)`

```swift
func activity(
  withArguments arguments: SpeculidCommandArgumentSet,
  _ completed: @escaping (CommandLineActivityProtocol, Error?) -> Void
) -> CommandLineActivityProtocol
```
