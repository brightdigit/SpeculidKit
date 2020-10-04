import Foundation
import AssetLib
//import CairoSVG
import SwiftDraw

@available(*, deprecated)
public final class ServiceObject: NSObject {
  let exportQueue = DispatchQueue(label: "export", qos: .default, attributes: .concurrent)

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
          switch specs.file.format {
          case .pdf:
            
          case .png:
            image
          }
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
