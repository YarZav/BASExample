import UIKit

final class IZSearchListCell: UITableViewCell {
  // MARK: - Private property

  private enum Constants {
    static let margin: CGFloat = 16
  }

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = .systemFont(ofSize: 17)
    return label
  }()

  private lazy var subtitleLabel: UILabel = {
    let label = UILabel()
    label.textColor = .gray
    label.numberOfLines = 3
    label.font = .systemFont(ofSize: 13)
    return label
  }()

  private lazy var linkLabel: UILabel = {
    let label = UILabel()
    label.textColor = .blue
    label.font = .systemFont(ofSize: 13)
    return label
  }()

  // MARK: - Internal property

  var item: IZSearchModel? {
    didSet {
      titleLabel.text = item?.title
      subtitleLabel.text = item?.snippet
      linkLabel.text = item?.link.absoluteString
    }
  }

  // MARK: - Init

  override init(style: CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    createUI()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - Private

private extension IZSearchListCell {
  func createUI() {
    let container = UIView()

    contentView.addSubview(container)
    container.addSubview(titleLabel)
    container.addSubview(subtitleLabel)
    container.addSubview(linkLabel)

    container.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    linkLabel.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      container.topAnchor.constraint(equalTo: topAnchor, constant: Constants.margin),
      container.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.margin),
      container.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -Constants.margin),
      container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.margin),

      titleLabel.topAnchor.constraint(equalTo: container.topAnchor),
      titleLabel.leftAnchor.constraint(equalTo: container.leftAnchor),
      titleLabel.rightAnchor.constraint(equalTo: container.rightAnchor),

      subtitleLabel.leftAnchor.constraint(equalTo: container.leftAnchor),
      subtitleLabel.rightAnchor.constraint(equalTo: container.rightAnchor),
      subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),

      linkLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor),
      linkLabel.leftAnchor.constraint(equalTo: container.leftAnchor),
      linkLabel.rightAnchor.constraint(equalTo: container.rightAnchor),
      linkLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor),
    ])
  }
}
