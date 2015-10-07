import Foundation

class PlayerAttributes {
  var id: Int
  var name: String
  var picks: [Pick]

  init(id: Int, name: String, picks: [Pick]) {
    (self.id, self.name, self.picks) = (id, name, picks)
  }

  class func fromJSON(json: [JSON]) -> [PlayerAttributes] {
    let attributes: [PlayerAttributes?] = json.map { playerJSON in
      guard let
        id = playerJSON["id"] as? Int,
        name = playerJSON["player_name"] as? String,
        picksJSON = playerJSON["picks"] as? [[String: AnyObject]]
        else { return nil }

      let pickAttributes = PickAttributes.fromJSON(picksJSON)
      let picks = pickAttributes.map { Pick(weekNumber: $0.weekNumber, teamId: $0.teamId) }
      return PlayerAttributes(id: id, name: name, picks: picks)
    }

    return attributes.flatMap({$0})
  }
}
