import UIKit

class LoadingController: UIViewController {
    let rando = Rando()
    let store = PlayerStore()

    override func viewDidLoad() {
        super.viewDidLoad()
        //    NSNotificationCenter.defaultCenter().addObserver(self, selector: NSSelectorFromString("teamStoreUpdated"), name: "TeamStoreDidUpdate", object: TeamStore.sharedInstance)
        TeamStore.sharedInstance.update()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tabController = segue.destination as? TabBarController else { return }
        tabController.passRando(rando: rando)
        tabController.passStore(store: store)
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
        performSegueWithIdentifier(segueIdentifier: .ShowTabBar, sender: self)
    }
}
