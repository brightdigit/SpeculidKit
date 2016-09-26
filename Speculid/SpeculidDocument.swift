//
//  SpeculidDocument.swift
//  speculid
//
//  Created by Leo Dion on 9/24/16.
//
//

import Foundation

extension CGFloat {
  var cleanValue: String {
    return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(describing: self)
  }
}

extension String {
  func nsRange(from range: Range<String.Index>) -> NSRange {
    let utf16view = self.utf16
    let from = range.lowerBound.samePosition(in: utf16view)
    let to = range.upperBound.samePosition(in: utf16view)
    return NSMakeRange(utf16view.distance(from: utf16view.startIndex, to: from),
                       utf16view.distance(from: from, to: to))
  }
}

extension String {
  func range(from nsRange: NSRange) -> Range<String.Index>? {
    guard
      let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
      let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
      let from = String.Index(from16, within: self),
      let to = String.Index(to16, within: self)
      else { return nil }
    return from ..< to
  }
  
  func replaceRegex(regex: NSRegularExpression, replace: ((String, NSTextCheckingResult) -> String)) -> String {
    let range = NSRange(0..<self.characters.count)
    let results = regex.matches(in: self, options: [], range: range).reversed()
    var newString = self
    for result in results {
      let subrange = self.range(from: result.range)
      let substring = self.substring(with: subrange!)
      newString.replaceSubrange(subrange!, with: replace(substring, result))
    }
    return newString
  }
}

extension String {
  func firstMatchGroups (regex: NSRegularExpression) -> [String]? {
    let range = NSRange(0..<self.characters.count)
    
    guard let result = regex.firstMatch(in: self, options: [], range: range)  else {
      return nil
    }
    //print(result.range)
    return (0..<result.numberOfRanges).map({ (index) -> String in
      self.substring(with: self.range(from: result.rangeAt(index))!)
    })
    //print(scale.substring(with: scale.range(from: result.rangeAt(1))!))
    
  }
}


let scaleRegex = try! NSRegularExpression(pattern: "(\\d+)x", options: [])
let sizeRegex = try! NSRegularExpression(pattern: "(\\d+\\.?\\d*)x(\\d+\\.?\\d*)", options: [])

let numberRegex = try! NSRegularExpression(pattern: "\\d", options: [])

public struct SpeculidDocument {
  public let specifications : SpeculidSpecifications
  public let images : [ImageSpecification]
  //public let configuration: SpeculidConfiguration
  
  public var maxScale : CGFloat? {
    return self.images.reduce(nil, { (maxScale, image) -> CGFloat? in
      
      
      guard let scale = image.scale else {
        return maxScale
      }
      
      guard let maxScale = maxScale else {
        return scale
      }
      
      
      return max(scale, maxScale)
    })
  }
  
