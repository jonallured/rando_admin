import Foundation

protocol RandomPickDelegate {
    func didGenerate()
    func didSave()
}

class RandomPick {
    var delegate: RandomPickDelegate?
    var rando: Rando?
    var team: Team?

    var teamName: String {
        return team?.name ?? ""
    }

    func generate(rando: Rando) {
        self.rando = rando
        let endpoint = Endpoint.activeTeams(weekNumber: rando.nextWeekNumber)
        Router.hit(endpoint, handler: handleActiveTeamsResponse)
    }

    func save() {
        guard let weekNumber = rando?.nextWeekNumber,
            let teamId = team?.id
            else { return }

        let endpoint = Endpoint.createRandoPick(teamId: teamId, weekNumber: weekNumber)
        Router.hit(endpoint, handler: handleSaveRandoPickResponse)
    }
}

extension RandomPick {
    private func handleActiveTeamsResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: []),
            let teamIds = json as? [Int]
            else { return }

        let index = Int(arc4random_uniform(UInt32(teamIds.count)))
        let teamId = teamIds[index]
        team = TeamStore.withId(id: teamId)

        self.delegate?.didGenerate()
    }

    private func handleSaveRandoPickResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            else { return }

        let attributes = PickAttributes.fromJSON(json: json)
        rando?.picks = attributes.map { Pick($0) }

        self.delegate?.didSave()
    }
}
