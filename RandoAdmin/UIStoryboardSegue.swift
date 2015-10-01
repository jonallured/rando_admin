import UIKit

extension UIStoryboardSegue {
  var id: SegueIdentifier? {
    return SegueIdentifier(rawValue: identifier ?? "")
  }
}