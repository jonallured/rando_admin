import Foundation

protocol RandomPickDelegate {
  func didGenerate()
  func didSave()
}

class RandomPick {
  var delegate: RandomPickDelegate?
  var rando: Rando?
  var team: Team?
  var router: Router

  var teamName: String {
    return team?.name ?? ""
  }

  init(router: Router = ApiRouter.instance) {
    self.router = router
  }

  func generate(rando: Rando) {
    self.rando = rando

    let params = ["week_number": String(rando.nextWeekNumber)]
    if let path = DynamicEndpoint(endpoint: .ActiveTeams, params: params).path {
      router.get(path, params: params, completion: handleActiveTeamsResponse)
    }
  }

  func save() {
    guard let weekNumber = rando?.nextWeekNumber, teamId = team?.id else { return }
    let params = ["week_number" : weekNumber, "team_id": teamId]
    router.post(.RandoPicks, params: params, completion: handleSaveRandoPickResponse)
  }
}

extension RandomPick {
  private func handleActiveTeamsResponse(response: Response) {
    guard let teamIds = response.json as? [Int] where response.isSuccess else { return }

    let index = Int(arc4random_uniform(UInt32(teamIds.count)))
    let teamId = teamIds[index]

    team = TeamStore.withId(teamId)

    dispatch_async(dispatch_get_main_queue()) {
      self.delegate?.didGenerate()
    }
  }

  private func handleSaveRandoPickResponse(response: Response) {
    guard let json = response.json where response.code == 201 else { return }

    let attributes = PickAttributes.fromJSON(json)
    rando?.picks = attributes.map { Pick($0) }

    dispatch_async(dispatch_get_main_queue()) {
      self.delegate?.didSave()
    }
  }
}
