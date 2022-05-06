import UIKit

/**
 Protocol for View for coordinator flow
 - Parameter navigationController: Return current UINavigationController for View
 - Parameter viewController: Return current UIViewController
 - Returns: Protocol for View in coordinator flow.
 */
protocol IZPresenterProtocol {
  /// Returns current UINavigationController
  var navigationController: UINavigationController? { get }

  /// Returns current UIViewController
  var viewController: UIViewController? { get }
}

extension IZPresenterProtocol {
  public var navigationController: UINavigationController? {
    return self as? UINavigationController
  }

  public var viewController: UIViewController? {
    return self as? UIViewController
  }
}
