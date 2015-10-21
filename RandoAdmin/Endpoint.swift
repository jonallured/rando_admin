import Foundation

enum Endpoint: String {
  case ActiveTeams = "/current_season/weeks/:week_number/active_teams"
  case RandoPicks  = "/current_season/rando_picks"
  case Players     = "/current_season/characters"
  case Picks       = "/current_season/picks"
  case Teams       = "/teams"
}
