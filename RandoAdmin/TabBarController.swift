import UIKit

class TabBarController: UITabBarController {
    func passStore(store: PlayerStore) {
        guard let navController = viewControllers?.first as? UINavigationController,
            let playersController = navController.topViewController as? PlayersController
            else { return }
        
        playersController.store = store
    }
    
    func passRando(rando: Rando) {
        guard let navController = viewControllers?.last as? UINavigationController,
            let randoPicksController = navController.topViewController as? RandoPicksController
            else { return }
        
        randoPicksController.rando = rando
    }
}
