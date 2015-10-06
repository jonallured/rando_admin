import Foundation

typealias PickAttributes = (weekNumber: Int, teamId: Int)

class JSONParser {
  class func picks(json: [[String: AnyObject]]) -> [PickAttributes] {
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
