import Foundation

@available(*, deprecated)
open class AsyncBlockOperation: Operation {
  typealias Block = (() -> Void) -> Void

  private let block: Block
  private var _executing = false
  private var _finished = false

  init(block: @escaping Block) {
    self.block = block
    super.init()
  }

  override open func start() {
    guard (isExecuting || isCancelled) == false else { return }
    _executing = true
    block(finish)
  }

  private func finish() {
    _executing = false
    _finished = true

    if let completionBlock = self.completionBlock {
      DispatchQueue.main.async(execute: completionBlock)
    }
  }

  override open var isAsynchronous: Bool {
    true
  }

  override open var isExecuting: Bool {
    get { _executing }
    set {
      let key = "isExecuting"
      willChangeValue(forKey: key)
      _executing = newValue
      didChangeValue(forKey: key)
    }
  }

  override open var isFinished: Bool {
    get { _finished }
    set {
      let key = "isFinished"
      willChangeValue(forKey: key)
      _finished = newValue
      didChangeValue(forKey: key)
    }
  }
}
