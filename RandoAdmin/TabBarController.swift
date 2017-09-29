import UIKit

class TabBarController: UITabBarController {
    private var topViewControllers: [UIViewController] {
        let controllers = viewControllers ?? []
        let navControllers = controllers.flatMap { $0 as? UINavigationController }
        return navControllers.flatMap { $0.topViewController }
    }

    private var playersController: PlayersController? {
        return topViewControllers.flatMap { $0 as? PlayersController }.first
    }

    private var randoPicksController: RandoPicksController? {
        return topViewControllers.flatMap { $0 as? RandoPicksController }.first
    }

    func passStore(store: PlayerStore) {
        playersController?.store = store
    }
    
    func passRando(rando: Rando) {
        randoPicksController?.rando = rando
    }
}
