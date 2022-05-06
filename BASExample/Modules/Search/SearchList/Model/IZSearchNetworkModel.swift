import Foundation

struct IZSearchNetworkModel: Codable {
  let items: [Item]?

  struct Item: Codable {
    let title: String?
    let htmlTitle: String?
    let link: URL?
    let snippet: String?
  }
}
