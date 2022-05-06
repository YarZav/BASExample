import Foundation

public protocol IZURLRequestProtocol {
  /// URL path for request data
  var url: URL { get }

  /// HTTP method (POST, GET, PUT etc)
  var httpMethod: IZURLRequestType { get }
}
