import Foundation

public class IZSearchBuffer {
  /// Delay between entering characters
  private var delay = 0.8

  /// Min search text length
  private var minSearchCount = 3

  /// Queue for search
  private let queue: DispatchQueue

  /// Dispatch work item
  private var workItem: DispatchWorkItem?

  /// Init with 'queue', 'delay', 'minSearchCount'
  ///
  /// - Parameters:
  ///     - queue: Wotk queue
  ///     - delay: Delay between input characters
  ///     - minSearchCount: Min search text
  public init(queue: DispatchQueue, delay: Double = 0.8, minSearchCount: Int = 3) {
    self.queue = queue
    self.minSearchCount = minSearchCount
    self.delay = delay
  }

  /// Search by text
  public func searchBy(text: String?, _ closure: @escaping (String?) -> Void) {
    self.workItem?.cancel()

    guard let text = text, text.count > 0 else {
      closure(nil)
      return
    }

    if text.count < self.minSearchCount {
      return
    }

    self.workItem = DispatchWorkItem {
      closure(text)
    }

    if let workItem = self.workItem {
      self.queue.asyncAfter(deadline: .now() + self.delay, execute: workItem)
    }
  }
}

