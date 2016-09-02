import XCTest

class PlayerAttributesTests: XCTestCase {
  func testWithBadJSON() {
    let json: JSON = 0
    let attrs = PlayerAttributes.fromJSON(json)

    XCTAssertEqual(attrs.count, 0)
  }

  func testWithEmptyJSON() {
    let json = [JSON]()
    let attrs = PlayerAttributes.fromJSON(json)

    XCTAssertEqual(attrs.count, 0)
  }

  func testWithBadKeys() {
    let json: [JSON] = [[ "key": "value" ]]
    let attrs = PlayerAttributes.fromJSON(json)

    XCTAssertEqual(attrs.count, 0)
  }

  func testWithGoodKeys() {
    let json: [JSON] = [[
      "id": 1,
      "player_name": "Jack Allured",
      "out": false,
      "picks": []
      ]]

    let attrs = PlayerAttributes.fromJSON(json)

    XCTAssertEqual(attrs.count, 1)

    let playerAttrs = attrs.first
    XCTAssertEqual(playerAttrs?.id, 1)
    XCTAssertEqual(playerAttrs?.name, "Jack Allured")
    XCTAssertEqual(playerAttrs?.picks.count, 0)
  }
}
