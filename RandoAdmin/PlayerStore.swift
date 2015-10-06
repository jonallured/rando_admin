import Foundation

protocol PlayerStoreDelegate {
  func didUpdatePlayers()
}

class PlayerStore {
  var delegate: PlayerStoreDelegate?
  var players = [Player]()
  var router: Router

  init(router: Router = ApiRouter()) {
    self.router = router
  }

  func update() {
    router.get(.Players, completion: handleResponse)
  }

  func handleResponse(response: Response) {
    guard let
      json = response.json,
      playersJSON = json as? [JSON]
      where response.isSuccess else { return }

    let attributes = JSONParser.players(playersJSON)
    players = attributes.map { Player(id: $0.id, name: $0.name, picks: $0.picks) }

    dispatch_async(dispatch_get_main_queue()) {
      self.delegate?.didUpdatePlayers()
    }
  }
}
