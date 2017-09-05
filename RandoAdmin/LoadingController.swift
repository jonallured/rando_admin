import UIKit

class LoadingController: UIViewController {
    let rando = Rando()
    let store = PlayerStore()

    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "TeamStoreDidUpdate"), object: TeamStore.sharedInstance, queue: nil, using: teamStoreUpdated)
        TeamStore.sharedInstance.update()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tabController = segue.destination as? TabBarController else { return }
        tabController.passRando(rando: rando)
        tabController.passStore(store: store)
    }

    func teamStoreUpdated(notification: Notification) {
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
