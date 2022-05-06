import Foundation

struct IZSearchModel: Decodable {
  let title: String
  let htmlTitle: String
  let link: URL
  let snippet: String
  let htmlSnippet: String
}
