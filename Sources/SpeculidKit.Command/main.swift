import ArgumentParser
import Foundation

struct Speculid: ParsableCommand {}

extension Speculid {
  struct Process: ParsableCommand {}
}

Speculid.main()
