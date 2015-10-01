import UIKit

class LoadingController: UIViewController {
  let store = PlayerStore()

  override func viewDidLoad() {
    super.viewDidLoad()
    NSNotificationCenter.defaultCenter().addObserver(self, selector: NSSelectorFromString("teamStoreUpdated"), name: "TeamStoreDidUpdate", object: TeamStore.sharedInstance)
    TeamStore.sharedInstance.update()
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let
      navController = segue.destinationViewController as? UINavigationController,
      playersController = navController.topViewController as? PlayersController
      where segue.id == .ShowPlayers else {
        return
    }

    playersController.store = store
  }

  func teamStoreUpdated() {
    store.delegate = self
    store.update()
  }
}

extension LoadingController: PlayerStoreDelegate {
  func didUpdatePlayers() {
    performSegueWithIdentifier(.ShowPlayers, sender: self)
  }
}