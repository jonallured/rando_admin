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
    router.get(.Players, params: [:], completion: handleResponse)
  }

  func handleResponse(response: Response) {
    guard let json = response.json where response.isSuccess else { return }

    let attributes = PlayerAttributes.fromJSON(json)
    players = attributes.map { Player($0) }.sort()

    dispatch_async(dispatch_get_main_queue()) {
      self.delegate?.didUpdatePlayers()
    }
  }
}
