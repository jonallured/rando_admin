import UIKit

class TabBarController: UITabBarController {
  func passStore(store: PlayerStore) {
    guard let
      navController = viewControllers?.first as? UINavigationController,
      playersController = navController.topViewController as? PlayersController else { return }

    playersController.store = store
  }
}
