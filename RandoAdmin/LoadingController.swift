import UIKit

class LoadingController: UIViewController {
  let store = PlayerStore()

  override func viewDidLoad() {
    super.viewDidLoad()

    store.delegate = self
    store.update()
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let
      navController = segue.destinationViewController as? UINavigationController,
      playersController = navController.topViewController as? PlayersController
      where segue.identifier == "ShowPlayers" else {
        return
    }

    playersController.store = store
  }
}

extension LoadingController: PlayerStoreDelegate {
  func didUpdatePlayers() {
    performSegueWithIdentifier("ShowPlayers", sender: self)
  }
}