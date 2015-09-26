import XCTest
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

class PlayerStoreTests: XCTestCase {
    func testStartsEmpty() {
        let store = PlayerStore(router: FakeRouter())
        XCTAssertTrue(store.players.isEmpty)
    }
    
    func testUpdateWithDataCreatesPlayers() {
        let store = PlayerStore(router: FakeRouter())
        store.update()
        XCTAssertEqual(store.players.count, 3)
    }
    
    func testUpdateSkipsBadJSON() {
        let router = FakeRouter()
        router.json = [
            [ "garbage": true ]
        ]
        
        let store = PlayerStore(router: router)
        store.update()
        XCTAssertEqual(store.players.count, 0)
    }
}