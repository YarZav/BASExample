import UIKit

final class IZAppConfiguration: IZAppConfigurationProtocol {
  // MARK: - Private property

  private var appNavigationController: UINavigationController {
    let navigationController = UINavigationController()
    navigationController.navigationBar.tintColor = .black
    return navigationController
  }

  // MARK: - IZAppConfigurationProtocol

  lazy var coordinatorFlow: IZCoordinatorFlow = {
    let router = IZRouter(rootController: appNavigationController)
    let coordinatorFlow = IZCoordinatorFlow(router: router)
    coordinatorFlow.start()
    return coordinatorFlow
  }()
}
