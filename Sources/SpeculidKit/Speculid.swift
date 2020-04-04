import Foundation
public struct FileTesting {
  public static func copyFile (from fromURL : URL, to toURL: URL) throws {
    try FileManager.default.copyItem(at: fromURL, to: toURL)
  }
}
