import Foundation

typealias PlayerAttributes = (id: Int, name: String, picks: [Pick])
typealias PickAttributes = (weekNumber: Int, teamId: Int)

class JSONParser {
  class func players(json: [JSON]) -> [PlayerAttributes] {
    let attributes: [PlayerAttributes?] = json.map { playerJSON in
      guard let
        id = playerJSON["id"] as? Int,
        name = playerJSON["player_name"] as? String,
        picksJSON = playerJSON["picks"] as? [[String: AnyObject]]
        else { return nil }

      let pickAttributes = JSONParser.picks(picksJSON)
      let picks = pickAttributes.map { Pick(weekNumber: $0.weekNumber, teamId: $0.teamId) }
      return (id, name, picks)
    }

    return attributes.flatMap({$0})
  }

  class func picks(json: [JSON]) -> [PickAttributes] {
    let attributes: [PickAttributes?] = json.map { pickJSON in
      guard let
        week = pickJSON["week_number"] as? Int,
        teamId = pickJSON["team_id"] as? Int
        else { return nil }

      return (week, teamId)
    }

    return attributes.flatMap({$0})
  }
}
