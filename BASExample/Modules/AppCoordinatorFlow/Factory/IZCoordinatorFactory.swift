final class IZCoordinatorFactory: IZCoordinatorFactoryProtocol {
  // MARK: - IZCoordinatorFactoryProtocol

  func searchCoordinator(
    router: IZRouterProtocol
  ) -> IZCoordinatorProtocol {
    IZSearchCoordinator(router: router)
  }
}
