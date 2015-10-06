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
    typealias PickAttributes = (weekNumber: Int, teamId: Int)

    guard let
      json = response.json,
      picksJSON = json as? [[String: AnyObject]]
      where response.code == 201 else { return }

    let pickAttributes: [PickAttributes?] = picksJSON.map { pickJSON in
      guard let
        week = pickJSON["week_number"] as? Int,
        teamId = pickJSON["team_id"] as? Int
        else { return nil }

      return (week, teamId)
    }

    let picks = pickAttributes.flatMap({ $0 }).map { Pick(weekNumber: $0.weekNumber, teamId: $0.teamId) }
    self.delegate?.didFinishCreating(picks)
  }
}
