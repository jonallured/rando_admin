import Foundation

enum Endpoint: String {
  case Players = "/current_season/characters"
  case Picks   = "/current_season/picks"
  case Teams   = "/teams"
}