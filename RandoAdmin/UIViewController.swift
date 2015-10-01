import UIKit

extension UIViewController {
  func performSegueWithIdentifier(segueIdentifier: SegueIdentifier, sender: AnyObject?) {
    performSegueWithIdentifier(segueIdentifier.rawValue, sender: sender)
  }
}