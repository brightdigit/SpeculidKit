import Foundation

extension Float {
  var cleanValue: String {
    truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(describing: self)
  }
}
