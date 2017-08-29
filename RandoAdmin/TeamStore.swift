import Foundation

class TeamStore {
    static let sharedInstance = TeamStore()

    var teams = [Team]()
    var router: Router

    class func withId(id: Int) -> Team {
        return sharedInstance.teams.filter({ $0.id == id }).first!
    }

    init(router: Router = ApiRouter.instance) {
        self.router = router
    }

    func update() {
//        router.get(.Teams, params: [:], completion: handleResponse)
    }

    func handleResponse(response: Response) {
        guard response.isSuccess, let json = response.json else { return }
        parseJSON(json: json)
//        NSNotificationCenter.defaultCenter().postNotificationName("TeamStoreDidUpdate", object: self, userInfo: nil)
    }

    private func parseJSON(json: JSON) {
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
