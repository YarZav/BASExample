/// Protocol to Pop, Push, Dismiss etc. views
protocol IZRouterProtocol: IZPresenterProtocol {
  // MARK: - Push

  /// Push view module with default animation
  func push(
    _ moduleTo: IZPresenterProtocol?
  )

  /// Push view module with animation
  func push(
    _ moduleTo: IZPresenterProtocol?,
    animated: Bool
  )

  /// Push view module with animation and completion block
  func push(
    _ moduleTo: IZPresenterProtocol?,
    animated: Bool,
    completion: IZCompletion?
  )

  // MARK: - Pop

  /// Pop view module with default animation
  func pop()

  /// Pop view module with animation
  func pop(animated: Bool)

  // MARK: - New stack

  /// Set root view module
  func setRoot(_ module: IZPresenterProtocol?)

  /// Set root module and hide/show navigation bar
  func setRoot(_ module: IZPresenterProtocol?, hideBar: Bool)
}
