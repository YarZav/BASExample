/// Default completion code block for coordinator flow
typealias IZCompletion = () -> Void

open class IZBaseCoordinator {
  // MARK: - Internal property

  lazy var childCoordinators: [IZCoordinatorProtocol] = []
}

// MARK: - Publics

extension IZBaseCoordinator {
  func addDependency(_ coordinator: IZCoordinatorProtocol) {
    if !childCoordinators.contains(where: { $0 === coordinator }) {
      childCoordinators.append(coordinator)
    }
  }

  func removeDependency(_ coordinator: IZCoordinatorProtocol?) {
    guard childCoordinators.isEmpty == false, let coordinator = coordinator else { return }
    childCoordinators.removeAll { $0 === coordinator }
  }
}
