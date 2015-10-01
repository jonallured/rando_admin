import Foundation

class TeamStore {
  static let sharedInstance = TeamStore()

  var teams = [Team]()
  var router: Router

  init(router: Router = ApiRouter()) {
    self.router = router
  }

  func update() {
    router.get(.Teams, completion: handleResponse)
  }

  func handleResponse(response: Response) {
    guard let json = response.json where response.isSuccess else { return }
    parseJSON(json)
    NSNotificationCenter.defaultCenter().postNotificationName("TeamStoreDidUpdate", object: self, userInfo: nil)
  }

  private func parseJSON(json: JSON) {
    if let teamsJSON = json as? [[String: AnyObject]] {
      typealias TeamAttributes = (id: Int, name: String)

      let attributes: [TeamAttributes?] = teamsJSON.map { teamJSON in
        guard let id = teamJSON["id"] as? Int,
          let name = teamJSON["name"] as? String else { return nil }
        return (id, name)
      }

      teams = attributes.flatMap({ $0 }).map { Team(id: $0.id, name: $0.name) }
    }
  }
}