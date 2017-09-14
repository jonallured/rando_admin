import Foundation

enum Endpoint {
    case activeTeams(weekNumber: Int)
    case createPick(playerId: Int, teamId: Int, weekNumber: Int)
    case createRandoPick(teamId: Int, weekNumber: Int)
    case listRandoPicks
    case players
    case teams

    var data: Data? {
        switch self {
        case .createPick(let playerId, let teamId, let weekNumber):
            let params = [
                "character_id": playerId,
                "team_id": teamId,
                "week_number": weekNumber
            ]
            let body = try? JSONSerialization.data(withJSONObject: params, options: [])
            return body
        case .createRandoPick(let teamId, let weekNumber):
            let params = [
                "team_id": teamId,
                "week_number": weekNumber
            ]
            let body = try? JSONSerialization.data(withJSONObject: params, options: [])
            return body
        default:
            return nil
        }
    }

    var method: String {
        switch self {
        case .activeTeams, .listRandoPicks, .players, .teams:
            return "GET"
        case .createPick, .createRandoPick:
            return "POST"
        }
    }

    var path: String {
        switch self {
        case .activeTeams(let weekNumber):
            return "/current_season/weeks/\(weekNumber)/active_teams"
        case .createPick:
            return "/current_season/picks"
        case .createRandoPick, .listRandoPicks:
            return "/current_season/rando_picks"
        case .players:
            return "/current_season/characters"
        case .teams:
            return "/teams"
        }
    }
}
