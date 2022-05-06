import UIKit

extension UILabel {
  static func plain(
    text: String,
    textAlgnment: NSTextAlignment = .left
  ) -> UILabel {
    let label = UILabel()
    label.text = text
    label.textAlignment = textAlgnment
    return label
  }
}
