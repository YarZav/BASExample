final class IZSearchViewFactory: IZSearchViewFactoryProtocol {
  // MARK: - IZSearchViewFactoryProtocol

  func searchList(_ onItem: ((IZSearchModel) -> Void)?) -> IZPresenterProtocol {
    let viewModel = IZSearchListViewModel()
    let view = IZSearchListViewController(viewModel: viewModel)
    view.onItem = onItem
    viewModel.view = view
    return view
  }

  func searchDetail(_ item: IZSearchModel) -> IZPresenterProtocol {
    IZSearchDetailViewController(item: item)
  }
}
