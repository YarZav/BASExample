import Foundation

public final class IZURLSession {
  // MARK: - Private property

  private let urlSession = URLSession.shared
  private enum Constants {
    static let unknownStatusCodeText = "Unknown status code"
    static let unknownDataText = "Unknown data"
    static let successStatusCodeRange =  200..<300
  }

  // MARK: - Init

  public init() { }
}

// MARK: - IZURLSessionProtocol

extension IZURLSession: IZURLSessionProtocol {
  public func dataTask(
    with request: IZURLRequestProtocol,
    completion: ((Result<Data?, IZURLError>) -> Void)?
  ) {
    let task = urlSession
      .dataTask(with: urlRequest(for: request)) { (data, response, error) in
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
          completion?(.failure(.unspecified(statusMessage: Constants.unknownStatusCodeText)))
          return
        }

        switch statusCode {
        case Constants.successStatusCodeRange:
          guard let data = data else {
            completion?(.failure(.unspecified(statusMessage: Constants.unknownDataText)))
            return
          }
          completion?(.success(data))
        default:
          let error = statusCode.urlError()
          completion?(.failure(error))
        }
      }
    task.resume()
  }
}

// MARK: - Private

extension IZURLSession {
  func urlRequest(for request: IZURLRequestProtocol) -> URLRequest {
    var urlRequest = URLRequest(url: request.url)
    urlRequest.httpMethod = request.httpMethod.rawValue
    return urlRequest
  }
}
