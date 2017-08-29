import Foundation

protocol PickBuilderDelegate {
    func didFinishCreating(picks: [Pick])
}

class PickBuilder {
    var delegate: PickBuilderDelegate?
    var router: Router

    init(router: Router = ApiRouter.instance) {
        self.router = router
    }

    func create(player: Player, team: Team) {
//        let params: Params = [
//            "character_id": player.id,
//            "team_id"     : team.id,
//            "week_number" : player.nextWeekNumber
//        ]
//
//        router.post(.Picks, params: params, completion: handleResponse)
    }

    func handleResponse(response: Response) {
        guard response.code == 201, let json = response.json else { return }

        let attributes = PickAttributes.fromJSON(json: json)
        let picks = attributes.map { Pick($0) }

        DispatchQueue.main.async {
            self.delegate?.didFinishCreating(picks: picks)
        }
    }
}
