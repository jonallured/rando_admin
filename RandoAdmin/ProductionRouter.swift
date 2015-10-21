import Foundation

struct ApiRouter {
  static var instance: Router {
    return ProductionRouter()
  }
}

class ProductionRouter: Router {
  var baseURL = "https://rando-pool.herokuapp.com/api"

  func get(endpoint: Endpoint, params: Params, completion: (Response) -> Void) {
    get(endpoint.rawValue, params: params, completion: completion)
  }

  func get(path: String, params: Params, completion: (Response) -> Void) {
    let path = baseURL + path
    Request.get(path, params: params, completion: completion)
  }

  func post(endpoint: Endpoint, params: Params, completion: (Response) -> Void) {
    post(endpoint.rawValue, params: params, completion: completion)
  }

  func post(path: String, params: Params, completion: (Response) -> Void) {
    let path = baseURL + path
    Request.post(path, params: params, completion: completion)
  }
}
