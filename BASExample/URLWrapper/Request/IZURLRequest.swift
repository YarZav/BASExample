import Foundation

public final class IZURLRequest: IZURLRequestProtocol {
  // MARK: - Public property

  public var url: URL
  public var httpMethod: IZURLRequestType

  // MARK: - Init
  /// Init with 'url', 'httpMethod'
  ///
  /// - Parameters:
  ///       url: URL path for request data
  ///       httpMethod: HTTP method (POST, GET, PUT etc)
  public init(url: URL, httpMethod: IZURLRequestType) {
    self.url = url
    self.httpMethod = httpMethod
  }
}
