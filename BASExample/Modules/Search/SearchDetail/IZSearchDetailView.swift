import UIKit
import WebKit

final class IZSearchDetailViewController: UIViewController, IZPresenterProtocol {
  // MARK: - Private property

  private var item: IZSearchModel

  private lazy var webView: WKWebView = {
    let webView = WKWebView()
    webView.navigationDelegate = self
    webView.allowsBackForwardNavigationGestures = true
    return webView
  }()

  // MARK: - Init

  init(item: IZSearchModel) {
    self.item = item
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Life circle

  override func viewDidLoad() {
    super.viewDidLoad()
    createUI()
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    webView.load(.init(url: item.link))
  }
}

// MARK: - Private

private extension IZSearchDetailViewController {
  func createUI() {
    view.backgroundColor = .white
    title = item.title

    view.addSubview(webView)
    webView.translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      webView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
      webView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
      webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    ])
  }
}

// MARK: - WKNavigationDelegate

extension IZSearchDetailViewController: WKNavigationDelegate { }
