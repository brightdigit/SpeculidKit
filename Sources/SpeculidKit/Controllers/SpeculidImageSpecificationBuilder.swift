import AssetLib
import Foundation

public struct SpeculidImageSpecificationBuilder: SpeculidImageSpecificationBuilderProtocol {
  public init() {}
  public func imageSpecification(
    forURL destinationURL: URL,
    withSpecifications specifications: SpeculidSpecificationsFileProtocol,
    andAsset asset: AssetSpecificationProtocol
  ) throws -> ImageSpecificationObject {
    let destinationFile = try ImageFile(url: destinationURL)

    let geometry: Geometry?

    if let size = asset.size {
      geometry = try Geometry(size: size, preferWidth: true).scalingBy(asset.scale ?? 1.0)
    } else if let specificationsGeomtetry = specifications.geometry {
      geometry = specificationsGeomtetry.scalingBy(asset.scale ?? 1.0)
    } else if let scale = asset.scale {
      geometry = Geometry(value: scale, dimension: .scale)
    } else {
      geometry = nil
    }

    let geometryDimension = geometry.map(GeometryDimension.init(geometry:))

    return ImageSpecificationObject(
      file: destinationFile,
      geometryDimension: geometryDimension,
      removeAlphaChannel: specifications.removeAlpha,
      backgroundColor: specifications.background
    )
  }
}
