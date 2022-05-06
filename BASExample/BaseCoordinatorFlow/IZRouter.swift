import UIKit

/// Router completion block
typealias IZRouterCompletions = [UIViewController: IZCompletion]

final class IZRouter: NSObject {
  // MARK: - Private property

  private var rootController: UINavigationController?
  private var completions: IZRouterCompletions

  // MARK: - Init
  /// Init with 'rootController'
  ///
  /// - Parameters:
  ///       rootController: root UInavigationController
  init(
    rootController: UINavigationController? = UINavigationController()
  ) {
    self.rootController = rootController
    completions = [:]
  }
}

// MARK: - Private

private extension IZRouter {
  private func performCompletionBlock(for controller: UIViewController) {
    guard let completion = completions[controller] else { return }

    completion()
    completions.removeValue(forKey: controller)
  }
}

// MARK: - IZRouterProtocol

extension IZRouter: IZRouterProtocol {
  // MARK: - View
  var navigationController: UINavigationController? {
    return rootController
  }

  var viewController: UIViewController? {
    return rootController?.viewControllers.last
  }

  // MARK: - Push

  func push(
    _ moduleTo: IZPresenterProtocol?
  ) {
    push(moduleTo, animated: true)
  }

  public func push(
    _ moduleTo: IZPresenterProtocol?,
    animated: Bool
  ) {
    push(moduleTo, animated: animated, completion: nil)
  }

  public func push(
    _ moduleTo: IZPresenterProtocol?,
    animated: Bool,
    completion: IZCompletion?
  ) {
    guard let controller = moduleTo?.viewController else { return }
    if let completion = completion {
      completions[controller] = completion
    }
    rootController?.pushViewController(controller, animated: animated)
  }

  // MARK: - Pop

  func pop() {
    pop(animated: true)
  }

  func pop(animated: Bool) {
    rootController?.popViewController(animated: animated)
  }

  // MARK: - New stack

  public func setRoot(_ module: IZPresenterProtocol?) {
    setRoot(module, hideBar: false)
  }

  public func setRoot(_ module: IZPresenterProtocol?, hideBar: Bool) {
    guard let controller = module?.viewController else { return }
    rootController?.setViewControllers([controller], animated: false)
    rootController?.isNavigationBarHidden = hideBar
  }
}