  public init?(url: URL, configuration: SpeculidConfiguration? = nil) {
    
    guard let specifications = SpeculidSpecifications(url: url) else {
      return nil
    }
    
    guard let contentsJSONData = try? Data(contentsOf: specifications.contentsDirectoryURL.appendingPathComponent("Contents.json")) else {
      return nil
    }
    
    guard let contentsJSON = try? JSONSerialization.jsonObject(with: contentsJSONData, options: []) as? [String : Any] else {
      return nil
    }
    
    guard let images = contentsJSON?["images"] as? [[String : String]]  else {
      return nil
    }
    
    self.images = images.flatMap { (dictionary) -> ImageSpecification? in
      let scale: CGFloat?
      let size: CGSize?
      
      if let scaleString = dictionary["scale"]?.firstMatchGroups(regex: scaleRegex)?[1], let value = Double(scaleString) {
        scale = CGFloat(value)
      } else {
        scale = nil
      }
      
      guard let idiomString = dictionary["idiom"], let idiom = ImageIdiom(rawValue: idiomString) else {
        return nil
      }
      
      if let dimensionStrings = dictionary["size"]?.firstMatchGroups(regex: sizeRegex), let width = Double(dimensionStrings[1]), let height = Double(dimensionStrings[2]) {
        size = CGSize(width: width, height: height)
      } else {
        size = nil
      }
      
      let filename = dictionary["filename"]
      
      return ImageSpecification(idiom: idiom, scale: scale, size: size, filename: filename)
    }

    
    self.specifications = specifications
    //self.configuration = configuration ?? SpeculidConfiguration.default
    
    
  }
  
  
  /*
  public func build (closure: ((Error?) -> Void)?) {
    //inkscape --export-id=Release --export-id-only --without-gui --export-png Media.xcassets/AppIcon-Production-Release.appiconset/appicon_${x}.png -w ${x} -b white graphics/logo.svg
    //for x in 29 40 58 76 87 80 120 152 167 180 ; do inkscape --without-gui --export-png tictalktoc-app/tictalktoc/Images.xcassets/AppIcon-lite.appiconset/lite${x}.png -w ${x} graphics/icons/logo.svg >/dev/null && echo "exporting appicon_${x}.png" & done
    
    let tasks = self.images.flatMap{ (image) -> ImageConversionTaskProtocol? in
      return ImageConversionBuilder.sharedInstance.conversion(forImage: image, withSpecifications: self.specifications, andConfiguration: self.configuration)
      
    }
    
    for image in self.images {
      
      let process: Process?
      if let scale = image.scale {
        
        if self.specifications.sourceImageURL.pathExtension.compare("svg", options: .caseInsensitive, range: nil, locale: nil) == .orderedSame {
          var arguments : [String] = ["--without-gui","--export-png"]
          if let size = image.size {
            
            let dimension = size.height > size.width ? "-h" : "-w"
            let length = Int(round(max(size.width, size.height) * scale))
            let destinationURL = self.specifications.contentsDirectoryURL.appendingPathComponent(self.specifications.sourceImageURL.deletingPathExtension().lastPathComponent).appendingPathExtension("\(size.width.cleanValue)x\(size.height.cleanValue).\(scale.cleanValue)x.png")
            arguments.append(contentsOf: [destinationURL.path,dimension,"\(length)", self.specifications.sourceImageURL.absoluteURL.path])
            //process.waitUntilExit()
          } else {
            // convert to
            let destinationURL = self.specifications.contentsDirectoryURL.appendingPathComponent(self.specifications.sourceImageURL.deletingPathExtension().lastPathComponent).appendingPathExtension("\(scale.cleanValue)x.png")
            arguments.append(contentsOf: [destinationURL.path,self.specifications.sourceImageURL.absoluteURL.path])
            
            // if svg
            //process = nil
            // else
            //convert graphics/pexels-photo.jpg -resize ${x} Media.xcassets/Backgrounds/Wrist-Watch.imageset/Write-Watch_${x}.jpg 2> /dev/null > /dev/null
          }
          
          
          //convert graphics/pexels-photo.jpg -resize ${x} Media.xcassets/Backgrounds/Wrist-Watch.imageset/Write-Watch_${x}.jpg 2> /dev/null > /dev/null
          process = Process.launchedProcess(launchPath: "/usr/local/bin/inkscape", arguments:
            arguments)
        } else {
          let destinationURL = self.specifications.contentsDirectoryURL.appendingPathComponent(self.specifications.sourceImageURL.deletingPathExtension().lastPathComponent).appendingPathExtension("\(scale.cleanValue)x.png")
          let resizeValue : String
          if let resize1x = image.size {
            resizeValue = "\(resize1x.width * scale)x\(resize1x.height * scale)"
          } else if let maxScale = maxScale {
            resizeValue = "\(round(scale/maxScale*100.0))%"
          } else {
            fatalError()
          }
          process = Process.launchedProcess(launchPath: "/usr/local/bin/convert", arguments: [self.specifications.sourceImageURL.path,"-resize",resizeValue,destinationURL.path])
        }
      } else {
        // convert to pdf
        // inkscape --without-gui --export-area-drawing --export-pdf $ASSET_ROOT/$packname/$imagename-$packname.imageset/icon.pdf $file 2> /dev/null > /dev/null  &
        let destinationURL = self.specifications.contentsDirectoryURL.appendingPathComponent(self.specifications.sourceImageURL.deletingPathExtension().lastPathComponent).appendingPathExtension("pdf")
        process = Process.launchedProcess(launchPath: "/usr/local/bin/inkscape", arguments: ["--without-gui","--export-area-drawing","--export-pdf",destinationURL.path,self.specifications.sourceImageURL.absoluteURL.path])
      }
      
      process?.waitUntilExit()
    }
    
  }
 */
  
}
