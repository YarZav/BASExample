
/**
 Base view protocol to add and remove children coordinator flow
 */
protocol IZBaseViewProtocol: IZPresenterProtocol {
  /// Add new coordinator flow as a dependency for current coordinator flow for routing
  ///
  /// - Parameters:
  ///     - coordinator: New coordinator flow as dependency.
  func addDependency(_ coordinator: IZCoordinatorProtocol)

  /// Remove coordinator flow as a dependency for current coordinator flow for routing
  ///
  /// - Parameters:
  ///     - coordinator: Coordinator floe to delete after finished.
  func removeDependency(_ coordinator: IZCoordinatorProtocol?)
}
