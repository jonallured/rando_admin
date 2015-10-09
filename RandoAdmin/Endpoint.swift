import Foundation

enum Endpoint: String {
  case RandoPicks = "/current_season/rando_picks"
  case Players    = "/current_season/characters"
  case Picks      = "/current_season/picks"
  case Teams      = "/teams"
}
