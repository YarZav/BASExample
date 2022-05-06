import Foundation

/// Simple wrapper for URL session
public protocol IZURLSessionProtocol {
  /// Data task for reqeust
  ///
  /// - Parameters:
  ///     - request: URL request
  ///     - completion: Compeltion result with error and data
  func dataTask(
    with request: IZURLRequestProtocol,
    completion: ((Result<Data?, IZURLError>) -> Void)?
  )
}
