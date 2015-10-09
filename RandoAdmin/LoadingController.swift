import UIKit

class LoadingController: UIViewController {
  let rando = Rando()
  let store = PlayerStore()

  override func viewDidLoad() {
    super.viewDidLoad()
    NSNotificationCenter.defaultCenter().addObserver(self, selector: NSSelectorFromString("teamStoreUpdated"), name: "TeamStoreDidUpdate", object: TeamStore.sharedInstance)
    TeamStore.sharedInstance.update()
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    guard let tabController = segue.destinationViewController as? TabBarController else { return }
    tabController.passRando(rando)
    tabController.passStore(store)
  }

  func teamStoreUpdated() {
    rando.delegate = self
    rando.update()
  }
}

extension LoadingController: RandoDelegate {
  func didUpdateRando() {
    store.delegate = self
    store.update()
  }
}

extension LoadingController: PlayerStoreDelegate {
  func didUpdatePlayers() {
    performSegueWithIdentifier(.ShowTabBar, sender: self)
  }
}
