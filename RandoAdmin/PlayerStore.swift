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
    guard let json = response.json where response.isSuccess else { return }
    parseJSON(json)

    dispatch_async(dispatch_get_main_queue()) {
      self.delegate?.didUpdatePlayers()
    }
  }

  private func parseJSON(json: JSON) {
    if let playersJSON = json as? [[String: AnyObject]] {
      typealias PlayerAttributes = (id: Int, name: String, picks: [Pick])

      let attributes: [PlayerAttributes?] = playersJSON.map { playerJSON in
        guard let
          id = playerJSON["id"] as? Int,
          name = playerJSON["player_name"] as? String,
          picksJSON = playerJSON["picks"] as? [[String: AnyObject]]
          else { return nil }

        let pickAttributes = JSONParser.picks(picksJSON)
        let picks = pickAttributes.map { Pick(weekNumber: $0.weekNumber, teamId: $0.teamId) }
        return (id, name, picks)
      }

      players = attributes.flatMap({ $0 }).map { Player(id: $0.id, name: $0.name, picks: $0.picks) }
    }
  }
}