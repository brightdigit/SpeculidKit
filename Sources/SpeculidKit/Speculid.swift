import AssetLib
import Foundation
import GampKit
import SwiftDraw
public struct FileTesting {
  public static func copyFile(from fromURL: URL, to toURL: URL) throws {
    try FileManager.default.copyItem(at: fromURL, to: toURL)
  }
}
