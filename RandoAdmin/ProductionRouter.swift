import Foundation

class ProductionRouter: Router {
  var baseURL = "https://rando-pool.herokuapp.com/api"

  func get(endpoint: Endpoint, completion: (Response) -> Void) {
    let path = baseURL + endpoint.rawValue
    Request.get(path, completion: completion)
  }

  func post(endpoint: Endpoint, params: Params, completion: (Response) -> Void) {
    let path = baseURL + endpoint.rawValue
    Request.post(path, params: params, completion: completion)
  }
}
