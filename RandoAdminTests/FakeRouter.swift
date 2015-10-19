import Foundation

struct ApiRouter {
  static var instance: Router {
    return FakeRouter()
  }
}

class FakeRouter: Router {
  var playerJSON: [[String: AnyObject]] = [
    [ "id": 1, "player_name": "Jon Allured", "picks": [] ],
    [ "id": 2, "player_name": "Jess Allured", "picks": [] ],
    [ "id": 3, "player_name": "Jack Allured", "picks": [] ]
  ]

  var picksJSON = [[String: AnyObject]]()

  func get(endpoint: Endpoint, params: Params, completion: (Response) -> Void) {
    let response = Response(code: 200, json: playerJSON)
    completion(response)
  }

  func post(endpoint: Endpoint, params: Params, completion: (Response) -> Void) {
    let response = Response(code: 201, json: picksJSON)
    completion(response)
  }
}