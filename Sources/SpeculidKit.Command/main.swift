import ArgumentParser
import Foundation
import SpeculidKit

struct Speculid: ParsableCommand {
  static var configuration = CommandConfiguration(
    subcommands: [Process.self],
    defaultSubcommand: Process.self
  )
}

extension Speculid {
  struct Process: ParsableCommand {
    @Argument
    var file: String = ""

    init() {}

    func run() throws {
      let url = URL(fileURLWithPath: file)
      let document = try SpeculidDocument(url: url, decoder: .init())
      let service = Service()
      let imageSpecificationBuilder = SpeculidImageSpecificationBuilder()
      let imageSpecs = try document.assetFile.document.images.map {
        try imageSpecificationBuilder.imageSpecification(forURL: document.destinationURL(forFileName: $0.filename ?? document.destinationName(forImage: $0)), withSpecifications: document.specificationsFile, andAsset: $0)
      }
      var result: Result<Void, Error>?
      DispatchQueue.global(qos: .userInitiated).async {
        service.exportImageAtURL(document.sourceImageURL, toSpecifications: imageSpecs) {
          result = $0.map(Result<Void, Error>.failure) ?? .success(())
        }
      }
      while result == nil {
        RunLoop.main.run(until: .distantPast)
      }

      try result!.get()
    }
  }
}

Speculid.main()
