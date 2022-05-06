import XCTest
@testable import BASExample

final class IZSearchListMapperTests: XCTest {
  // MARK: - Private property

  private var mapper: IZSearchListMapperProtocol!

  // MARK: - Init

  override func setUp() {
    super.setUp()
    mapper = IZSearchListMapper()
  }

  override func tearDown() {
    mapper = nil
    super.tearDown()
  }

  // MARK: - Test

  func testMapDataValid() {
    // given
    let model = IZSearchNetworkModel(
      items: [
        .init(
          title: "title",
          htmlTitle: "htmlTitle",
          link: URL(string: "www.google.com")!,
          snippet: "snippet"
        )
      ]
    )
    let data = try? JSONEncoder().encode(model)

    // when
    let items = mapper.map(from: data)

    // given
    XCTAssertEqual(items.count, 1)
  }

  func testMapDataNil() {
    // when
    let items = mapper.map(from: nil)

    // given
    XCTAssertTrue(items.isEmpty)
  }
}
