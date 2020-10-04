import Foundation

public typealias RegularExpressionParameters = (String, NSRegularExpression.Options)

public struct RegularExpressions {
  public let dictionary: [RegularExpressionKey: NSRegularExpression]
}
