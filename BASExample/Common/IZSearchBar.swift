import UIKit

protocol IZSearchBarDelegate: AnyObject {
  /// Search by new text
  func search(by text: String)
}

final class IZSearchBar: UISearchBar {
  // MARK: - Constants

  private enum Constants {
    static let searchPlacehodler = NSLocalizedString("SearchKey", comment: "")
  }

  // MARK: - Internal property

  weak var editDelegate: IZSearchBarDelegate?

  // MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)
    sizeToFit()
    tintColor = .black
    delegate = self
    placeholder = Constants.searchPlacehodler
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UISearchBarDelegate

extension IZSearchBar: UISearchBarDelegate {
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchBar.showsCancelButton = true
  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    editDelegate?.search(by: searchText)
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.resignFirstResponder()
    searchBar.showsCancelButton = false
  }
}
