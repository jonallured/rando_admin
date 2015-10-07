import Foundation

protocol PickBuilderDelegate {
  func didFinishCreating(picks: [Pick])
}

class PickBuilder {
  var delegate: PickBuilderDelegate?
  var router: Router

  init(router: Router = ApiRouter()) {
    self.router = router
  }

  func create(player: Player, team: Team) {
    let params: Params = [
      "character_id": player.id,
      "team_id"     : team.id,
      "week_number" : player.nextWeekNumber
    ]

    router.post(.Picks, params: params, completion: handleResponse)
  }

  func handleResponse(response: Response) {
    guard let json = response.json as? [JSON] where response.code == 201 else { return }

    let attributes = PickAttributes.fromJSON(json)
    let picks = attributes.map { Pick($0) }

    dispatch_async(dispatch_get_main_queue()) {
      self.delegate?.didFinishCreating(picks)
    }
  }
}
