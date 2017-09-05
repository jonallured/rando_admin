import Foundation

class PickAttributes {
    var weekNumber: Int
    var teamId: Int

    init(weekNumber: Int, teamId: Int) {
        (self.weekNumber, self.teamId) = (weekNumber, teamId)
    }

    class func fromJSON(json: Any) -> [PickAttributes] {
        guard let json = json as? [[String: AnyObject]] else { return [] }

        let attributes: [PickAttributes?] = json.map { pickJSON in
            guard let weekNumber = pickJSON["week_number"] as? Int,
                let teamId = pickJSON["team_id"] as? Int
                else { return nil }
            
            return PickAttributes(weekNumber: weekNumber, teamId: teamId)
        }

        return attributes.flatMap({$0})
    }
}
