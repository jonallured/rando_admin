import UIKit

class AddRandoPickController: UIViewController {
  let randomPick = RandomPick()

  var rando: Rando! {
    didSet {
        randomPick.generate(rando: rando)
    }
  }

  @IBOutlet weak var teamNameLabel: UILabel!
  @IBOutlet weak var saveButtonItem: UIBarButtonItem!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

  @IBAction func savePressed(sender: AnyObject) {
    randomPick.save()
  }

  override func viewDidLoad() {
    randomPick.delegate = self
  }
}

extension AddRandoPickController: RandomPickDelegate {
  func didGenerate() {
    activityIndicator.stopAnimating()
    teamNameLabel.text = randomPick.teamName
    teamNameLabel.isHidden = false
    saveButtonItem.isEnabled = true
  }

  func didSave() {
    dismiss(animated: true, completion: nil)
  }
}
