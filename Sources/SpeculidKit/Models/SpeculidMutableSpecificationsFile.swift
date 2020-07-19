//
//  File.swift
//  
//
//  Created by Leo Dion on 7/17/20.
//

import Foundation
import AppKit


public struct SpeculidMutableSpecificationsFile : SpeculidSpecificationsFileProtocol {
  public var assetDirectoryRelativePath: String
  public var sourceImageRelativePath: String
  public var geometry: Geometry?
  public var background: NSColor?
  public var removeAlpha: Bool
  
  
  public init (source: SpeculidSpecificationsFileProtocol) {
    self.assetDirectoryRelativePath = source.assetDirectoryRelativePath
    self.sourceImageRelativePath = source.sourceImageRelativePath
    self.geometry = source.geometry
    self.background = source.background
    self.removeAlpha = source.removeAlpha
  }
}
