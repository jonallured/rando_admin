import XCTest
@testable import RandoAdmin

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

  func testUpdateReplacesPlayers() {
    let store = PlayerStore(router: FakeRouter())
    store.update()
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