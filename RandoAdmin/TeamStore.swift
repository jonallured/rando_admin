import Foundation

class TeamStore {
    static let sharedInstance = TeamStore()

    var teams = [Team]()

    class func withId(id: Int) -> Team {
        return sharedInstance.teams.filter({ $0.id == id }).first!
    }

    func update() {
        Router.hit(Endpoint.teams, handler: handleResponse)
    }

    private func handleResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard let data = data,
            let json = try? JSONSerialization.jsonObject(with: data, options: [])
            else { return }

        parseJSON(json: json)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "TeamStoreDidUpdate"), object: self)
    }

    private func parseJSON(json: Any) {
        guard let teamsJSON = json as? [[String: AnyObject]] else { return }
        typealias TeamAttributes = (id: Int, name: String)

        let attributes: [TeamAttributes] = teamsJSON.flatMap { teamJSON in
            guard let id = teamJSON["id"] as? Int,
                let name = teamJSON["name"] as? String else { return nil }
            return (id, name)
        }

        teams = attributes.map { Team(id: $0.id, name: $0.name) }.sorted()
    }
}
