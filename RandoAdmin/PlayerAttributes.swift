import Foundation

class PlayerAttributes {
    var id: Int
    var name: String
    var out: Bool
    var picks: [Pick]

    init(id: Int, name: String, out: Bool, picks: [Pick]) {
        (self.id, self.name, self.out, self.picks) = (id, name, out, picks)
    }

    class func fromJSON(json: Any) -> [PlayerAttributes] {
        guard let json = json as? [[String: AnyObject]] else { return [] }

        let attributes: [PlayerAttributes?] = json.map { playerJSON in
            guard let id = playerJSON["id"] as? Int,
                let name = playerJSON["player_name"] as? String,
                let out = playerJSON["out"] as? Bool,
                let picksJSON = playerJSON["picks"]
                else { return nil }

            let pickAttributes = PickAttributes.fromJSON(json: picksJSON)
            let picks = pickAttributes.map { Pick(weekNumber: $0.weekNumber, teamId: $0.teamId) }
            return PlayerAttributes(id: id, name: name, out: out, picks: picks)
        }

        return attributes.flatMap({$0})
    }
}
