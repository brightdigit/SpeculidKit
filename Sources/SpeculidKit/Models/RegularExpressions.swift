import Foundation

public typealias RegularExpressionParameters = (String, NSRegularExpression.Options)

public struct RegularExpressions {
  public let dictionary: [RegularExpressionKey: NSRegularExpression]
//
//  public init(dictionary: [RegularExpressionKey: RegularExpressionParameters]) {
//    self.dictionary = RegularExpressionSetBuilder().buildRegularExpressions(fromDictionary: dictionary)
//  }
}
