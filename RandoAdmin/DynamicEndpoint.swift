import Foundation

class DynamicEndpoint {
  private var params: Params
  private var endpoint: Endpoint

  private var pathParts: [String] {
    return endpoint.rawValue.characters.split { $0 == "/"}.map(String.init)
  }

  private var replacedParts: [String] {
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

  init(endpoint: Endpoint, params: Params) {
    (self.endpoint, self.params) = (endpoint, params)
  }
}
