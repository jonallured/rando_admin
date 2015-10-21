import Foundation

enum Endpoint: String {
  case ActiveTeams = "/current_season/weeks/:week_number/active_teams"
  case RandoPicks  = "/current_season/rando_picks"
  case Players     = "/current_season/characters"
  case Picks       = "/current_season/picks"
  case Teams       = "/teams"
}

class DynamicEndpoint {
  var params: Params
  var endpoint: Endpoint

  var pathParts: [String] {
    return endpoint.rawValue.characters.split { $0 == "/"}.map(String.init)
  }

  var replacedParts: [String] {
    guard let params = params as? [String: String] else { return [] }

    return pathParts.map { part in
      guard part.characters.first == ":" else { return part }
      let key = String(part.characters.dropFirst())
      return params[key]
      }.flatMap({ $0 })
  }

  var path: String? {
    if replacedParts.count == pathParts.count {
      return "/" + replacedParts.joinWithSeparator("/")
    } else {
      return nil
    }
  }

  init(endpoint: Endpoint ,params: Params) {
    (self.endpoint, self.params) = (endpoint, params)
  }
}
