**STRUCT**

# `SpeculidConfigurationBuilder`

```swift
public struct SpeculidConfigurationBuilder: SpeculidConfigurationBuilderProtocol
```

## Properties
### `applicationModeParser`

```swift
public let applicationModeParser: SpeculidApplicationModeParserProtocol
```

## Methods
### `configuration(fromCommandLine:)`

```swift
public func configuration(fromCommandLine commandLine: CommandLineArgumentProviderProtocol) -> SpeculidConfigurationProtocol
```

### `init(applicationModeParser:coder:)`

```swift
public init(applicationModeParser: SpeculidApplicationModeParserProtocol? = nil, coder _: NSCoder? = nil)
```
