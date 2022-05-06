import UIKit

final class IZSearchCoordinator: IZBaseCoordinator {
  // MARK: - Private property

  private let factory: IZSearchViewFactoryProtocol
  private let router: IZRouterProtocol

  // MARK: - Init
  /// Init with 'factory', 'router'
  /// - Parameters:
  ///     router: View routing
  ///     factory: View factory
  /// - Returns: Coordinator flow
  init(
    router: IZRouterProtocol,
    factory: IZSearchViewFactoryProtocol = IZSearchViewFactory()
  ) {
    self.router = router
    self.factory = factory
  }
}

// MARK: - Coordinatable

extension IZSearchCoordinator: IZCoordinatorProtocol {
  func start() {
    searchList()
  }
}

// MARK: - Private

private extension IZSearchCoordinator {
  func searchList() {
    let list = factory.searchList { [weak self] in
      self?.searchDetail($0)
    }
    router.setRoot(list)
  }

  func searchDetail(_ item: IZSearchModel) {
    let detail = factory.searchDetail(item)
    router.push(detail)
  }
}
