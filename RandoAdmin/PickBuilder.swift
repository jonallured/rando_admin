import Foundation

protocol PickBuilderDelegate {
    func didFinishCreating(picks: [Pick])
}

class PickBuilder {
    var delegate: PickBuilderDelegate?

    func create(player: Player, team: Team) {
        let endpoint = Endpoint.createPick(playerId: player.id, teamId: team.id, weekNumber: player.nextWeekNumber)
        Router.hit(endpoint, handler: handleResponse)
    }

    private func handleResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            else { return }

        let attributes = PickAttributes.fromJSON(json: json)
        let picks = attributes.map { Pick($0) }

        DispatchQueue.main.async {
            self.delegate?.didFinishCreating(picks: picks)
        }
    }
}
