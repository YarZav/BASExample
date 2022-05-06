import Foundation

final class IZSearchListMapper: IZSearchListMapperProtocol {
  // MARK: - IZSearchListMapperProtocol

  func map(from data: Data?) -> [IZSearchModel] {
    guard let data = data else { return [] }
    let networkModel = try! JSONDecoder().decode(IZSearchNetworkModel?.self, from: data)
    return networkModel?.items?.compactMap { map(from: $0) } ?? []
  }
}

// MARK: - Private

private extension IZSearchListMapper {
  func map(from networkModel: IZSearchNetworkModel.Item?) -> IZSearchModel? {
    guard
      let title = networkModel?.title, !title.isEmpty,
      let htmlTitle = networkModel?.htmlTitle, !htmlTitle.isEmpty,
      let link = networkModel?.link,
      let snippet = networkModel?.snippet, !snippet.isEmpty,
      let htmlSnippet = networkModel?.htmlTitle, !htmlSnippet.isEmpty
    else { return nil }
    return .init(
      title: title,
      htmlTitle: htmlTitle,
      link: link,
      snippet: snippet,
      htmlSnippet: htmlSnippet
    )
  }
}
