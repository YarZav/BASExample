protocol IZCoordinatorFactoryProtocol {
  /// Coordinator flow
  ///
  /// - Parameters:
  ///     - router:  Router for moving in stack of views
  func searchCoordinator(
    router: IZRouterProtocol
  ) -> IZCoordinatorProtocol
}
