import XCTest
@testable import RandoAdmin

class FakeRouter: Router {
    func get(endpoint: Endpoint, completion: (Response) -> Void) {
        let json = [
            [ "id": 1, "player_name": "Jon Allured" ],
            [ "id": 2, "player_name": "Jess Allured" ],
            [ "id": 3, "player_name": "Jack Allured" ]
        ]
        
        let response = Response(code: 200, json: json)
        completion(response)
    }
}

class PlayerStoreTests: XCTestCase {
    let store = PlayerStore(router: FakeRouter())
    
    func testStartsEmpty() {
        XCTAssertTrue(store.players.isEmpty)
    }
    
    func testUpdateWithDataCreatesPlayers() {
        store.update()
        XCTAssertEqual(store.players.count, 3)
    }
}