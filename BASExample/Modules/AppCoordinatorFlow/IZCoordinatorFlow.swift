import UIKit

final class IZCoordinatorFlow: IZBaseCoordinator {
  // MARK: - Private property

  private let factory: IZCoordinatorFactoryProtocol
  private let router: IZRouterProtocol

  // MARK: - Init
  /// Init with 'router', 'factory',
  ///
  /// - Parameters:
  ///   - router: Router for moving in stack of views
  ///   - factory: Factory of children coordinator flows
  init(
    router: IZRouterProtocol,
    factory: IZCoordinatorFactoryProtocol = IZCoordinatorFactory()
  ) {
    self.router = router
    self.factory = factory
    super.init()
  }
}

// MARK: - IZCoordinatorProtocol

extension IZCoordinatorFlow: IZCoordinatorProtocol {
  func start() {
    childCoordinators.forEach { removeDependency($0) }
    startMainCoordinator()
  }
}

// MARK: - Internal

extension IZCoordinatorFlow {
  func getNavigationController() -> UINavigationController? {
    return router.navigationController
  }
}

// MARK: - Private

private extension IZCoordinatorFlow {
  func startMainCoordinator() {
    let mainCoordinator = factory.searchCoordinator(router: router)
    addDependency(mainCoordinator)
    mainCoordinator.start()
  }
}
