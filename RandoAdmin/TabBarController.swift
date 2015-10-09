import UIKit

class TabBarController: UITabBarController {
  func passStore(store: PlayerStore) {
    guard let
      navController = viewControllers?.first as? UINavigationController,
      playersController = navController.topViewController as? PlayersController else { return }

    playersController.store = store
  }

  func passRando(rando: Rando) {
    guard let
      navController = viewControllers?.last as? UINavigationController,
      randoPicksController = navController.topViewController as? RandoPicksController else { return }

    randoPicksController.rando = rando
  }
}
