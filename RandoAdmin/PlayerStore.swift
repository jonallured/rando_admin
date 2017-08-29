import Foundation

protocol PlayerStoreDelegate {
    func didUpdatePlayers()
}

class PlayerStore {
    var delegate: PlayerStoreDelegate?
    var players = [Player]()
    var router: Router

    init(router: Router = ApiRouter.instance) {
        self.router = router
    }

    func update() {
        //        router.get(.Players, params: [:], completion: handleResponse)
    }

    func handleResponse(response: Response) {
        guard response.isSuccess, let json = response.json else { return }

        let attributes = PlayerAttributes.fromJSON(json: json)
        players = attributes.map { Player($0) }.sorted()

        DispatchQueue.main.async {
            self.delegate?.didUpdatePlayers()
        }
    }
}
