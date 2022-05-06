protocol IZSearchViewFactoryProtocol {
  /// Displaying view for searching
  func searchList(_ onItem: ((IZSearchModel) -> Void)?) -> IZPresenterProtocol

  /// Displaying view for detail
  func searchDetail(_ item: IZSearchModel) -> IZPresenterProtocol
}
