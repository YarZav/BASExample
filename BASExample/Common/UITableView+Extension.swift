import UIKit

extension UITableView {
  /// Make UITableView
  ///
  /// - Parameters:
  ///   - cells: cell which can be displayed
  ///   - dataSource: UITableViewDataSource, default is nil
  ///   - delegate: UITableViewDelegate, default is nil
  ///   - allowsSelection: allows selection cells of not, default is false
  convenience init(
    cells: [AnyClass],
    dataSource: UITableViewDataSource? = nil,
    delegate: UITableViewDelegate? = nil,
    allowsSelection: Bool = false
  ) {
    self.init(frame: .zero, style: .grouped)
    self.allowsSelection = allowsSelection
    self.dataSource = dataSource
    self.delegate = delegate
    self.separatorColor = #colorLiteral(red: 0.9137254902, green: 0.9176470588, blue: 0.9176470588, alpha: 1)
    self.backgroundColor = .white
    self.separatorInset = UIEdgeInsets(top: 0, left: 16.0, bottom: 0, right: 16.0)
    self.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
    self.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
    cells.forEach { cellClass in
      guard let casted = cellClass.self as? UITableViewCell.Type else { return }
      let reuseIdentifier = String(describing: casted.self)
      self.register(cellClass, forCellReuseIdentifier: reuseIdentifier)
    }
  }

  /// Get cell for UItableView for IndexPath
  ///
  /// - Parameters:
  ///   - indexPath: index path for cell
  func dequeueCell<T: UITableViewCell>(indexPath: IndexPath) -> T {
    let reuseIdentifier = String(describing: T.self)
    guard let cell = self.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? T else {
      fatalError("UITableViewCell fatal error: Cell is not register in table view")
    }
    return cell
  }

  /// Set bottom insets for content in table
  ///
  /// - Parameters:
  ///   - inset:bottom inset
  func setBottomInset(_ inset: CGFloat) {
    let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: inset, right: 0)
    contentInset = edgeInset
    scrollIndicatorInsets = edgeInset
  }

  /// Add table footer view
  ///
  /// - Parameters:
  ///     - view: Table footer view
  ///     - frame: Table footer frame
  func addFooterView(_ view: UIView, frame: CGRect) {
    let width = frame.width
    let height = frame.height

    view.translatesAutoresizingMaskIntoConstraints = false
    view.heightAnchor.constraint(equalToConstant: height).isActive = true
    view.widthAnchor.constraint(equalToConstant: width).isActive = true

    tableFooterView = view
    tableFooterView?.frame = frame
  }
}
