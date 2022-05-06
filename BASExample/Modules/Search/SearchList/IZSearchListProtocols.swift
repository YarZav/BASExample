import Foundation

protocol IZSearchListOutputProtocol {
  var onItem: ((IZSearchModel) -> Void)? { get set }
}

protocol IZSearchListViewProtocol: AnyObject {
  var items: [IZSearchModel] { get set }

  func loading(_ isLoading: Bool)
}

protocol IZSearchListViewModelProtocol {
  var searchText: String? { get set }

  func search(by text: String?)
}

protocol IZSearchListMapperProtocol {
  func map(from data: Data?) -> [IZSearchModel]
}
