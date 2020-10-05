import Foundation
import AssetLib

import SwiftDraw

import CairoSVG.GeometryDimension


struct NotImplementedError : Error, LocalizedError {
  let description : String
  
  var errorDescription: String? {
    return self.description
  }
}
@available(*, deprecated)
public final class ServiceObject: NSObject {
  let exportQueue = DispatchQueue(label: "export", qos: .default, attributes: .concurrent)

  func scale(forSize size: CGSize, toDimension dimension: GeometryDimension) -> Double {
    switch dimension.dimension {
    case .height:
      return Double(dimension.value/size.height)
    case .width:
      return Double(dimension.value/size.width)
    case .scale:
      return Double(dimension.value)
    case .unspecified:
      return 1.0
    }
  }
  
//    + (double) mapSize: (CGSize) size toDimension: (GeometryDimension) dimensions {
//      switch (dimensions.dimension) {
//        case kWidth:
//          return dimensions.value/size.width;
//        case kHeight:
//          return dimensions.value/size.height;
//        case kScale:
//        return dimensions.value;
//        case kUnspecified:
//          return 1.0;
//      }
//    }

  public func exportImageAtURL(_ url: URL, toSpecifications specifications: [ImageSpecificationObject], _ callback: @escaping ((NSError?) -> Void)) {
    
    let errorQueue = DispatchQueue(label: "error", qos: .default, attributes: .concurrent)
    
    //let imageFile = ImageFile(url: url, format: .svg)
  
    
    let image : SwiftDraw.Image
    do {
    image = try SwiftDraw.Image(fileURL: url)
    } catch {
      callback(error as! NSError)
      return
    }
//    let builtImageHandle: ImageHandle?
//    do {
//      builtImageHandle = try ImageHandleBuilder.shared.imageHandle(fromFile: imageFile)
//    } catch let error as NSError {
//      callback(error)
//      return
//    }
//
//    guard let imageHandle = builtImageHandle else {
//      return
//    }

    let group = DispatchGroup()
    var errors = [NSError]()
    
    for specs in specifications {
      group.enter()
      exportQueue.async(flags: .barrier) {
        do {
          let data : Data?
          let scale = self.scale(forSize: image.size, toDimension: specs.geometry)
          
          switch specs.file.format {
          case .pdf:
            data = image.pdfData()
            break
          case .png:
            data = image.pngData(size: nil, scale: CGFloat(scale), backgroundColor: specs.backgroundColor as? NSColor , removeAlpha: specs.removeAlphaChannel)
            break
          case .svg:
            data = try Data(contentsOf: url)
            break
          }
          guard let actualData = data else {
            throw NotImplementedError(description: "Could Not Create PDF")
          }
          try actualData.write(to: specs.file.url)
          //try CairoInterface.exportImage(imageHandle, withSpecification: specs)
        } catch let error as NSError {
          errorQueue.async(flags: .barrier) {
            errors.append(error)
            group.leave()
          }
          return
        }
        group.leave()
      }
    }

    group.notify(queue: .main) {
      callback(NSErrorCollection(errors: errors))
    }
  }
}
