import Foundation

final class IZSearchListViewModel {
  private enum Constants {
    static let urlValue = "https://www.googleapis.com/customsearch/v1"
    static let keyValue = "AIzaSyAkE2lC52dK4xeUaOmsGgvZJ0_fUAv4awo"
    static let cxValue = "6477843e893a47d24"
    static let key = "key"
    static let cx = "cx"
    static let q = "q"
  }
  private let searchBuffer = IZSearchBuffer(queue: .main)

  private let urlSession: IZURLSessionProtocol
  private let mapper: IZSearchListMapperProtocol
  weak var view: IZSearchListViewProtocol?

  var searchText: String? {
    didSet {
      searchBuffer.searchBy(text: searchText) { [weak self] in
        self?.view?.loading(true)
        self?.search(by: $0)
      }
    }
  }

  init(
    urlSession: IZURLSessionProtocol = IZURLSession(),
    mapper: IZSearchListMapperProtocol = IZSearchListMapper()
  ) {
    self.urlSession = urlSession
    self.mapper = mapper
  }
}

// MARK: - IZSearchListViewModelProtocol

extension IZSearchListViewModel: IZSearchListViewModelProtocol {
  func search(by text: String?) {
    guard let url = url(by: text) else { return }
    let request = IZURLRequest(url: url, httpMethod: .get)
    urlSession.dataTask(with: request) { [weak self] result in
      DispatchQueue.main.async {
        self?.searchCompletion(result)
      }
    }
  }
}

// MARK: - Private

private extension IZSearchListViewModel {
  func url(by text: String?) -> URL? {
    let key = [Constants.key, Constants.keyValue].joined(separator: "=")
    let cx = [Constants.cx, Constants.cxValue].joined(separator: "=")
    let q = text.map { [Constants.q, $0].joined(separator: "=") }
    let parameters = [key, cx, q].compactMap { $0 }.joined(separator: "&")
    let path = Constants.urlValue + "?" + parameters
    return URL(string: path)
  }

  func searchCompletion(_ result: Result<Data?, IZURLError>) {
    view?.loading(false)
    switch result {
    case .success(let data):
      view?.items = mapper.map(from: data)
    case .failure:
      view?.items = []
    }
  }
}
