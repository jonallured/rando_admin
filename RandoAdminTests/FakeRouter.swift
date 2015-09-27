import Foundation
@testable import RandoAdmin

class FakeRouter: Router {
    var json: [[String: AnyObject]] = [
        [ "id": 1, "player_name": "Jon Allured" ],
        [ "id": 2, "player_name": "Jess Allured" ],
        [ "id": 3, "player_name": "Jack Allured" ]
    ]
    
    func get(endpoint: Endpoint, completion: (Response) -> Void) {
        let response = Response(code: 200, json: json)
        completion(response)
    }
}