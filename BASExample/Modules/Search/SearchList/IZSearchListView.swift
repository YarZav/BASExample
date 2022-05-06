import UIKit

final class IZSearchListViewController: UIViewController, IZPresenterProtocol, IZSearchListOutputProtocol {
  // MARK: - Private

  private enum Constants {
    static let emptyText = NSLocalizedString("EmptyKey", comment: "Text is empty")
    static let cellHeight: CGFloat = 120
  }

  private lazy var searchBar: UISearchBar = {
    let searchBar = IZSearchBar()
    searchBar.editDelegate = self
    return searchBar
  }()

  private lazy var refreshControl: UIRefreshControl = {
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(pullToRefresh), for: .valueChanged)
    return refreshControl
  }()

  private lazy var activityIndicatorView: UIActivityIndicatorView = {
    let activityIndicatorView = UIActivityIndicatorView(style: .medium)
    activityIndicatorView.hidesWhenStopped = true
    return activityIndicatorView
  }()

  private lazy var tableView = UITableView(
    cells: [IZSearchListCell.self],
    dataSource: self,
    delegate: self,
    allowsSelection: true
  )

  private var viewModel: IZSearchListViewModelProtocol

  // MARK: - Internal

  var onItem: ((IZSearchModel) -> Void)?

  var items: [IZSearchModel] = [] {
    didSet {
      tableView.reloadData()
      if items.isEmpty {
        setTableFooterView(with: Constants.emptyText)
      } else {
        tableView.tableFooterView = UIView()
      }
    }
  }

  // MARK: - Init

  init(viewModel: IZSearchListViewModelProtocol) {
    self.viewModel = viewModel
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Life circle

  override func viewDidLoad() {
    super.viewDidLoad()
    createUI()
    viewModel.searchText = ""
  }
}

// MARK: - Private

private extension IZSearchListViewController {
  func createUI() {
    view.backgroundColor = .white
    navigationItem.titleView = searchBar

    tableView.refreshControl = refreshControl

    view.addSubview(tableView)
    view.addSubview(activityIndicatorView)

    tableView.translatesAutoresizingMaskIntoConstraints = false
    activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),

      activityIndicatorView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      activityIndicatorView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      activityIndicatorView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      activityIndicatorView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
    ])
  }

  func setTableFooterView(with text: String) {
    let emptyLabel = UILabel.plain(text: text, textAlgnment: .center)
    emptyLabel.frame = .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75)
    tableView.tableFooterView = emptyLabel

  }
}

// MARK: - IZSearchListViewProtocol

extension IZSearchListViewController: IZSearchListViewProtocol {
  func loading(_ isLoading: Bool) {
    if isLoading {
      tableView.tableFooterView = UIView()
      activityIndicatorView.startAnimating()
      refreshControl.endRefreshing()
    } else {
      activityIndicatorView.stopAnimating()
      refreshControl.endRefreshing()
    }
  }

  @objc
  func pullToRefresh() {
    activityIndicatorView.stopAnimating()
    refreshControl.beginRefreshing()
    viewModel.search(by: viewModel.searchText)
  }
}

// MARK: - IZSearchBarDelegate

extension IZSearchListViewController: IZSearchBarDelegate {
  func search(by text: String) {
    viewModel.searchText = text
  }
}

// MARK: - UITableViewDataSource

extension IZSearchListViewController: UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    items.isEmpty ? 0 : 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: IZSearchListCell = tableView.dequeueCell(indexPath: indexPath)
    cell.item = items[indexPath.row]
    cell.accessoryType = .disclosureIndicator
    return cell
  }
}

// MARK: - UITableViewDelegate

extension IZSearchListViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    Constants.cellHeight
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    onItem?(items[indexPath.row])
  }
}
